% Deletion, imputation (mean, regression, RF), and l-tuple SGD
% https://www.mathworks.com/help/bioinfo/ref/knnimpute.html

clc;clear

% Initializations

maxiter = 8*10^3;
m = maxiter;
n = 30;
x_star = randn(n,1);

p = 0.9;
alpha = 10^-3;
% WAS PREVIOUSLY 0.9*10^-3 - changed so all step sizes are the same


ell = 10;
del_error = [];
RUNS = 20;

for i = 1:RUNS
    [~, approx_err_tuple(i,:), A, A_tilde_zeros, A_tilde_del, A_tilde_col, A_tilde_knn, A_tilde_tsr, y, y_del, y_knn] = ltuple_MEGA_COMP(n, x_star, maxiter, p, ell, alpha);
   % [~, approx_err_del] = deletion_SGD(A_tilde_del, x_star, y_del, maxiter, alpha);
    %del_error = [del_error; approx_err_del];
    [~, approx_err_col(i,:)] = deletion_SGD(A_tilde_col, x_star, y, maxiter, alpha);
    [~, approx_err_knn(i,:)] = deletion_SGD(A_tilde_knn, x_star, y_knn, maxiter, alpha);
    [~, approx_err_msgd(i,:)] = mSGD_COMP(n, x_star, maxiter, p, ell, alpha);
    [~, approx_err_tsr(i,:)] = deletion_SGD(A_tilde_tsr, x_star, y, maxiter, alpha);
end


%semilogy(mean(del_error,1),'DisplayName','Deletion','Linewidth', 4, 'Linestyle', '-.');
semilogy(mean(approx_err_col,1),'DisplayName','Column mean imputation','Linewidth', 3, 'Linestyle', '-.');
hold on
semilogy(mean(approx_err_tsr,1),'DisplayName','Trimmed Scores Regression Imputation','Linewidth', 3,'Linestyle', ':');
semilogy(mean(approx_err_knn,1), 'DisplayName','k-NN column imputation','Linewidth', 3,'Linestyle', '-');
semilogy(mean(approx_err_msgd,1),'DisplayName','Vanilla mSGD','Linewidth', 3,'Linestyle', '--');
semilogy(mean(approx_err_tuple,1),'DisplayName','l-tuple mSGD','Linewidth', 3,'Linestyle', '-');
xlabel('Iteration','FontSize', 20);
ylabel('Error','FontSize', 20);
legend show
