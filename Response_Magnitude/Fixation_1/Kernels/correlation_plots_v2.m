clear all;

dirname1 = [ pwd '\Mat_Files'];

%% CHOOSE SWITCH CRITERIA TO LOAD REQUIRED PSTH DATA
% flag = 1; % V4 NEURONS
flag = 2; % MT NEURONS

switch flag
    case 1
% %         neuron_categ = 'V4_neurons'; 
        
    case 2
        neuron_categ = 'MT_neurons';          
        filename2 = 'Kernel__Response_magnitude_MT_neurons__rand_sampling';
        path = [dirname1 '\' filename2 '.mat']; 
        load(path);
end


%% MAIN VARIABLES FOR CORRELATION
resp_mag__data = neuron_info_tables.resp_magnitude;
euc_dist = neuron_info_tables.RF1_FP1_eucledian_dist;
RF1x = abs(neuron_info_tables.RF1x);
RF1y = abs(neuron_info_tables.RF1y);
resp_mag_kernels_mean = neuron_info_tables.resp_mag_kernels_mean_rand;
resp_mag_kernels_median = neuron_info_tables.resp_mag_kernels_median_rand;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%  gain_data v/s gain_kernels_mean (rand)  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(resp_mag__data, resp_mag_kernels_mean);
f(1) = figure;  
subplot(1,2,1);
scatter(resp_mag__data, resp_mag_kernels_mean);
xlabel('gain data'); ylabel('gain kernels mean  (rand)');
title([neuron_categ ':  gain data v/s gain kernels mean (rand)   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(gain_data), max(gain_kernels_mean));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%%  gain_data v/s gain_kernels_median  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(resp_mag__data, resp_mag_kernels_median);
% f(2) = figure;  
subplot(1,2,2);
scatter(resp_mag__data, resp_mag_kernels_median);
xlabel('gain data'); ylabel('gain kernels median (rand)');
title([neuron_categ ':  gain data v/s gain kernels median (rand)   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(gain_data), max(gain_kernels_median));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%%  dist v/s gain_kernels_mean  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(euc_dist, resp_mag_kernels_mean);
f(2) = figure;  
subplot(1,2,1);
scatter(euc_dist, resp_mag_kernels_mean);
xlabel('dist'); ylabel('gain kernels mean  (rand)');
title([neuron_categ ':  dist v/s gain kernels mean (rand)   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(euc_dist), max(gain_kernels_mean));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%%  dist v/s gain_kernels_median  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(euc_dist, resp_mag_kernels_median);
% f(3) = figure;  
subplot(1,2,2);
scatter(euc_dist, resp_mag_kernels_median);
xlabel('dist'); ylabel('gain kernels median  (rand)');
title([neuron_categ ':  dist v/s gain kernels median (rand)   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(euc_dist), max(gain_kernels_median));
% axis([0 mx 0 mx]);

% Creating folder for respective model
parent = [pwd '\'];
dir = ['Figures'];
if exist([parent dir], 'dir')== 0
    mkdir(parent, dir);       
end

% savefig(f, [parent dir '\' char(neuron_categ) 'Correlation_plots_Gain_Kernels__rand_sampling' '.fig']);

