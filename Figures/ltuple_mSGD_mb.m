function [xhat, approx_err] = ltuple_mSGD_mb(n, x_star, maxiter, p, ell, batch, alpha)

% l-tuples stochastic gradient descent algorithm 

% Parameters
    % A: Coefficients matrix for linear system
    % x,y: True solution Ax = y
    % maxiter: Iteration count stopping condition
    % p: probability that l-tuple will be blocked out
    % ell: size of missing tuples
    % batch: batch size
    % alpha: Iteration step size

m = maxiter;
% initialize x_0 to be a vector with m rows and 1 column (mx1)
x_0 = zeros(n, 1);
xhat = x_0;

% current_iter: the number of iteration it's currently on
iter = 1;

% error array
approx_err = zeros(1, maxiter);


% Create Matrix L for the update function
L = zeros(n,n);
for i = 1:ell:n-mod(n,ell)
    v = zeros(1,n);
    v(i:i+ell-1) = 1;
    L = L + (v' * v);
end

while iter < maxiter

    % Define batch of random rows
    A_batch = randn([batch,n]);
    A_tilde_batch = tuple_mask_mb(A_batch, p, ell, batch);

    y_batch = A_batch*x_star;

    % Call g function 
    gxk = (1/p^2)*(A_tilde_batch'*(A_tilde_batch*xhat-p*y_batch))-((1-p)/p^2)*(L.*(A_tilde_batch'*A_tilde_batch))*xhat;

    % Calculate x_t1, the update
    x_t1 = xhat - alpha * gxk;

    xhat = x_t1;

    % Calculate data for algorithm

    % calcualte x error and append to error array
    x_e = norm(x_star - xhat)^2;
    approx_err(1, iter) = x_e;

    % update the current iteration
    iter = iter + 1;
end
end