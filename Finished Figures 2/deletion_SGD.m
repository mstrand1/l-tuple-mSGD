function [xhat, approx_err] = deletion_SGD(A_tilde, x, y, maxiter, alpha)

% SGD with missing data deletion

% Parameters
    % A: Coefficients matrix for linear system
    % x,y: True solution Ax = y
    % maxiter: Iteration count stopping condition
    % p: probability that Q-tuple will be blocked out
    % ell: size of missing tuples
    % alpha: Iteration step size

[m, n] = size(A_tilde);
x_0 = zeros(n, 1);
xhat = x_0;

if isempty(A_tilde)
    approx_err = [];
    return
end

iter = 1;

while iter < maxiter

    % Randomly chose row for masking and update
    i = randi(m);
    Ai_tilde = A_tilde(i,:);

    % Call g function 
    gxk = (Ai_tilde.'*(Ai_tilde*xhat -y(i)));

    % Calculate x_t1, the update
    x_t1 = xhat - alpha * gxk;

    xhat = x_t1;


    % calcualte x error and append to error array
    x_e = norm(x - xhat)^2;
    approx_err(1, iter) = x_e;
    iter = iter + 1;
end