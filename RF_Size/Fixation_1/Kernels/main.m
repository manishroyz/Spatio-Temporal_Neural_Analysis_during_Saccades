
clear all;

%% Load final data -- from Neural Data Analysis (version 5)
dirname = 'C:\Users\Kaiser\Manish Gcloud\Spatio-Temporal_Neural_Analysis_during_Saccades\RF_Size\Fixation_1\Neural_Data\Data_Files';

%% CHOOSE SWITCH CRITERIA TO LOAD REQUIRED DATA
% flag = 1; % V4 NEURONS
flag = 2; % MT NEURONS

switch flag
    case 1
        filename = 'neuron_info_tables_v4_FINAL' ;
        outDataFile = 'V4_neurons';    
    case 2
        filename = 'neuron_info_tables_mt_FINAL';
        outDataFile = 'MT_neurons';
end
path = [dirname '\' filename '.mat'];
load(path);


%% Load params for each neuron and compute area using the params sx,sy
% dirname = 'J:\Datasets\skrn_just_param';
dirname2 = 'J:\Datasets\skrn_just_param';
switch flag
    case 1
        neuron_data = neuron_info_tables_v4 ;   
    case 2
        neuron_data = neuron_info_tables_mt ;   
end

n = size(neuron_data,1);
rf_size = zeros(n,1);
%% looping over all neurons(V4?MT) based on loaded neuron_data
for indx = 1: n  
    tic
    
    %% Loading skrns_params for respective neuron
    file_string = char(neuron_data.neuron_resp_file_names(indx));
    file_string = file_string(6:end)
    expression = '_(0)';
    replace = '_';
    file_string2 = regexprep(file_string,expression, replace)
    
    filename2 = ['neuron_' file_string2 '_param'];
    path = [dirname2 '\' char(filename2) '.mat'];
    load(path);
    
    %% Slicing sx, sy values for entire time range
    params_sx = squeeze(params(1,:,3));
    params_sy = squeeze(params(1,:,5));
    params_sx_sy = params_sx.*params_sy;
    
    sx_sy_avgd = get_avgd_params_frm_random_bins(params_sx_sy);    
    rf_size(indx) = sx_sy_avgd * pi;    
    
    toc
end

% folderName = [pwd '\Output_Data\'];
% save(fullfile(folderName, ['rf_size_from_skrns_params_' outDataFile '.mat']), 'rf_size');

perform_correlation_and_plots(rf_size,neuron_data, outDataFile);



