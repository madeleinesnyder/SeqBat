function SeqBat_stacked_flightTypes(flightPaths,co,bat)

    % Function for a stacked bar chart 
    [ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
    c_s_34 = flightPaths.id(rr_1);
    days = flightPaths.day(rr_1);
    
    % Determine which sessions are seperated by days and which are not
    day_gaps = [];
    for i=1:length(flightPaths.Dates)-1
        if str2double(flightPaths.Dates{i}) + 1 ~= str2double(flightPaths.Dates{i+1}) 
            day_gaps = [day_gaps;[str2double(flightPaths.Dates{i}),str2double(flightPaths.Dates{i+1})]];
        end
    end
    day_gaps_ = day_gaps(:,1);
            
    temp_day = NaN(max(days),200);
    temp_day_curl = {};
    for i=1:max(days)
        day_flights_temp = c_s_34(find(days==i));
        temp_day(i,:) = sort([day_flights_temp; NaN(200-length(day_flights_temp),1)])';
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
        clear day_profile_temp;
        temp_temp = temp_day(i,:);
        for j=1:11
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
    colormap_top = distinguishable_colors(11);

    figure(); hold on;
    h = bar(day_profile_top,'stacked','FaceColor','flat');
    date_matrix = cell2mat(flightPaths.Dates');
    for i=1:length(date_matrix)
        date_matrix_(i) = str2double(date_matrix(i,:));
    end
    for i=1:length(day_gaps_)
        plot([find(date_matrix_ == day_gaps_(i))+1/2 find(date_matrix_ == day_gaps_(i))+1/2], [0 200],'Color','r','LineStyle',':','LineWidth',2);
    end
    for i=1:11
        h(i).CData = repmat(colormap(i,:),length(h(1).CData),1);
    end
    
    l = {};
    alphabet = {'UC','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','A_','B_','C_','D_','E_','F_','G_','H_','I_','J_','K_','L_','M_','N_','O_','P_','Q_','R_','S_','T_','U_','V_','W_','X_','Y_','Z_'}
    for i=1:11
        l{i} = alphabet{i};
    end
    
    legend(h,l);
    title("Top ten flight clusters across all days of training")
    xlabel("Days");
    ylabel("Flights");
end
