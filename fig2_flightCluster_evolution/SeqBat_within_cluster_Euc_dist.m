function [euc_dist] = SeqBat_within_cluster_Euc_dist(flightPaths,cluster)

% Find the euclidean distance between successive pairs of flights
[ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
c_s_34 = flightPaths.id(rr_1);
days = flightPaths.day(rr_1)
flight_positions = flightPaths.pos(:,:,rr_1);

% Get all within cluster flights 
ctr = 0;
for i=1:length(c_s_34)-1
    if c_s_34(i) == cluster
        ctr = ctr+1;
        within_cluster_position_vector(:,:,ctr) = flight_positions(:,:,i);
    end
end

% Get the difference in x, y, and z coordinates between successive
% within-cluster flights
for i=1:size(within_cluster_position_vector,3)-1
    x_dist(i,:) = abs(within_cluster_position_vector(1,:,i+1) - within_cluster_position_vector(1,:,i));
    y_dist(i,:) = abs(within_cluster_position_vector(2,:,i+1) - within_cluster_position_vector(2,:,i));
    z_dist(i,:) = abs(within_cluster_position_vector(3,:,i+1) - within_cluster_position_vector(3,:,i));
end

% Plot the running average x, y, and z dist
figure(); hold on;
title("Running mean of x, y, and z Euclidean distances between within-cluster flights")
for i=1:length(within_cluster_position_vector)
    xmean(i) = nanmean(x_dist(1:i));
    ymean(i) = nanmean(y_dist(1:i));
    zmean(i) = nanmean(z_dist(1:i)); 
end
plot(xmean,'r');
plot(ymean,'g');
plot(zmean,'b');

x_err = nanmean(x_dist); y_err = nanmean(x_dist); z_err = nanmean(z_dist);

% Errorbar figure
figure();
subplot(3,1,1);
errorbar(xmean,x_err,'r');
subplot(3,1,2);
errorbar(ymean,y_err,'g');
subplot(3,1,3);
errorbar(zmean,z_err,'b');

end