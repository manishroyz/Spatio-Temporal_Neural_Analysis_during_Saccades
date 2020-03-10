function [resp_mag_kernels_mean, resp_mag_kernels_median] = compute_resp_magnitude_bootstrapping(skrn_fp1)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    %% Generate sampling Matrix
    sampling_matrix = zeros(100, 50);
    for indx = 1:100
        sampling_matrix(indx,:) = randi(400,50,1)';
    end
    
    loop_cnt = size(sampling_matrix,1);    
    gain_itrs =zeros(100,1);
    %% Runing loop for #of rows in sampling_matrix
    for itr = 1:loop_cnt
        t2s_vector = sampling_matrix(itr,:);
        skrn_fp1_sliced = skrn_fp1(t2s_vector,:);
        
        base_kernels_itr = mean(skrn_fp1_sliced(:,1:30),2);
        peak_kernels_itr = max(skrn_fp1_sliced, [], 2);
        gain_kernels_itr = peak_kernels_itr - base_kernels_itr;

        gain_kernels_itr_mean = mean(gain_kernels_itr);
        gain_itrs(itr) = gain_kernels_itr_mean;
        
        %% Visual inspection
%         figure;
%         subplot(1,3,1);
%         grid on; hold on;
%         row = size(skrn_fp1_sliced,1);
%         col = size(skrn_fp1_sliced,2);
%         delay_axis = 1:1:col;
%         for i = 1:row
%             time_axis = i+ones(col,1);
%             plot3(delay_axis,time_axis,skrn_fp1_sliced(i,:)); 
%             view(3); %Changing viewpoint to 3rd axis
%         %     pause;
%         end
%         xlabel('Tau');
%         ylabel('Time');
%         zlabel('skernels');  
%         
%         subplot(1,3,2);
%         plot(gain_kernels_itr);
%         title(['Mean: ' num2str(gain_kernels_itr_mean) ]);
%         
%         subplot(1,3,3);
%         histogram(gain_kernels_itr,30);
        

        
        
    end

    %% Taking mean and median of "gain_itrs" conatining all 100 iterations
    resp_mag_kernels_median = median(gain_itrs);
    resp_mag_kernels_mean = mean(gain_itrs);
    
%     figure; plot(gain_itrs);
%     figure; histogram(gain_itrs);


    

    
    
end

