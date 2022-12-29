% Stochastic gradient descent for linear systems function file

function [x, x_err, y_err, time_err] = SGD_COMP2(A, sol, y, maxiter, alpha)

% Parameters
    % A: m x n data matrix
    % sol: value to approximate (true soln of Ax = y)
    % y : true solution vector
    % maxiter: Iteration count stopping condition (this is our m, row count)
    % alpha: Iteration step size

[~,n] = size(A);
x = zeros(n,1);
iter = 1; % total iteration count

y_err(iter) = [norm(A*x - y)^2];
x_err(iter) = [norm(sol - x)^2];
time_err(iter) = [0];

while(iter < maxiter)  
    
    tic

    % choose row without replacement
    if mod(iter-1, 100) == 0
        t = 1; % index of permuted rows
        perm_rows = randperm(100); % array containing numbers 1,2,3,...,m randomly permuted each call
    end
    
    A(perm_rows(t),:) = A(perm_rows(t),:);

    x = x - alpha*((A(perm_rows(t),:).')*(A(perm_rows(t),:)*x - y(perm_rows(t)))); % perm_rows(t) returns a random row of A

    t = t + 1;
    iter = iter + 1;

    y_err(iter,1) = (norm(A*x - y))^2;
    x_err(iter,1) = (norm(sol - x))^2;
    time_err(iter,1) = toc;
    
end
end