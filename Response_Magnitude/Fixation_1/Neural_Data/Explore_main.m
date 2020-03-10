clear all;

tic
%% Load final data -- from Neural Data Analysis (version 5)
dirname1 = 'C:\Users\Kaiser\Manish Gcloud\Neurons_Analysis\Neural_Data\RF analysis\RF_contours_based_on_threshold\VERSION_5\Data_Files';

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
% dirname2 = 'C:\Users\Kaiser\Manish Gcloud\Neurons_Analysis\Main_Data\skrns';
dirname2 = 'C:\Users\Kaiser\Manish Gcloud\Neurons_Analysis\resp';
switch flag
    case 1
        neuron_info_tables = neuron_info_tables_v4 ;   
    case 2
        neuron_info_tables = neuron_info_tables_mt ;   
end

sz = size(neuron_info_tables,1);
psths_neurons = zeros(sz,150);

test_idxs = [34 23 41 129 126 128 227 224 263 268]
% figure;
%% looping over all neurons(V4/MT) based on loaded neuron_data
for indx = test_idxs
    tic
    filename = neuron_info_tables.neuron_resp_file_names(indx);
    path = [dirname2 '\' char(filename) '.mat'];
    load(path);    
    
    % RF Probe locations for the neuron (p1, q1)
    neuron_info_tables.p1(indx) = p1;
    neuron_info_tables.q1(indx) = q1; 
    
    %% Spike-Train-matrix & PSTH for RF probe p1,q1 from paresp
    spike_train_matrix = squeeze(paresp1(p1,q1,:,:));
    psth = nanmean(spike_train_matrix,1);
    psth = psth.*1000;    
 
    %% Smoothening PSTH
    win = 5;
    psth_smoothened = gauss_smooth(psth,win);  

    psths_neurons(indx,:) = psth_smoothened; 
    
    %% Computing Gain
    
    %%%%%%%%%%%%%%%    Method 1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % base = mean(baseline window vector)
    % peak = max(psth)
    % gain = peak - base
    
    base = mean(psth_smoothened(1:40));
    peak = max(psth_smoothened);
    gain = peak - base;
    
    % Normalization
    psth_normalized = (psth_smoothened-base)/gain;
    
    neuron_info_tables.base(indx) = base;
    neuron_info_tables.peak(indx) = peak;
    neuron_info_tables.gain_method_1(indx) = gain;
    
        
    %% Visual inspection
    figure;
    plot(psth_smoothened);
    title(['base:' num2str(base) ' peak:' num2str(peak) ' gain:' num2str(gain)]);
% %     figure;
% %     plot(psth_normalized);   
    
    toc
end

toc

% Creating folder for respective model
parent = [pwd '\'];
dir = 'Mat_Files';
if exist([parent dir], 'dir')== 0
    mkdir(parent, dir);       
end

switch flag
    case 1
    case 2
%         save([parent dir '\Data__Gain_' neuron_categ '__v1.mat'], 'neuron_info_tables', 'psths_neurons');

end






