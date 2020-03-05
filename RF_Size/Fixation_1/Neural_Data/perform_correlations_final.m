
clear all;
   
%% Load neuron_info
dirname = [pwd '\Data_Files\'];
filename = 'mean_plus_3std__thr_data_files_after';
path = [dirname  filename '.mat'];
load(path);

%% FILTER OUT NEURONS (RF BOUNDARY CASES)
rf_boundary_indxs = find(neuron_info_tables.RF_size_frm_contours ~= -1);
neuron_info_tables = neuron_info_tables(rf_boundary_indxs,:);
rf_maps_interp = rf_maps_interp(rf_boundary_indxs,:,:);
rf_maps_interp_filt = rf_maps_interp_filt(rf_boundary_indxs,:,:);
XoBs_interp = XoBs_interp(rf_boundary_indxs,:,:);
YoBs_interp = YoBs_interp(rf_boundary_indxs,:,:);
    
% [q w]= corr(x_v4(neuron_info_tables_v4.fr_ratio > 1.15 & x_v4<12.5 & y_v4<12.5), y_v4(neuron_info_tables_v4.fr_ratio > 1.15  & x_v4<12.5 & y_v4<12.5))
% [q w]= corr(x_mt(neuron_info_tables_mt.fr_ratio > 1.15 & x_mt<16.5 & y_mt<16.5), y_mt(neuron_info_tables_mt.fr_ratio > 1.15  & x_mt<16.5 & y_mt<16.5))

%% CORRELATIONS ALL NEURONS
x_all = neuron_info_tables.RF1_FP1_eucledian_dist;
y_all = sqrt(neuron_info_tables.RF_size_frm_contours);

% [r,p] = corr(x_all, y_all, 'type','spearman');
[r,p] = corr(x_all, y_all);

% ff = figure('Name',[ num2str(size(x_all,1)) 'Thr:(Mean+3*std) Correlation_Plots (SPEARMAN) '],'NumberTitle','off');
ff = figure('Name',[ num2str(size(x_all,1)) 'Thr:(Mean+3*std) Correlation_Plots '],'NumberTitle','off');

subplot(2,3,1);
s1= scatter(x_all, y_all);
s1.Marker = '.';
s1.MarkerEdgeColor = [1 0 0];

hold on ;
f=fit(x_all, y_all, 'poly1');
plot(f,x_all,y_all);
xlabel('Distance');
ylabel('sqrt(RF1 SIZE  FROM CONTOURS)');
title([ num2str(size(neuron_info_tables,1)) ' NEURONS:    r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
hold off;

subplot(2,3,4);
edges = 1:1:ceil(max(x_all));
histogram(x_all, edges);
xlabel('Distance');

%% CORRELATIONS V4 NEURONS    

v4_indx = find(neuron_info_tables.V4_or_MT ==1);
neuron_info_tables_v4 = neuron_info_tables(v4_indx,:);
rf_maps_interp_v4 = rf_maps_interp(v4_indx,:,:);
rf_maps_interp_filt_v4 = rf_maps_interp_filt(v4_indx,:,:);
XoBs_interp_v4 = XoBs_interp(v4_indx,:,:);
YoBs_interp_v4 = YoBs_interp(v4_indx,:,:);

v4_org = size(neuron_info_tables_v4,1);

final_v4_filt_idxs = find( (neuron_info_tables_v4.fr_ratio > 1.15) & (neuron_info_tables_v4.RF1_FP1_eucledian_dist < 12.5) & (sqrt(neuron_info_tables_v4.RF_size_frm_contours) < 12.5));

neuron_info_tables_v4 = neuron_info_tables_v4(final_v4_filt_idxs,:);
rf_maps_interp_v4 = rf_maps_interp_v4(final_v4_filt_idxs,:,:);
rf_maps_interp_filt_v4 = rf_maps_interp_filt_v4(final_v4_filt_idxs,:,:);
XoBs_interp_v4 = XoBs_interp_v4(final_v4_filt_idxs,:,:);
YoBs_interp_v4 = YoBs_interp_v4(final_v4_filt_idxs,:,:);

x_v4 = neuron_info_tables_v4.RF1_FP1_eucledian_dist;
y_v4 = sqrt(neuron_info_tables_v4.RF_size_frm_contours);

% [r,p] = corr(x_v4, y_v4, 'type','spearman');
[r,p] = corr(x_v4, y_v4);

% ff(2) = figure;
subplot(2,3,2);
s2 = scatter(x_v4, y_v4);
s2.Marker = '.';
s2.MarkerEdgeColor = [1 0 0];

hold on ;
f=fit(x_v4,y_v4,'poly1');
plot(f,x_v4,y_v4);
xlabel('Distance');
ylabel('sqrt(RF1 SIZE  FROM CONTOURS)');
title([ num2str(v4_org) '-->' num2str(size(neuron_info_tables_v4,1)) ' V4 NEURONS:    r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
hold off;

subplot(2,3,5);
edges = 1:1:ceil(max(x_v4));
histogram(x_v4, edges);
xlabel('Distance');

%% CORRELATIONS MT NEURONS 
mt_indx = find(neuron_info_tables.V4_or_MT == 2);
neuron_info_tables_mt = neuron_info_tables(mt_indx,:);
rf_maps_interp_mt = rf_maps_interp(mt_indx,:,:);
rf_maps_interp_filt_mt = rf_maps_interp_filt(mt_indx,:,:);
XoBs_interp_mt = XoBs_interp(mt_indx,:,:);
YoBs_interp_mt = YoBs_interp(mt_indx,:,:);

mt_orig = size(neuron_info_tables_mt,1);

final_mt_filt_idxs = find( (neuron_info_tables_mt.fr_ratio > 1.15) & (neuron_info_tables_mt.RF1_FP1_eucledian_dist < 16.5) & (sqrt(neuron_info_tables_mt.RF_size_frm_contours) < 16.5));

neuron_info_tables_mt = neuron_info_tables_mt(final_mt_filt_idxs,:);
rf_maps_interp_mt = rf_maps_interp_mt(final_mt_filt_idxs,:,:);
rf_maps_interp_filt_mt = rf_maps_interp_filt_mt(final_mt_filt_idxs,:,:);
XoBs_interp_mt = XoBs_interp_mt(final_mt_filt_idxs,:,:);
YoBs_interp_mt = YoBs_interp_mt(final_mt_filt_idxs,:,:);

x_mt = neuron_info_tables_mt.RF1_FP1_eucledian_dist;
y_mt = sqrt(neuron_info_tables_mt.RF_size_frm_contours);

% [r,p] = corr(x_mt, y_mt, 'type','spearman');
[r,p] = corr(x_mt, y_mt);
% ff(3) = figure;
subplot(2,3,3);
s3 = scatter(x_mt, y_mt);
s3.Marker = '.';
s3.MarkerEdgeColor = [1 0 0];

hold on ;
f=fit(x_mt, y_mt, 'poly1');
plot(f, x_mt, y_mt);
xlabel('Distance');
ylabel('sqrt(RF1 SIZE  FROM CONTOURS)')
title([ num2str(mt_orig) '-->' num2str(size(neuron_info_tables_mt,1)) ' MT NEURONS:    r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
hold off;

subplot(2,3,6);
edges = 1:1:ceil(max(x_mt));
histogram(x_mt, edges);
xlabel('Distance');

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

% dir = [pwd '\Data_Files\'];
% save([dir 'neuron_info_tables_v4_FINAL.mat'], 'neuron_info_tables_v4');
% save([dir 'neuron_info_tables_mt_FINAL.mat'], 'neuron_info_tables_mt');


% parent = pwd;
% dir = '\Figures';
% % % % savefig(ff,[parent dir '\'  'FINAL_Correlations_plots_SPEARMAN__wt_hist' '.fig']);
% savefig(ff,[parent dir '\'  'FINAL_Correlations_plots__wt_hist' '.fig']);

