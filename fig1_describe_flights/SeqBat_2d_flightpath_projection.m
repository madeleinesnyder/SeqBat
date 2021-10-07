% Figure 1. Visually describe flight paths of a bat over X days of flight

% Load in flightpaths struct
load('flightPaths34.mat')

%% Plot a) Single day of flights. Clusterable flights in color.

% Select a subset of flights to cluster 
clusterable_flights = [2:length(unique(flightPaths34.id))];
% Select a day/series of days to plot
days2use = 24;
% Plot
TEMP_flights(flightPaths34,clusterable_flights,days2use);