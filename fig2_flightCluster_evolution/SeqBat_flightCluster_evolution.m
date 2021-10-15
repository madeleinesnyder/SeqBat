% Figure 2. Plot the stability of flight clusters over time 

% Load in flightpaths struct
load('flightPaths34.mat')

% Get which flightpaths constitute 95% of the data
five_percent = round(size(flightPaths34.id,1)*(0.05));
for i=1:length(unique(flightPaths34.id))-1
    temp1 = length(flightPaths34.id(flightPaths34.id > i));
    temp2 = length(flightPaths34.id(flightPaths34.id > (i+1)));
    if temp2 < five_percent & temp1 > five_percent
        co = i;
        break
    else
        co = 0;
    end
end 

%% Plot a) Percentage of flights that are clustered/unclustered over time. All bats together.

c_to_unc_allbats = {};
bats = ["Ga","Ge","Bu","Zu","Za","z2"];
for i=1:2%length(bats)
    bat = bats(i);
    disp(strcat("Processing"," ",bat));
    flightpaths_path = strcat('/Volumes/server_home/users/madeleine/SeqBat/data/Processed_',bats(i),'_LH/CellReg_files/ROI_Data/Saved_Data/Aligned_Data.mat');
    load(flightpaths_path);
    [c_to_unc] = SeqBat_get_clusteredUnclustered_ratio(flightPaths,bat);
    c_to_unc_allbats{i} = c_to_unc;
end

nan_matrix = NaN(5,length(c_to_unc_allbats{2}));
nan_matrix(1,:) = [c_to_unc_allbats{1},NaN(1,length(c_to_unc_allbats{2})-length(c_to_unc_allbats{1}))];
nan_matrix(2,:) = c_to_unc_allbats{2};
nan_matrix(3,:) = [c_to_unc_allbats{3},NaN(1,length(c_to_unc_allbats{2})-length(c_to_unc_allbats{3}))];
nan_matrix(4,:) = [c_to_unc_allbats{4},NaN(1,length(c_to_unc_allbats{2})-length(c_to_unc_allbats{4}))];

for i=1:size(nan_matrix,1)
    err_matrix(i,:) = nan_matrix(i,:)-nanmean(nan_matrix(i,:));
end
err_matrix_LB = min(nan_matrix);
err_matrix_UB = max(nan_matrix);
errs = err_matrix_UB - err_matrix_LB;

figure(); 
errorbar(nanmean(nan_matrix),errs);
title("Fraction of Clusterable v.s. Unclusterable Flights across training");
ylabel("Clusterable/Total Flights");
xlabel("Days");

%% Plot b) All flights in a stacked barchart across training. One per bat.

c_to_unc_allbats = {};
bats = ["Ga","Ge","Bu","Zu","Za","z2"];
for i=1:length(bats)
    bat = bats(i);
    disp(strcat("Processing"," ",bat));
    flightpaths_path = strcat('/Volumes/server_home/users/madeleine/SeqBat/data/Processed_',bats(i),'_LH/CellReg_files/ROI_Data/Saved_Data/Aligned_Data.mat');
    load(flightpaths_path);
    SeqBat_stacked_flightTypes(flightPaths34,bat);
end

%% Plot c) The mean variance of each flight cluster over time. One per flight cluster.

cluster = 2;
SeqBat_within_cluster_variance(flightPaths34,bat,cluster,colormap)

%% Plot d) For being a #overachiever