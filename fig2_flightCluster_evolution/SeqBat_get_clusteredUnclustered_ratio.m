function [day_flights_ratio] = SeqBat_get_clusteredUnclustered_ratio(flightPaths,bat);

    % Function to get and plot the number of clustered to unclustered
    % flightpaths for a given bat over time.
    
    % Get the in-order flight clusters
    [ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
    c_s_34 = flightPaths.id(rr_1);
    days = flightPaths.day(rr_1)
    
    for i=1:max(days)
        day_flights_temp = c_s_34(find(days==i));
        day_flights_clustered(i) = length(day_flights_temp(day_flights_temp~=1));
        day_flights_unclustered(i) = length(day_flights_temp(day_flights_temp==1));
        day_flights_ratio(i) = length(day_flights_temp(day_flights_temp~=1))/length(day_flights_temp);
    end
    
    figure(); hold on;
    scatter([1:max(days)],day_flights_ratio,'r');
    plot(day_flights_ratio,'b');
    title("Ratio of Clustered to Unclustered Flights across days")
    ylabel("Clustered/Total Flights")
    xlabel("Days")

end
