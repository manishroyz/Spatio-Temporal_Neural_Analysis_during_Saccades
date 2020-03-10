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
        filename2 = 'Data__Response_Magnitude_MT_neurons__baseline_1-30_ms';
        path = [dirname1 '\' filename2 '.mat']; 
        load(path);
end


%% MAIN VARIABLES FOR CORRELATION
resp_mag = neuron_info_tables.resp_magnitude;
euc_dist = neuron_info_tables.RF1_FP1_eucledian_dist;
RF1x = abs(neuron_info_tables.RF1x);
RF1y = abs(neuron_info_tables.RF1y);
peak = neuron_info_tables.peak;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%  distance v/s peak  %%%%%%%%%%%%%%%%%%%%%%%%%%%
% [r,p] = corr(euc_dist, peak);
% f(1) = figure;  
% % subplot(1,3,1);
% scatter(euc_dist, peak);
% xlabel('Distance'); ylabel('peak');
% title([neuron_categ ':  distance v/s peak   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% % % % mx = max(max(euc_dist), max(ct_signrank));
% % % % axis([0 mx 0 mx]);


%% %%%%%%%%%%%%%%%%%%%%%  distance v/s Response Magnitude  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(euc_dist, resp_mag);
f = figure;  
subplot(1,3,1);
scatter(euc_dist, resp_mag);
xlabel('Distance'); ylabel('gain');
title([neuron_categ ':  distance v/s gain   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(euc_dist), max(ct_signrank));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%%  RF1x v/s Response Magnitude  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(RF1x, resp_mag);
subplot(1,3,2);
scatter(RF1x, resp_mag);
xlabel('RF1x'); ylabel('gain');
title([neuron_categ ':  RF1x v/s gain   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(euc_dist), max(ct_signrank));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%%  RF1y v/s Response Magnitude %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(RF1y, resp_mag);
subplot(1,3,3);
scatter(RF1y, resp_mag);
xlabel('RF1y'); ylabel('gain');
title([neuron_categ ':  RF1y v/s gain   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(euc_dist), max(ct_signrank));
% axis([0 mx 0 mx]);


% Creating folder for respective model
parent = [pwd '\'];
dir = ['Figures'];
if exist([parent dir], 'dir')== 0
    mkdir(parent, dir);       
end

savefig(f, [parent dir '\' char(neuron_categ) 'Correlation_plots' '.fig']);
