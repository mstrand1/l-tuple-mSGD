% Michael Strand
% Math 199B - UCI

function [x, x_err, y_err, time_err] = mSGD_MODDEDMASK(A, sol, y, p, maxiter, analytics, ell, alpha)
% Stochastic gradient descent for linear systems function file

% A: data matrix with elements aij ~ Bern(p)
% sol: true x (for analytics only)
% y: solution vector
% p: probability aij is present
% maxIter: maximum iterations
% analytics: 0 for false, 1 to display graphs

[m,n] = size(A);
x = zeros(n,1);
iter = 1; % total iteration count
y_err = [norm(A*x - y)^2];
x_err = [norm(sol - x)^2];
time_err = [0];

while(y_err(end) > 10^(-15) && iter < maxiter)  
    
    tic
    
    % choose row without replacement
    if mod(iter-1,m) == 0
        t = 1; % index of permuted rows
        perm_rows = randperm(m); % array containing numbers 1,2,3,...,m randomly permuted each call
    end

    ai = A(perm_rows(t),:); % random row of A tilde
    ai_t = tuple_mask_R(ai, p, ell);
    

    gxk = (1/p^2)*(ai_t.'*(ai_t*x - p*y(perm_rows(t)))) - ((1-p)/(p^2))*diag(diag(ai_t.'*ai_t))*x;
    %alpha = 10^-2;
    %alpha = 8*10^-4;

    x = x - alpha*gxk;

    t = t + 1;
    iter = iter + 1;

    y_err(iter,1) = (norm(A*x - y))^2;
    x_err(iter,1) = (norm(sol - x))^2;
    time_err(iter,1) = toc; 
end

if analytics == 1

    figure;

    subplot(2,2,1);
    semilogy(y_err);
    xlabel('Iteration');
    ylabel('Error');
    title('y Error: || Axi - y ||');
    
    if iter >= 1000
        subplot(2,2,2);
        semilogy([iter-1001:iter-1], y_err(end-1001:end-1));
        xlabel('Iteration');
        ylabel('Error');
        title('Error, last 1000 iterations')
    end
    
    subplot(2,2,3);
    semilogy(x_err);
    xlabel('Iteration');
    ylabel('Error');
    title('x Error: || x(actual) - x(ith prediction) ||');


    subplot(2,2,4);
    semilogy(movmean(x_err,20));
    xlabel('Iteration');
    ylabel('Error');
    title('x Error: Moving average (k=20)');
end
end