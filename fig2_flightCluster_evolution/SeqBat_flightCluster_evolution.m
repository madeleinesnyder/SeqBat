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
    [c_to_unc] = SeqBat_get_clusteredUnclustered_ratio(flightPaths34,bat);
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

% Plot all bats' avg of clusterable/non fraction 
figure(); hold on;
scatter([1:length(nanmean(nan_matrix))],nanmean(nan_matrix));
errorbar(nanmean(nan_matrix),errs);
title("Fraction of Clusterable v.s. Unclusterable Flights across training");
ylabel("Clusterable/Total Flights");
xlabel("Days");

% Plot each bat's clusterable/non fraction  overlaid
figure(); hold on;
title("Fraction of Clusterable v.s. Unclusterable Flights across training");
ylabel("Clusterable/Total Flights");
xlabel("Days");
for i=1:length(c_to_unc_allbats)
    scatter([1:length(c_to_unc_allbats{i})],c_to_unc_allbats{i});
    plot(c_to_unc_allbats{i});
end
%% Plot b) All flights in a stacked barchart across training. One per bat.

c_to_unc_allbats = {};
bats = ["Ga","Ge","Bu","Zu","Za","z2"];
for i=1:length(bats)
    bat = bats(i);
    disp(strcat("Processing"," ",bat));
    flightpaths_path = strcat('/Volumes/server_home/users/madeleine/SeqBat/data/Processed_',bats(i),'_LH/CellReg_files/ROI_Data/Saved_Data/Aligned_Data.mat');
    load(flightpaths_path);
    SeqBat_stacked_flightTypes(flightPaths34,co,bat);
end

%% Plot c) The mean variance of each flight cluster over time. One per flight cluster.
% Plot d) For being a #overachiever

clusters = [2];
SeqBat_within_cluster_variance(flightPaths34,bat,clusters,colormap)
