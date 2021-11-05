function SeqBat_guitarhero_plot(flightPaths,Sessions2Use,colormap,co)

% Function to create guitarhero plots for each of the sessions indicated

% Get the in-order flight clusters
[ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
c_s_34 = flightPaths.id(rr_1);
days = flightPaths.day(rr_1);
flight_takeoffs = flightPaths.flight_starts_idx(rr_1);

for i=1:length(Sessions2Use)
    figure('name',strcat('Day',' ',num2str(Sessions2Use(i)))); hold on;
    xlabel("Time (samples)");
    ylabel("Flight Path");
    for j=1:co
        for k=1:length(flightPaths.id)
            if (days(k)==Sessions2Use(i)) & c_s_34(k) == j
                line([flight_takeoffs(k) flight_takeoffs(k)], [(j-1) (j-1)+1],'Color',colormap(j,:),'LineWidth',2);
            end
        end
    end
end

counter=0;
figure('name','Supp Flight Visualization');
A = flightPaths.tracjectoriesRaw*1000;
for clust2use = [1:co]
    counter = counter+1;

    subplot(1,co,counter); hold on; 

    for day2use =  Sessions2Use;

        Ind2use =  find(flightPaths.day == day2use);
        Ind2use2 = find(flightPaths.day == day2use & flightPaths.id == clust2use);
        axis off
        for ii = 1: length(Ind2use2);
            bound2 = flightPaths.flight_starts_idx(Ind2use2(ii)):flightPaths.flight_ends_idx(Ind2use2(ii));
            plot2 =  plot3(A(1,bound2),A(2,bound2),A(3,bound2),'color',colormap(clust2use,:),'LineWidth',1.5); % plot all flights
        end
       % view( -37.5000,30)

    end
    xlim([-2800 2800]);
    ylim([-2800 2800]);
    zlim([0 2500]);
end

% Plot all days of flight in one guitarplot
figure('name','All Days of Flight');
hold on;
xlabel("Time (samples)");
ylabel("Flight Path");
for i = 1:co;
    A = find(flightPaths.id == i);
    in = flightPaths.flight_ends_idx(A)-120;
    plot(flightPaths.AllFlightsMasterTime([in;in])/120,[ones(size(in))+i;zeros(size(in))+i],'LineWidth',3,'color',colormap(i,:))
end

% Plot the divisions between sequential days in green, and the
% divisions between non-sequential days in red
% Determine which sessions are seperated by days and which are not
% day_gaps = [];
% for i=1:length(flightPaths.Dates)-1
%     if str2double(flightPaths.Dates{i}) + 1 ~= str2double(flightPaths.Dates{i+1}) 
%         day_gaps = [day_gaps;[str2double(flightPaths.Dates{i}),str2double(flightPaths.Dates{i+1})]];
%     end
% end
  
end