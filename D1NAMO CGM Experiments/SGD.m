% SGD algorithm for CGM application

function [xhat, approx_err, resid_err, err_time] = SGD(A, x, y, maxiter, p, ell, alpha)

% Parameters
    % A: Coefficients matrix for linear system
    % x,y: True solution Ax = y
    % maxiter: Iteration count stopping condition
    % p: probability that l-tuple will be blocked out
    % ell: size of missing tuples
    % alpha: Iteration step size


[m, n] = size(A);

% initialize x_0 to be a vector with m rows and 1 column (mx1)
x_0 = zeros(n, 1);
xhat = x_0;

% current_iter: the number of iteration it's currently on
current_iter = 0;
iterations = zeros(1, maxiter);

% error array
approx_err = zeros(1, maxiter);
resid_err = zeros(1, maxiter);

% Record time
start_time = tic;
err_time = zeros(1, maxiter);


while current_iter < maxiter

    % Randomly chose row for masking and update
    i = randi(m);
    Ai = A(i,:);
    Ai_tilde = tuple_mask_R(Ai, p, ell);

    % Call g function 
    gxk = ( Ai_tilde' * (Ai_tilde * xhat - y(i)) );

    % Calculate x_t1, the update
    x_t1 = xhat - alpha * gxk;

    xhat = x_t1;

    % Calculate data for algorithm

    % update the current iteration
    current_iter = current_iter + 1;
    iterations(1, current_iter) = current_iter;

    % calcualte x error and append to error array
    x_e = norm(x - xhat)^2;
    approx_err(1, current_iter) = x_e;

    % calculate y error and append to y error array
    y_e = norm(A * xhat - y)^2;
    resid_err(1, current_iter) = y_e;

    % append the time it took for one iteration 
    err_time(1, current_iter) = toc(start_time);

end

disp('Approx error:');
disp(approx_err(end));