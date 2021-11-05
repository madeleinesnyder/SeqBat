
function SeqBat_plot_flights_AI(flightPaths,FlightPaths2plot,Days2use,w,h);

% Legacy function TEMP_flights in ImBat Repo

figure();
col = distinguishable_colors(length(unique(flightPaths.id)));
alpha2use = 1;

% for all flights


hold on;
A = flightPaths.tracjectoriesRaw*1000;
counter = 1;

for clust2use = FlightPaths2plot;

    gcf = figure("name",strcat("Overlay"," ",num2str(clust2use))); 
    pos = get(gcf,'Position');
    pos(3:4) = [w h];
    set(gcf,'Position',pos);
    counter = 1;

    for day2use =  Days2use;

        % plot all flights
         %subplot(length(Day2use),1,day2use); 
        if length(Days2use) > 3
            subplot(1,length(Days2use),counter); 
            view(2)
            counter = counter+1;
        else
            subplot(1,length(Days2use),counter);
            view(2)
            counter = counter+1;
        end
        % Hilight stable flights
        hold on;
        title(strcat("Day"," ",num2str(day2use)));
        Ind2use =  find(flightPaths.day == day2use );
        Ind2use2 = find(flightPaths.day == day2use & flightPaths.id == clust2use);
        axis off
        %for iii = 1:length(Ind2use)  
        %    bound = flightPaths.flight_starts_idx(Ind2use(iii)):flightPaths.flight_ends_idx(Ind2use(iii));
        %    plot1 =  plot3(A(1,bound),A(2,bound),A(3,bound),'color',[0 0 0 alpha2use]); % plot all flights
        %end
        for ii = 1: length(Ind2use2);
            bound2 = flightPaths.flight_starts_idx(Ind2use2(ii)):flightPaths.flight_ends_idx(Ind2use2(ii));
            if clust2use == 1
                plot2 =  plot3(A(1,bound2),A(2,bound2),A(3,bound2),'color',[0 0 0],'LineWidth',1.5); % plot all flights
            else   
                plot2 =  plot3(A(1,bound2),A(2,bound2),A(3,bound2),'color',col(clust2use,:),'LineWidth',1.5); % plot all flights
        
            end
        end
    end
    xlim([-2800 2800]);
    ylim([-2800 2800]);
    zlim([0 2500]);
    axis equal
end

axis off

