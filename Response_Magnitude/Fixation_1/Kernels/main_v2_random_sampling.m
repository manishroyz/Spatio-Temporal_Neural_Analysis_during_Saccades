clear all;

tic
%% Load final data -- after Gain analysis on Kernels v1
dirname1 = 'C:\Users\Kaiser\Manish Gcloud\Spatio-Temporal_Neural_Analysis_during_Saccades\Response_Magnitude\Fixation_1\Neural_Data\Mat_Files';
%% CHOOSE SWITCH CRITERIA TO LOAD REQUIRED DATA
% flag = 1; % V4 NEURONS
flag = 2; % MT NEURONS

switch flag
    case 1
        filename = '' ;
        neuron_categ = 'V4_neurons';    
    case 2
        filename = 'Data__Response_Magnitude_MT_neurons__baseline_1-30_ms';
        neuron_categ = 'MT_neurons';
        
end
path = [dirname1 '\' filename '.mat'];
load(path);

% clearvars -except neuron_info_tables

sz = size(neuron_info_tables,1);
% Directory path for skrns
dirname2 = 'C:\Users\Kaiser\Manish Gcloud\Neurons_Analysis\Main_Data\skrns';

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
    skrn_fp1 = squeeze(skrn(1,rf1_in_probes(1), rf1_in_probes(2), 1:400, :));
% % % % %     skrn_fp1 = skrn_fp1.*1000;
    
    
    
    %% Computing Gain
    
    %%%%%%%%%%%%%%%    Method 2: Random Sampling   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    [resp_mag_kernels_mean, resp_mag_kernels_median] = compute_resp_magnitude_bootstrapping(skrn_fp1);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 3d plots of kernels over different t2s as done earlier in ct_eccentriciyt analysis
    % Stacked 3d plOts for seeing the changing pattern across time
% %     figure
% %     subplot(1,2,1);
% %     grid on; hold on;
% %     row = size(skrn_fp1,1);
% %     col = size(skrn_fp1,2);
% %     delay_axis = 1:1:col;
% %     for i = 1:row
% %         time_axis = i+ones(col,1);
% %         plot3(delay_axis,time_axis,skrn_fp1(i,:)); 
% %         view(3); %Changing viewpoint to 3rd axis
% %     %     pause;
% %     end
% %     xlabel('Tau');
% %     ylabel('Time');
% %     zlabel('skernels');  
% %     title(['Mean: ' num2str(gain_kernels_mean) '  Median: ' num2str(gain_kernels_median)]);
% %   
% %     
% %     subplot(1,2,2);
% %     plot(psths_neurons(indx,:));
% %     title(['PSTH: ' 'gain: ' num2str(neuron_info_tables.gain_method_1(indx))]);
% % % %     Enlarge figure to full screen.
% %     set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    %% Assigning to neuron_info
    neuron_info_tables.resp_mag_kernels_median_rand(indx) = resp_mag_kernels_median;
    neuron_info_tables.resp_mag_kernels_mean_rand(indx) = resp_mag_kernels_mean;

      
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
%         save([parent dir '\Kernel__Response_magnitude_' neuron_categ '__rand_sampling.mat'], 'neuron_info_tables', 'psths_neurons');

end



