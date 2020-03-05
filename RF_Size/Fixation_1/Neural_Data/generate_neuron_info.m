function neuron_info_tables = generate_neuron_info(coordination, centers1)

    %% Filtering the 3 columns id, ch and un to form the neuron names
    neuro_ids = [coordination(:,9) coordination(:,10) coordination(:,11)];
    % Concatenating to form the neuron name based on the 3 columns
    for i = 1:size(neuro_ids,1)
        % To handle extra "0" in resp file names eg. 3 is "_03_"
        if neuro_ids(i,2) < 10        
            n = "resp_" + neuro_ids(i,1)+ "_0" +neuro_ids(i,2) + "_" +neuro_ids(i,3);
            neuron_resp_file_names(i,1) = n;
        else        
            n ="resp_" + neuro_ids(i,1)+ "_" +neuro_ids(i,2) + "_" +neuro_ids(i,3);
            neuron_resp_file_names(i,1) = n;
        end    
    end

    % Generating neuron_info table with cols : [ "neuron_name" "RF1x" "RF1y"]
    neuron_info_tables = table(neuron_resp_file_names);
    neuron_info_tables.V4_or_MT = coordination(:,7);
    neuron_info_tables.recording_hemisphere = coordination(:,8);
    neuron_info_tables.RF1x = coordination(:,1);
    neuron_info_tables.RF1y = coordination(:,2);
    neuron_info_tables.RF1_FP1_dist_from_centers1 = centers1(:,1);
    
    eucledian_dist = sqrt(coordination(:,1).^2 + coordination(:,2).^2);
    neuron_info_tables.RF1_FP1_eucledian_dist = eucledian_dist;


end

