function  perform_correlation_and_plots(rf_size,neuron_data, outDataFilename)
%   Detailed explanation goes here


%% Scatter dist v/s rf_area
    x = neuron_data.RF1_FP1_eucledian_dist;
    y = sqrt(rf_size);

%     [r,p] = corr(x,y, 'type','spearman');
    [r,p] = corr(x,y);
    ff(1) = figure;
%     subplot(1,2,1);
    s1 = scatter(x,y);    
    s1.Marker = '.';
    s1.MarkerEdgeColor = [1 0 0];    
    hold on ;
    f=fit(x,y,'poly1');
    plot(f,x,y);
    xlabel('Distance');
    ylabel('sqrt (RF1 SIZE  FROM CONTOURS)');
    hold off;
% % %     title(['"' num2str(outDataFilename) '_correlation_SPEARMAN  "   r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
    title(['"' num2str(outDataFilename) '_correlation_ "   r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');

    % Creating folder for respective model
    parent = [pwd '\'];
    dir = 'Figures';
    if exist([parent dir], 'dir')== 0
        mkdir(parent, dir);       
    end    
   
% % % % %     savefig(ff,[parent dir '\' num2str(outDataFilename) '_correlation_SPEARMAN__plots'  '.fig']);
%     savefig(ff,[parent dir '\' num2str(outDataFilename) '_correlation__plots'  '.fig']);

end

