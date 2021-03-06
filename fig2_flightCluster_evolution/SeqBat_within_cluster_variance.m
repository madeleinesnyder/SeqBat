function SeqBat_within_cluster_variance(flightPaths,bat,clusters,colormap)

for kk=1:length(clusters)
    
    cluster=clusters(kk);

    % Get the in-order flight clusters
    [ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
    c_s_34 = flightPaths.id(rr_1);
    days = flightPaths.day(rr_1);
    flight_positions = flightPaths.pos(:,:,rr_1);

    % Colormap it by day
    heat_color = hot(length(flightPaths.id(flightPaths.id==cluster)));

    % Function to plot the within-cluster variance of a given flight cluster
    figure('name',strcat(bat,';',num2str(cluster))); hold on; 
    title(strcat("Cluster"," ",num2str(cluster)," ","over time. More heat --> later day"));
    counter = 0;
    for i=1:length(flightPaths.id)
        if c_s_34(i) == cluster
            counter = counter+1;
            plot3(flight_positions(1,:,i),flight_positions(2,:,i),flight_positions(3,:,i),'Color',heat_color(counter,:));
        end
    end
    
    axis off;
    hold off;

    % Color it by day to check alignment within-cluster
    day_color = distinguishable_colors(max(days));

    figure('name',strcat(bat,';',num2str(cluster))); hold on; 
    title(strcat("Cluster"," ",num2str(cluster)," ","over time. Each day is a color"));
    counter = 0;
    for i=1:length(flightPaths.id)
        for j=1:max(days)
            if c_s_34(i) == cluster & days(i) == j
                plot3(flight_positions(1,:,i),flight_positions(2,:,i),flight_positions(3,:,i),'Color',day_color(j,:));
            end
        end
    end
    
    axis off;
    hold off;

    % Calculate Euclidean distance between sets of flights 
    [within_cluster_position_vector,min_position_idx,Euc_D] = SeqBat_within_cluster_Euc_dist(flightPaths,bat,cluster);

    % For each flight plot the root mean squared euclidean distannce 
    SeqBat_gaussian_mixture_flights(within_cluster_position_vector,min_position_idx,Euc_D,bat,cluster);

    axis off;
end

end
