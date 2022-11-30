function [x, x_err, time_err] = SGD_COMP(n, sol, p, ell, maxiter, analytics, alpha)
% Stochastic gradient descent for linear systems function file

% A: data matrix
% y: solution vector
% analytics: 0 for false, 1 to display graphs
% sol: true x (for analytics only)
x = zeros(n,1);
iter = 1; % total iteration count
%alpha_denom = norm(A,'fro')^2;

x_err(iter) = [norm(sol - x)^2];
time_err(iter) = [0];

while(iter < maxiter)  
    
    tic

   % w = randi(maxiter);

   % Ai = A(iter,:);

    Ai = randn([1,n]); % generate random sample (1 of maxiter. Here, maxiter = m the number of rows)
    y(iter) = Ai*sol; % calculate y for this sample
    Ai_tilde = tuple_mask_R(Ai, p, ell); % tuple mask the sample


    %alpha = 1/norm(A(perm_rows(t),:))^2;
    x = x - alpha*((Ai_tilde.')*(Ai_tilde*x - y(iter))); % perm_rows(t) returns a random row of A

    % iterator mayhem
    iter = iter + 1;

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