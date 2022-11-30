function [x, x_err, y_err, time_err] = SGD_COMP2(A, sol, y, maxiter, analytics, alpha)
% Stochastic gradient descent for linear systems function file

% A: data matrix
% y: solution vector
% analytics: 0 for false, 1 to display graphs
% sol: true x (for analytics only)

[~,n] = size(A);
x = zeros(n,1);
iter = 1; % total iteration count
%alpha_denom = norm(A,'fro')^2;

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

    %alpha = 1/norm(A(perm_rows(t),:))^2;
    x = x - alpha*((A(perm_rows(t),:).')*(A(perm_rows(t),:)*x - y(perm_rows(t)))); % perm_rows(t) returns a random row of A

    % iterator mayhem
    t = t + 1;
    iter = iter + 1;

    y_err(iter,1) = (norm(A*x - y))^2;
    x_err(iter,1) = (norm(sol - x))^2;
    time_err(iter,1) = toc;
    
end

if analytics == 1

    figure;

    subplot(1,3,1);
    semilogy(y_err);
    xlabel('Iteration');
    ylabel('Error');
    title('y Error: || Axi - y ||');
    
    if iter >= 1000
        subplot(1,3,2);
        semilogy([iter-1001:iter-1], y_err(end-1001:end-1));
        xlabel('Iteration');
        ylabel('Error');
        title('Error, last 1000 iterations')
    end

    subplot(1,3,3);
    semilogy(x_err);
    xlabel('Iteration');
    ylabel('Error');
    title('x Error: || x(actual) - x(ith prediction) ||');
end
end
