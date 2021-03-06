function [within_cluster_position_vector,min_position_idx,Euc_D] = SeqBat_within_cluster_Euc_dist(flightPaths,bat,cluster)


    [ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
    c_s_34 = flightPaths.id(rr_1);
    days = flightPaths.day(rr_1)
    flight_positions = flightPaths.pos(:,:,rr_1);

    % Get all the cluster type flights 
    ctr = 0;
    for i=1:length(c_s_34)-1
        if c_s_34(i) == cluster
            ctr = ctr+1;
            within_cluster_position_vector(:,:,ctr) = flight_positions(:,:,i);
        end
    end
    
    % Check the lengths of this cluster flight over time
    for i=1:size(within_cluster_position_vector,3)
        flight_dur = within_cluster_position_vector(1,:,i);
        Flight_Dur(i) = size(flight_dur(~isnan(flight_dur)),2);
    end
    figure('name',bat); hold on;
    plot(Flight_Dur);
    xlabel("Flights over time");
    ylabel("Duration (samples)");
    title(strcat('Duration of each instance of flight path',' ',num2str(cluster)));
        
    % Get the position of maximum variance for that cluster (this will
    % differ by cluster, currently hard-coded for loops)
    for i=1:size(within_cluster_position_vector,3)
        [min_position(i),min_position_idx(i)] = min(squeeze(within_cluster_position_vector(1,:,i)));    
    end
    
    % Plot that position on the flightpath
    figure(); hold on; 
    title(strcat("Position of greatest variance on flight path",num2str(cluster)));
    for i=1:size(within_cluster_position_vector,3)
        plot3(within_cluster_position_vector(1,:,i),within_cluster_position_vector(2,:,i),within_cluster_position_vector(3,:,i),'Color',[0.8 0.8 0.8]);
        scatter3(within_cluster_position_vector(1,min_position_idx(i),i),within_cluster_position_vector(2,min_position_idx(i),i),within_cluster_position_vector(3,min_position_idx(i),i),'r','filled');
    end
    plot3(within_cluster_position_vector(1,100,i),within_cluster_position_vector(2,100,i),within_cluster_position_vector(3,100,i),'Color',[0.3 0.3 0.3],'LineWidth',10);
    axis off;
    
    % For x, y, and z, calculate the variance across all flights of the
    % furthest point in the flight 
    figure('name',bat); hold on;
    for i=1:3
        temp = squeeze(within_cluster_position_vector(i,:,:));
        temp1 = temp(min_position_idx);
        Variance_at_max_point(i) = var(temp1);
        Mean_at_max_point(i) = mean(temp1);
        subplot(1,3,i); hold on;
        histogram(temp1,50)
        line([mean(temp1) mean(temp1)], [0 200],'LineWidth',3);
        title(strcat("Dimension"," ",num2str(i)));
        hold off;
    end
    
    % Calculate the euclidean distance of each xyz point to the mean
    % (Later)
    for i=1:3
        apex_coordinates(i,:) = squeeze(within_cluster_position_vector(i,min_position_idx(i),:));
    end
    mean_apex_coordinates = mean(apex_coordinates');
    
    for i=1:length(apex_coordinates)
        G  = apex_coordinates(:,i);
        G2 = mean_apex_coordinates';
        Euc_D(i)  = sqrt(sum((G - G2) .^ 2));
    end
    figure();
    histogram(Euc_D,50,'normalization','probability')
    line([mean(Euc_D) mean(Euc_D)], [0 .07],'LineWidth',3);
    title(strcat("Dimension"," ",num2str(i)));
    

end