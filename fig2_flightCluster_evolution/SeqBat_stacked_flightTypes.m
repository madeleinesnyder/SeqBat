function SeqBat_stacked_flightTypes(flightPaths,bat)

    % Function for a stacked bar chart 
    [ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
    c_s_34 = flightPaths.id(rr_1);
    days = flightPaths.day(rr_1);
    
    temp_day = NaN(max(days),150);
    temp_day_curl = {};
    for i=1:max(days)
        day_flights_temp = c_s_34(find(days==i));
        temp_day(i,:) = sort([day_flights_temp; NaN(150-length(day_flights_temp),1)])';
    end
        
    for i=1:max(days)
        temp_temp = temp_day(i,:);
        for j=1:length(unique(c_s_34))
            temp_find = find(temp_temp==j);
            if isempty(temp_find)
                day_profile_temp(j) = NaN;
            else
                day_profile_temp(j) = length(find(temp_temp==j));
            end
        end
        day_profile(i,:) = day_profile_temp;  
    end
    
    % Only top 10 flight types
    for i=1:max(days)
        temp_temp = temp_day(i,:);
        for j=1:10
            temp_find = find(temp_temp==j);
            if isempty(temp_find)
                day_profile_temp(j) = NaN;
            else
                day_profile_temp(j) = length(find(temp_temp==j));
            end
        end
        day_profile_top(i,:) = day_profile_temp;  
    end
    
    colormap = distinguishable_colors(length(unique(c_s_34)));
    colormap_top = distinguishable_colors(10);

    figure(); hold on;
    h = bar(day_profile_top,'stacked');
    for i=1:10
        h(i).CData = repmat(colormap_top(i,:),length(h(1).CData),1);
    end
    
    l{1}='Unclustered'; l{2}='A'; l{3}='B'; l{4}='C'; l{5}='D'; l{6}='E'; l{7}='F';l{8}='G'; l{9}='H'; l{10}='I';  
    legend(h,l);
    title("Top ten flight clusters across all days of training")
    xlabel("Days");
    ylabel("Flights");
end
