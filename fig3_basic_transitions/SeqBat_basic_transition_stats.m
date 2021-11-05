% Main script for figure 3. Getting basic transition statistics

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

%% a) Plot Guitar Hero Plot for a given session

Sessions2Use = [2,4,6,8,10,12,14];
colormap = distinguishable_colors(co);

SeqBat_guitarhero_plot(flightPaths34,Sessions2Use,colormap,11);

%% b) 

% i) Plot interflight interval for all flights for a given bat
SeqBat_interflight_interval(flightPaths,co);

% i) Plot interflight interval for all flights for specific transitions
clusters2use = [2];
SeqBat_interflight_interval_cluster(flightPaths,clusters2use,co);

    