clear all;

tic
%% Load final data -- from Neural Data Analysis (version 5)
dirname1 = 'C:\Users\Kaiser\Manish Gcloud\Spatio-Temporal_Neural_Analysis_during_Saccades\RF_Size\Fixation_1\Neural_Data\Data_Files';

%% CHOOSE SWITCH CRITERIA TO LOAD REQUIRED DATA
% flag = 1; % V4 NEURONS
flag = 2; % MT NEURONS

switch flag
    case 1
        filename = 'neuron_info_tables_v4_FINAL' ;
        neuron_categ = 'V4_neurons';    
    case 2
        filename = 'neuron_info_tables_mt_FINAL';
        neuron_categ = 'MT_neurons';
end
path = [dirname1 '\' filename '.mat'];
load(path);


%% Load params for each neuron and compute area using the params sx,sy
% dirname = 'J:\Datasets\skrns';
dirname2 = 'J:\Datasets\resp';
switch flag
    case 1
        neuron_info_tables = neuron_info_tables_v4 ;   
    case 2
        neuron_info_tables = neuron_info_tables_mt ;   
end

sz = size(neuron_info_tables,1);
psths_neurons = zeros(sz,150);
p_vals_neurons = zeros(sz,130);
log_inv_p_vals_neurons = zeros(sz,130);
% figure;
%% looping over all neurons(V4/MT) based on loaded neuron_data
for indx = 1: sz   
   tic
    filename = neuron_info_tables.neuron_resp_file_names(indx);
    path = [dirname2 '\' char(filename) '.mat'];
    load(path);    
    
    % RF Probe locations for the neuron (p1, q1)
    neuron_info_tables.p1(indx) = p1;
    neuron_info_tables.q1(indx) = q1; 
    
    %% PSTH from resp CORRECT ORDER OF NANMEAN 4->1 dimension
% % % %     psth_resp = squeeze(nanmean(nanmean(resp(1:80,p1,q1,:,:),4),1))';
% % % %     psth_resp = psth_resp.*1000;     
    
    %% Spike-Train-matrix & PSTH for RF probe p1,q1 from paresp
    spike_train_matrix = squeeze(paresp1(p1,q1,:,:));
    psth = nanmean(spike_train_matrix,1);
    psth = psth.*1000;
    
    %% Compare PSTH from resp and paresp1
% %     figure; 
% %     plot(psth_resp);
% %     hold on;
% %     plot(psth); 
    
    %% Smoothening PSTH
    win = 5;
% % % %     psth_resp_smoothened = gauss_smooth(psth_resp,win);      
    psth_smoothened = gauss_smooth(psth,win);
    
    %% Compare smoothened PSTH from resp and paresp1
% %     figure; 
% %     plot(psth_resp_smoothened);
% %     hold on;          
% %     plot(psth_smoothened );      

    psths_neurons(indx,:) = psth_smoothened; 
    
    %% Computing ct based on signrank of baeline and sliding window    
    base = nanmean(spike_train_matrix(:, 1:40),2);
    for t=1:130      
        % 'alpha', 1e-20 -- significance level of p = 1e-20 
        % --> log_inv_p = log10(1/1e-20) = log10(10^20)= 20
        sliding_window = nanmean(spike_train_matrix(:, t:t+20),2);
        % 'tail','right':  For a two-sample test, the alternate hypothesis states the 
        %data in x – y come from a distribution with median greater than 0.
        [p_val(t), h_val(t)] = signrank(sliding_window, base, 'alpha', 1e-7, 'tail','right');
    end
    
    log_inv_p = log10(1./p_val);  
    
    p_vals_neurons(indx,:) = p_val;
    log_inv_p_vals_neurons(indx,:) = log_inv_p;
    
    ct_signrank = find(h_val == 1, 1);         
% % %     max_log_inv_p = max(log_inv_p,[],2);      
% % %     ct_signrank = find( log_inv_p > (max_log_inv_p-2), 1); 

    if isempty(ct_signrank)
        ct_signrank = find(log_inv_p > 2, 1); 
    end
    
    %% t2p from psth smoothened
    [max_psth, t2p] = max(psth_smoothened); 
    
    %% Assigning ct & t2p
    neuron_info_tables.ct_signrank(indx) = ct_signrank; 
    neuron_info_tables.t2p(indx) = t2p; 
    
    %% Visual inspection
%     figure; 
%     subplot(1,3,1);
%     plot(log_inv_p);  
%     title('log10(1/p)', 'Interpreter', 'None');
%     
%     subplot(1,3,2);
%     plot(psth,'c'); 
%     hold on;   
%     plot(psth_smoothened ,'LineWidth',2); 
%     if ct_signrank ~= -1
%         plot(ct_signrank, psth_smoothened(ct_signrank), 'ro', 'LineWidth',2, 'MarkerSize',5);
%     end
%     title(['ct: ' num2str(ct_signrank) '  t2p: ' num2str(t2p)]);
%     
%     subplot(1,3,3);
%     imagesc(spike_train_matrix);
%     title('Spike Train across trials')
    
    toc
end

toc

% Creating folder for respective model
parent = [pwd '\'];
dir = 'Mat_Files';
if exist([parent dir], 'dir')== 0
    mkdir(parent, dir);       
end

% save([parent dir '\Data_ct_signrank_' neuron_categ 'p_val_10e-7__V2' '.mat'], 'psths_neurons', 'neuron_info_tables', 'p_vals_neurons', 'log_inv_p_vals_neurons');








