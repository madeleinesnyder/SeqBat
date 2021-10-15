function SeqBat_within_cluster_variance(flightPaths,bat,cluster,colormap)

% Function to plot the within-cluster variance of a given flight cluster
figure(); hold on; 
title(strcat("All occurances of cluster"," ",num2str(cluster)));
for i=1:length(flightPaths.id)
    if flightPaths.id(i) == cluster
        plot3(flightPaths.pos(1,:,i),flightPaths.pos(2,:,i),flightPaths.pos(3,:,i),'Color',colormap(cluster,:));
    end
end

axis off;

% Get the in-order flight clusters
[ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
c_s_34 = flightPaths.id(rr_1);
days = flightPaths.day(rr_1)
flight_positions = flightPaths.pos(:,:,rr_1);

% Colormap it by day
heat_color = hot(length(flightPaths.id(flightPaths.id==cluster)));

% Function to plot the within-cluster variance of a given flight cluster
figure(); hold on; 
title(strcat("Cluster"," ",num2str(cluster)," ","over time. More heat --> later day"));
counter = 0;
for i=1:length(flightPaths.id)
    if c_s_34(i) == cluster
        counter = counter+1;
        plot3(flight_positions(1,:,i),flight_positions(2,:,i),flight_positions(3,:,i),'Color',heat_color(counter,:));
    end
end

% Calculate Euclidean distance between sets of flights 
[euc_dist] = SeqBat_within_cluster_Euc_dist(flightPaths,cluster)

axis off;

end
