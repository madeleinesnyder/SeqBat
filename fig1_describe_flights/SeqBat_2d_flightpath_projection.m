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
clusterable_flights = [1:10];
% Select a day/series of days to plot
days2use = [46,47,48,49];
% Plot
SeqBat_plot_flights(flightPaths34,clusterable_flights,days2use);

SeqBat_plot_flights_AI(flightPaths34,clusterable_flights,days2use,400,400);


%% Plot b) All days of flights overlaid. Clusterable flights in color.

% Select a subset of flights to cluster (Default to plotting clusters that
% comprise 95% of the data)
clusterable_flights = [2];%co];
% Select a day/series of days to plot
days2use = [1:25];%max(flightPaths34.day)];
% Plot
SeqBat_plot_flights_overlay_days(flightPaths34,clusterable_flights,days2use);
SeqBat_plot_flights_overlay_days_AI(flightPaths34,clusterable_flights,days2use);


%% Plot c) Single days of flights that are X days apart

% Select a subset of flights to cluster (Default to plotting clusters that
% comprise 95% of the data)
clusterable_flights = [2:co];
% Select a day/series of days to plot
days2use = [1,3,5,7,10,11];
% Plot
SeqBat_plot_flights(flightPaths34,clusterable_flights,days2use);
SeqBat_plot_flights_AI(flightPaths34,clusterable_flights,days2use,2000,100);

%% Plot c2) Github additions plot

SeqBat_github_contributions_plot(flightPaths34,bat,co)





