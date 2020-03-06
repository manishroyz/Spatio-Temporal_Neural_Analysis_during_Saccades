% MAIN VARIABLES FOR CORRELATION
ct_data = neuron_info_tables.ct_signrank;
ct_kernel = neuron_info_tables.ct_kernel_signrank;
euc_dist = neuron_info_tables.RF1_FP1_eucledian_dist;

%% Check correlation between ct_kernel & ct_data
%% %%%%%%%%%%%%%%%%%%%%%  ct_data v/s ct_kernel  %%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(ct_data, ct_kernel);
f(1) = figure;
scatter(ct_data, ct_kernel);
xlabel('ct(data)'); ylabel('ct(kernel)')
title([neuron_categ ':  ct_data v/s ct_kernel  ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
mx = max(max(ct_data), max(ct_kernel));
axis([0 mx 0 mx]);


%% %%%%%%%%%%%%%%%%%%%%%  distance v/s ct_signrank  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(euc_dist, ct_kernel);
f(2) = figure;  
% subplot(1,3,1);
scatter(euc_dist, ct_kernel);
xlabel('Distance'); ylabel('ct(kernel)');
title([neuron_categ ':  distance v/s ct(kernel)   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');

% Creating folder for respective model
parent = [pwd '\'];
dir = ['Figures'];
if exist([parent dir], 'dir')== 0
    mkdir(parent, dir);       
end

% savefig(f, [parent dir '\' char(neuron_categ) 'correlation_plots_' '.fig']);