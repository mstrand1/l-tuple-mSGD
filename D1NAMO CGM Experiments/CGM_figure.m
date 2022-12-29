%% CGM application

clc;clear
% Initializations

maxiter = 10^6;
p = 0.5939726027397261;
ell = 2;
alpha = 2*10^-5;
RUNS = 1;

A = readmatrix('A_tilde1_nomask.csv');
y_glucose = readmatrix('y_glucose1.csv');
xls = readmatrix('xls1.csv');

xls = xls(2:length(xls),:);
y_glucose = y_glucose(2:length(y_glucose),:);
A = A(2:height(A),:);

yhat = A*pinv(A)*y_glucose;

A_tilde = readmatrix('A_tilde1_mask.csv');
A_tilde = A_tilde(2:height(A_tilde),:);

% iid mask
for i = 1:RUNS
    [~, ~, approx_err_tsgd(i,:), ~] = ltuple_mSGD(A, xls, yhat, maxiter, p, ell, alpha);
    [~, ~, approx_err_msgd(i,:), ~] = mSGD(A, xls, yhat, maxiter, p, ell, alpha);

end

for j = 1:RUNS
    [~, ~, approx_err_sgd(j,:), ~] = SGD(A, xls, yhat, maxiter, p, ell, alpha);
end

% noise mask
for i = 1:RUNS
    [~, ~, approx_err_tsgd_noise(i,:), ~] = ltuple_mSGD_noise(A_tilde, xls, yhat, maxiter, p, ell, alpha);
    [~, ~, approx_err_msgd_noise(i,:), ~] = mSGD_noise(A_tilde, xls, yhat, maxiter, p, alpha);

end

for j = 1:RUNS
    [~, ~, approx_err_sgd_noise(j,:), ~] = SGD_noise(A_tilde, xls, yhat, maxiter, alpha);
end

Ai_tilde_iid = zeros(365, 10);

for i = 1:365
    Ai = A(i,:);
    Ai_tilde_iid(i,:) = tuple_mask_R(Ai, p, ell);
end

% for visual plot
A_tilde(A_tilde==0)=-100;
Ai_tilde_iid(Ai_tilde_iid==0)=-100;

ax1=subplot(1,6,1:2);
semilogy(approx_err_tsgd,'-', 'DisplayName','l-tuple mSGD','Linewidth', 5.5, 'Color', 'b');
hold on
semilogy(approx_err_msgd, ':','DisplayName','mSGD','Linewidth', 5.5, 'Color', 'r');
semilogy(approx_err_sgd,'--','DisplayName','Vanilla SGD','Linewidth', 5.5, 'Color', '#EDB120');
xlabel('Iterations','FontSize',24);
ylabel('Error','FontSize',24);
legend show

ax2=subplot(1,6, 3);
imagesc(Ai_tilde_iid);

ax3=subplot(1,6,4:5);
semilogy(approx_err_tsgd_noise,'-', 'DisplayName','l-tuple mSGD','Linewidth', 3.5, 'Color', 'b');
hold on
semilogy(approx_err_msgd_noise, ':','DisplayName','mSGD','Linewidth', 3.5, 'Color', 'r');
semilogy(approx_err_sgd_noise,'--','DisplayName','Vanilla SGD','Linewidth', 3.5, 'Color', '#EDB120');
xlabel('Iterations','FontSize',24);
legend show

ax4=subplot(1, 6,6);
imagesc(A_tilde)