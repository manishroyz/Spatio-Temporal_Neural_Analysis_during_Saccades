clear all;

tic
%% Load final "neuron_info_tables"  after Neural data analysis of final MT neurons set
dirname1 = 'C:\Users\Kaiser\Manish Gcloud\Spatio-Temporal_Neural_Analysis_during_Saccades\Latency\Fixation_1\Neural_Data\Mat_Files';
filename = 'Data_ct_signrank_MT_neuronsp_val_10e-7__V2' ;
path = [dirname1 '\' filename '.mat'];
load(path);
% clearvars -except neuron_info_tables

neuron_categ = 'MT_neurons'; 
sz = size(neuron_info_tables,1);
p_vals_neurons = zeros(sz,130);
log_inv_p_vals_neurons = zeros(sz,130);
% Directory path for skrns
dirname2 = 'J:\Datasets\skrns';

%% looping over all neurons(MT) based on loaded neuron_data
for indx = 1: sz   
    tic
    
    %% REGEX TO change filename to whats needed to access in skrns
    file_string = char(neuron_info_tables.neuron_resp_file_names(indx));
    file_string = file_string(6:end);
    expression = '_(0)';
    replace = '_';
    file_string2 = regexprep(file_string,expression, replace);
    
    filename2 = ['neuron_' file_string2 ];
    path = [dirname2 '\' char(filename2) '.mat'];
    load(path);
    
    %% Slicing skrn for fixation1
    skrn_f1 = squeeze(skrn(1,rf1_in_probes(1), rf1_in_probes(2), 1:400, :));
    skrn_f1 = skrn_f1.*1000;
    
    %% Computing ct based on signrank of baseline and sliding window    
    base = nanmean(skrn_f1(:, 1:40),2);
    for t=1:130      
        % 'alpha', 1e-20 -- significance level of p = 1e-20 
        % --> log_inv_p = log10(1/1e-20) = log10(10^20)= 20
        sliding_window = nanmean(skrn_f1(:, t:t+20),2);
        % 'tail','right':  For a two-sample test, the alternate hypothesis states the 
        %data in x – y come from a distribution with median greater than 0.
        [p_val(t), h_val(t)] = signrank(sliding_window, base, 'alpha', 1e-7, 'tail','right');
    end
    
    log_inv_p = log10(1./p_val);
    
    p_vals_neurons(indx,:) = p_val;
    log_inv_p_vals_neurons(indx,:) = log_inv_p;
    
    ct_kernel_signrank = find(log_inv_p >20, 1);         

    if isempty(ct_kernel_signrank)
        ct_kernel_signrank = -2; 
    end
    
    %% Assigning ct & t2p
    neuron_info_tables.ct_kernel_signrank(indx) = ct_kernel_signrank; 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Visual inspection
% %     figure; 
% %     subplot(1,3,1);
% %     plot(log_inv_p);  
% %     title('log10(1/p)', 'Interpreter', 'None');
% %     
% %     %%%%%%%%%%%%%%%
% %     % 3d plots of kernels over different t2s as done earlier in ct_eccentriciyt analysis
% %     
% %     %% Stacked 3d plOts for seeing the changing pattern across time
% % %     figure
% %     subplot(1,3,2);
% %     grid on; hold on;
% %     row = size(skrn_f1,1);
% %     col = size(skrn_f1,2);
% %     delay_axis = 1:1:col;
% %     for i = 1:row
% %         time_axis = i+ones(col,1);
% %         plot3(delay_axis,time_axis,skrn_f1(i,:)); 
% %         view(3); %Changing viewpoint to 3rd axis
% %     %     pause;
% %     end
% %     xlabel('Tau');
% %     ylabel('Time');
% %     zlabel('skernels');
% % 
% %     %% AVERAGED OVER MULTIPLE TIME POINTS RANGE (USING MATRIX s FROM ABOVE )
% %     % figure
% %     % plot(squeeze(mean(skrn(1,7,6,1:400,:),4)));
% %     % Plotting average of multiple time points
% %     subplot(1,3,3);
% %     plot(nanmean(skrn_f1,1));
% %     xlabel('Tau');
% %     ylabel('Delay averaged over all time instances for a specific probe location');
% %     % Enlarge figure to full screen.
% %     set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
      
   toc
end
toc


%% Filter neurons that didin't meet the hreshod criteria for finding ct
neuron_info_tables_MT_pre_kernel_filtering = neuron_info_tables;
final_filtered_indx = find(neuron_info_tables.ct_kernel_signrank ~= -2);
% Filtering out the required indexes
neuron_info_tables = neuron_info_tables(final_filtered_indx,:);
psths_neurons =  psths_neurons(final_filtered_indx,:);
p_vals_neurons = p_vals_neurons(final_filtered_indx,:);
log_inv_p_vals_neurons = log_inv_p_vals_neurons(final_filtered_indx,:);

% Creating folder for respective model
parent = [pwd '\'];
dir = 'Mat_Files';
if exist([parent dir], 'dir')== 0
    mkdir(parent, dir);       
end

% save([parent dir '\Kernel_ct_signrank_' neuron_categ '__FINAL' '.mat'], 'neuron_info_tables', 'p_vals_neurons', 'log_inv_p_vals_neurons', 'psths_neurons', 'neuron_info_tables_MT_pre_kernel_filtering');




