function sx_sy_avgd = get_avgd_params_frm_random_bins(params_sx_sy)

%   Detailed explanation goes here

    %% Generate sampling Matrix
    sampling_matrix = zeros(100, 50);
    for indx = 1:100
        sampling_matrix(indx,:) = randi(400,50,1)';
    end
    
    loop_cnt = size(sampling_matrix,1);
    neuron_data_sx_sy___rand_sampls = zeros(loop_cnt,1);
    %% Runing loop for #of rows in sampling_matrix
    for j = 1:loop_cnt
        time_pts_vector = sampling_matrix(j,:);
        sx_sy_sliced = params_sx_sy(time_pts_vector); 
        sx_sy_avgd = mean(sx_sy_sliced);
        neuron_data_sx_sy___rand_sampls(j) = sx_sy_avgd;
    end    
    
%     figure;
%     plot(neuron_data_sx_sy___rand_sampls);
   
    sx_sy_avgd = mean(neuron_data_sx_sy___rand_sampls);

    
end

