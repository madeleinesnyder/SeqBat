% Figure 1. Visually describe flight paths of a bat over X days of flight

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

%% Plot a) Single day of flights. Clusterable flights in color.

% Select a subset of flights to cluster (Default to plotting clusters that
% comprise 95% of the data)
clusterable_flights = [2:co];
% Select a day/series of days to plot
days2use = 24;
% Plot
TEMP_flights(flightPaths34,clusterable_flights,days2use);