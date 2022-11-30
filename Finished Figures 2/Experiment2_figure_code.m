%% Uncertainty region plot for varying Q 
% https://www.mathworks.com/matlabcentral/fileexchange/58262-shaded-area-error-bar-plot

clc;clear

% Initializations

maxiter = 7*10^3;
m = maxiter;
n = 100;
x_star = randn(n,1);

alpha = 10^-3;
RUNS = 20;

p = [0.6, 0.7, 0.8, 0.9, 0.95, 0.999];
ell = [1, 10, 25];

x_erra1 = [];
x_erra2 = [];
x_erra3 = [];

x_errb1 = [];
x_errb2 = [];
x_errb3 = [];

x_errc1 = [];
x_errc2 = [];
x_errc3 = [];

x_errd1 = [];
x_errd2 = [];
x_errd3 = [];

x_erre1 = [];
x_erre2 = [];
x_erre3 = [];

x_errf1 = [];
x_errf2 = [];
x_errf3 = [];

CAP = 2000; % iteration start point to consolodate info

for i = 1:RUNS
    [~, x_erra1(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(1), ell(1), alpha); 
    [~, x_erra2(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(1), ell(2), alpha);
    [~, x_erra3(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(1), ell(3), alpha);
end

for i = 1:RUNS
    [~, x_errb1(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(2), ell(1), alpha); 
    [~, x_errb2(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(2), ell(2), alpha);
    [~, x_errb3(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(2), ell(3), alpha);
end

for i = 1:RUNS
    [~, x_errc1(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(3), ell(1), alpha); 
    [~, x_errc2(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(3), ell(2), alpha);
    [~, x_errc3(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(3), ell(3), alpha); 
end

for i = 1:RUNS
    [~, x_errd1(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(4), ell(1), alpha); 
    [~, x_errd2(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(4), ell(2), alpha);
    [~, x_errd3(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(4), ell(3), alpha);
end

for i = 1:RUNS
    [~, x_erre1(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(5), ell(1), alpha); 
    [~, x_erre2(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(5), ell(2), alpha);
    [~, x_erre3(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(5), ell(3), alpha);
end

for i = 1:RUNS
    [~, x_errf1(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(6), ell(1), alpha); 
    [~, x_errf2(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(6), ell(2), alpha);
    [~, x_errf3(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(6), ell(3), alpha);
end



% Plots this thang
fig = gcf;

optionsa.handle = fig;
optionsa.color_area = [179, 0, 0]./255;   % red
optionsa.color_line = [179, 0, 0]./255;
optionsa.alpha = 0.4;
optionsa.line_width = 2;
optionsa.x_axis = CAP:maxiter;     
optionsa.error = 'c95';

optionsb.handle = fig;
optionsb.color_area = [255, 0, 0]./255;   % blue
optionsb.color_line = [255, 0, 0]./255;
optionsb.alpha = 0.4;
optionsb.line_width = 2;
optionsb.x_axis = CAP:maxiter;     
optionsb.error = 'c95';

optionsc.handle = fig;
optionsc.color_area = [255, 51, 153]./255;   % gold
optionsc.color_line = [255, 51, 153]./255;
optionsc.alpha = 0.4;
optionsc.line_width = 2;
optionsc.x_axis = CAP:maxiter;     
optionsc.error = 'c95';

optionsd.handle = fig;
optionsd.color_area = [204, 0, 255]./255;   % gold
optionsd.color_line = [204, 0, 255]./255;
optionsd.alpha = 0.4;
optionsd.line_width = 2;
optionsd.x_axis = CAP:maxiter;     
optionsd.error = 'c95';

optionse.handle = fig;
optionse.color_area = [102, 0, 255]./255;   % gold
optionse.color_line = [102, 0, 255]./255;
optionse.alpha = 0.4;
optionse.line_width = 2;
optionse.x_axis = CAP:maxiter;     
optionse.error = 'c95';

optionsf.handle = fig;
optionsf.color_area = [0, 0, 153]./255;   % gold
optionsf.color_line = [0, 0, 153]./255;
optionsf.alpha = 0.4;
optionsf.line_width = 2;
optionsf.x_axis = CAP:maxiter;     
optionsf.error = 'c95';



ax1 = subplot(1,3,1);
plot_areaerrorbar(x_erra1(:,CAP:end), optionsa);
hold on
plot_areaerrorbar(x_errb1(:,CAP:end), optionsb);
hold on
plot_areaerrorbar(x_errc1(:,CAP:end), optionsc);
hold on
plot_areaerrorbar(x_errd1(:,CAP:end), optionsd);
hold on
plot_areaerrorbar(x_erre1(:,CAP:end), optionse);
hold on
plot_areaerrorbar(x_errf1(:,CAP:end), optionsf);
ylabel('Error','FontSize',20);
legend('','p = 0.60','','p = 0.70','','p = 0.80','','p = 0.90','','p = 0.95','','p = 0.99');

ax2 = subplot(1,3,2);
plot_areaerrorbar(x_erra2(:,CAP:end), optionsa);
hold on
plot_areaerrorbar(x_errb2(:,CAP:end), optionsb);
hold on
plot_areaerrorbar(x_errc2(:,CAP:end), optionsc);
hold on
plot_areaerrorbar(x_errd2(:,CAP:end), optionsd);
hold on
plot_areaerrorbar(x_erre2(:,CAP:end), optionse);
hold on
plot_areaerrorbar(x_errf2(:,CAP:end), optionsf);
ylabel('Error','FontSize',20);
legend('','p = 0.60','','p = 0.70','','p = 0.80','','p = 0.90','','p = 0.95','','p = 0.99');

ax3 = subplot(1,3,3);
plot_areaerrorbar(x_erra3(:,CAP:end), optionsa);
hold on
plot_areaerrorbar(x_errb3(:,CAP:end), optionsb);
hold on
plot_areaerrorbar(x_errc3(:,CAP:end), optionsc);
hold on
plot_areaerrorbar(x_errd3(:,CAP:end), optionsd);
hold on
plot_areaerrorbar(x_erre3(:,CAP:end), optionse);
hold on
plot_areaerrorbar(x_errf3(:,CAP:end), optionsf);
ylabel('Error','FontSize',20);
xlabel('Iterations','FontSize',20);
legend('','p = 0.60','','p = 0.70','','p = 0.80','','p = 0.90','','p = 0.95','','p = 0.99');
