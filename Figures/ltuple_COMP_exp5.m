function [xhat, x_err, A, A_tilde_zeros, A_tilde_del, A_tilde_col, A_tilde_knn, A_tilde_tsr, y, y_del, y_knn] = ltuple_COMP_exp5(n, x, maxiter, p, ell, alpha)

% this function is for the imputation comparison figure. It generates A,y,
% and the different missing data imputed matrices for the vanilla sgd to
% iterate over. 

% Parameters
    % n: number of columns
    % x: value to approximate (true soln of Ax = y)
    % maxiter: Iteration count stopping condition (this is our m, row count)
    % p: probability that l-tuple will be blocked out
    % ell: size of missing tuples
    % alpha: Iteration step size

x_0 = zeros(n, 1);
xhat = x_0;
m = maxiter;
del = [];
tuple_col = zeros([1,n]);

iter = 1;

% Create Matrix L for the update function
L = zeros(n,n);
for i = 1:ell:n-mod(n,ell)
    v = zeros(1,n);
    v(i:i+ell-1) = 1;
    L = L + (v' * v);
end

while iter <= maxiter

    % generate A and y
    Ai = randn([1,n]); 
    Ai_NAN = Ai;
    A(iter,:) = Ai;
    y(iter) = Ai*x; 

    % Masking section: generates masking information for deletion, columns,
    % regression, knn, and the msgd algs.

    Di = ones([1,n]);
    flag = 0;

    for j = 1:ell:n-ell+1
        coin = binornd(1,p,1);
        if coin == 0

            Di(j:j+ell-1) = 0;
            tuple_col(j:j+ell-1) = tuple_col(j:j+ell-1) + 1; % jth tuple-column has another missing tuple
            Ai_NAN(j:j+ell-1) = NaN; % for knn and regression

            % flags row for deletion if it contains missing data
            if flag == 0
                del(end+1) = iter;
                flag = 1;
            end
        else
            continue
        end
    end
    
    % mask rows
    Ai_tilde_zeros =  Ai.*Di;
    D(iter,:) = Di;
    A_tilde_zeros(iter,:) = Ai_tilde_zeros;
    A_tilde_NAN(iter,:) = Ai_NAN;

    % Call g function for l-tuple msgd
    gxk = (1/p^2)*(Ai_tilde_zeros.'*(Ai_tilde_zeros *xhat-p*y(iter))) - ((1-p)/p^2)*(L .*(Ai_tilde_zeros.'*Ai_tilde_zeros))*xhat;
    x_t1 = xhat - alpha*gxk;
    xhat = x_t1;

    x_err(iter,1) = (norm(x - x_t1))^2;
 
    iter = iter + 1;

end

% Deletion mask
A_tilde_del = A;
A_tilde_del(del,:) = [];
y_del = y;
y_del(del) = [];

% Column mask
B = A_tilde_zeros;

col_mean = zeros([1,n]); % holds mean of each column 
S = sum(B); % sum of columns

% column means are the average of non-NaN (0) columns divided by the number
% of entries which contributed. Different columns will have different
% denominators which is why we count with tuple_col.

for q = 1:n
    col_mean(q) = S(q)/(m-tuple_col(q)); 
end

means_holder = zeros([m,n]);

for i = 1:m
    for j = 1:n
        if D(i,j) == 0
            means_holder(i,j) = col_mean(j);
        elseif D(i,j) == 1
            means_holder(i,j) = 0;
        end
    end
end

A_tilde_col = B + means_holder;


% KNN mask
% first check if all rows are NaN 
NaN_rows = [];
[NaN_rows, ~] = find(isnan(A_tilde_NAN));
NaN_rows = sort(unique(NaN_rows));
y_knn = y;

% TSR mask
[A_tilde_tsr, ~, ~, ~, ~, ~] = pcambtsr(A_tilde_NAN, n, 10^4, 10^-1);

% this checks if every row contains nan. Knn needs at least one complete
% row, so we add a row of zeros so the function doesn't break

%out = all(~isnan(A_tilde_NAN),2);
%y_knn = y_knn(out);
%A_tilde_NAN = A_tilde_NAN(out,:); % for nan - rows


if height(NaN_rows) == m
    A_tilde_NAN(end,:) = zeros([1,n]);
    y_knn(end,:) = 0;
    k = 1;
else
    k = min(m-height(NaN_rows), 5);
end

A_tilde_knn = A_tilde_NAN;

% use good row to replace all-nan rows

good_row = 1;

if all(isnan(A_tilde_knn(good_row,:)))
    b = 1;
end

while all(isnan(A_tilde_knn(good_row,:)))
    good_row = good_row + 1;
end

while sum(sum(isnan(A_tilde_knn))) > 0

    out = all(isnan(A_tilde_knn),2);
    y_knn(out) = y_knn(good_row);

    A_tilde_knn = knnimpute(A_tilde_knn, k);

    for j = 1:height(out)
        if out(j) == 1
            A_tilde_knn(j,:) = A_tilde_knn(good_row,:);
        end
    end
end


end