clear all;

dirname1 = [ pwd '\Mat_Files'];

%% CHOOSE SWITCH CRITERIA TO LOAD REQUIRED PSTH DATA
% flag = 1; % V4 NEURONS
flag = 2; % MT NEURONS

switch flag
    case 1
% %         neuron_categ = 'V4_neurons'; 
        
    case 2
        neuron_categ = 'MT_neurons';          
        filename2 = 'Data_ct_signrank_MT_neuronsp_val_10e-7__V2';
        path = [dirname1 '\' filename2 '.mat']; 
        load(path);
end


%% MAIN VARIABLES FOR CORRELATION
t2p = neuron_info_tables.t2p;
ct_signrank = neuron_info_tables.ct_signrank;
euc_dist = neuron_info_tables.RF1_FP1_eucledian_dist;
RF1x = abs(neuron_info_tables.RF1x);
RF1y = abs(neuron_info_tables.RF1y);

%% %%%%%%%%%%%%%%%%%%%%%  t2p(PSTH) v/s ct_signrank  %%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(t2p, ct_signrank);
f(1) = figure;
scatter(t2p, ct_signrank);
xlabel('t2p(PSTH)'); ylabel('ct signrank')
title([neuron_categ ':  t2p(PSTH) v/s ct_signrank  ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
mx = max(max(t2p), max(ct_signrank));
axis([0 mx 0 mx]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%  distance v/s ct_signrank  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(euc_dist, ct_signrank);
f(2) = figure;  
subplot(1,3,1);
scatter(euc_dist, ct_signrank);
xlabel('Distance'); ylabel('ct signrank');
title([neuron_categ ':  distance v/s ct_signrank   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(euc_dist), max(ct_signrank));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%  RF1x v/s ct_signrank  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(RF1x, ct_signrank);
% f(2) = figure;
subplot(1,3,2);
scatter(RF1x, ct_signrank);
xlabel('RF1x'); ylabel('ct signrank');
title([neuron_categ ':  RF1x v/s ct_signrank   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(RF1x), max(ct_signrank));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%  RF1y v/s ct_signrank  %%%%%%%%%%%%%%%%%%%%%%%%%%%

[r,p] = corr(RF1y, ct_signrank);
% f2(3) = figure;
subplot(1,3,3);
scatter(RF1y, ct_signrank);
xlabel('RF1y');
ylabel('ct signrank');
title([neuron_categ ':  RF1y v/s ct_signrank   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(RF1y), max(ct_signrank));
% axis([0 mx 0 mx]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% %%%%%%%%%%%%%%%%%%%%%  distance v/s t2p_max_PSTH  %%%%%%%%%%%%%%%%%%%%%%
% 
[r,p] = corr(euc_dist, t2p);
f(3) = figure;
subplot(1,3,1);
scatter(euc_dist, t2p);
xlabel('Distance');
ylabel('t2p', 'Interpreter', 'None');
title([neuron_categ ':  distance v/s t2p   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(euc_dist), max(t2p));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%%  RF1x v/s t2p  %%%%%%%%%%%%%%%%%%%%%%%%%%%

[r,p] = corr(RF1x, t2p);
% f3(2) = figure;
subplot(1,3,2);
scatter(RF1x, t2p);
xlabel('RF1x');
ylabel('t2p', 'Interpreter', 'None');
title([neuron_categ ':  RF1x v/s t2p   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(RF1x), max(t2p));
% axis([0 mx 0 mx]);

%% %%%%%%%%%%%%%%%%%%%%%  RF1y v/s t2p  %%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,p] = corr(RF1y, t2p);
% f(3) = figure;
subplot(1,3,3);
scatter(RF1y, t2p);
xlabel('RF1y');
ylabel('t2p', 'Interpreter', 'None');
title([neuron_categ ':  RF1y v/s t2p   ' 'r: ' num2str(r) '  p: ' num2str(p)], 'Interpreter', 'None');
% mx = max(max(RF1y), max(t2p));
% axis([0 mx 0 mx]);

% Creating folder for respective model
parent = [pwd '\'];
dir = ['Figures'];
if exist([parent dir], 'dir')== 0
    mkdir(parent, dir);       
end

% savefig(f, [parent dir '\' char(neuron_categ) 'correlation_plots__p_val_10e-7' '.fig']);

