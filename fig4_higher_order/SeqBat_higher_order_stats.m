% Figure 4. Higher order transition statistics

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

%% Plot ai) PST for a given bat (with the optimal pmin)

[out_markov] = ImBat_New_Markov(flightPaths34);

% Create prob suff tree
p_min_input = 0.003375;
[Tree_] = ImBat_ProbSuffixTree(out_markov,5,p_min_input);



%% Plot aii) Number of extended trees as a function of pst thresholds

bat = 'Ga';
% CAUTION-- WILL TAKE A LONG TIME!
SeqBat_PST(out_markov,bat);

%% Plot b) 3-gram waterfall plot of a given cluster for a given bat

SeqBat_Waterfall(flightPaths34,bat);

ImBat_YCplot(out_markov,5);


