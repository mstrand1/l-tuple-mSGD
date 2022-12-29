% msgd stochastic gradient descent algorithm 

function [xhat, x_err] = mSGD_COMP(n, x, maxiter, p, ell, alpha)

% Parameters
    % n: number of columns
    % x: value to approximate (soln of Ax = y)
    % maxiter: Iteration count stopping condition (this is our m, row count)
    % p: probability that Q-tuple will be blocked out
    % ell: size of missing tuples
    % alpha: Iteration step size

A_tilde = zeros(maxiter, n);
x_0 = zeros(n, 1);

xhat = x_0;

% current_iter: the number of iteration it's currently on
iter = 1;


while iter <= maxiter

    % Randomly chose row for masking and update

    Ai = randn([1,n]); % generate random sample (1 of maxiter. Here, maxiter = m the number of rows)
    y(iter) = Ai*x; % calculate y for this sample
    Ai_tilde = tuple_mask_R(Ai, p, ell); % tuple mask the sample

    A(iter,:) = Ai;
    A_tilde(iter,:) = Ai_tilde;

    % Call g function 
    gxk = (1/p^2) * ( Ai_tilde' * (Ai_tilde * xhat - p * y(iter)) ) - ((1-p)/p^2)*diag(diag(Ai_tilde.'*Ai_tilde))*xhat;

    % Calculate x_t1, the update
    x_t1 = xhat - alpha * gxk;

    xhat = x_t1;

    x_err(iter,1) = (norm(x - x_t1))^2;

    iter = iter + 1;

end