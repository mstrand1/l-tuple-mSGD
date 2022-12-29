% l-tuple msgd stochastic gradient descent algorithm 

function [xhat, x_err, A, A_tilde, y] = ltuple_COMP(n, x, maxiter, p, ell, alpha)

% Parameters
    % n: number of columns
    % x: value to approximate (true soln of Ax = y)
    % maxiter: Iteration count stopping condition (this is our m, row count)
    % p: probability that l-tuple will be blocked out
    % ell: size of missing tuples
    % alpha: Iteration step size

A = zeros(maxiter, n);
A_tilde = zeros(maxiter, n);
x_0 = zeros(n, 1);
y = zeros(maxiter, 1);

xhat = x_0;

iter = 1;



% Create Matrix L for the update function
L = zeros(n,n);
for i = 1:ell:n-mod(n,ell)
    v = zeros(1,n);
    v(i:i+ell-1) = 1;
    L = L + (v' * v);
end

while iter <= maxiter

    % Randomly chose row for masking and update
    Ai = randn([1,n]); % generate random sample (1 row of m = maxiter)
    Ai_tilde = tuple_mask_R(Ai, p, ell); % tuple mask the sample

    % Calculate y for this sample
    y(iter) = Ai*x; 
    
    % Update A and A_tilde
    A(iter,:) = Ai;
    A_tilde(iter,:) = Ai_tilde;

    % Call g function 
    gxk = (1/p^2) * (Ai_tilde' * (Ai_tilde * xhat - p * y(iter)) ) - (((1-p)/p^2))*(L .* (Ai_tilde'*Ai_tilde)) * xhat;

    % Calculate x_t1, the update
    x_t1 = xhat - alpha * gxk;

    xhat = x_t1;

    x_err(iter,1) = (norm(x - x_t1))^2;
 
    iter = iter + 1;

end