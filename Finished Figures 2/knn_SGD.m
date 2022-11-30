function [xhat, approx_err] = knn_SGD(A_tilde, x, y, maxiter, alpha)

% SGD with missing data deletion

% Parameters
    % A: Coefficients matrix for linear system
    % x,y: True solution Ax = y
    % maxiter: Iteration count stopping condition
    % alpha: Iteration step size

[m, n] = size(A_tilde);

% initialize x_0 to be a vector with m rows and 1 column (mx1)
x_0 = zeros(n, 1);
xhat = x_0;

% current_iter: the number of iteration it's currently on
iter = 1;


while iter < maxiter

    % Randomly chose row for masking and update
    i = randi(m);
    Ai_tilde = A_tilde(i,:);

    % Call g function 
    gxk = (Ai_tilde'*(Ai_tilde*xhat -y(i)));

    % Calculate x_t1, the update
    x_t1 = xhat - alpha * gxk;

    xhat = x_t1;

    % calcualte x error and append to error array
    x_e = norm(x - xhat)^2;
    approx_err(1, iter) = x_e;
    iter = iter + 1;

end