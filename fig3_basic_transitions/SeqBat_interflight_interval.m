function SeqBat_interflight_interval(flightPaths,co)

    % Function to calculate the interflight interval between all flights 
    
    % Get the in-order flight clusters
    [ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
    c_s_34 = flightPaths.id(rr_1);
    days = flightPaths.day(rr_1);
    flight_times = flightPaths.flight_starts_idx(rr_1);
    
    IFIs = {};
    for i=1:max(days)
        temp_interval = [];
        ctr=0;
        for k=1:length(c_s_34)-1
            if days(k) == i & days(k+1) == i
                ctr = ctr+1
                temp_c_day = flight_times(k);
                temp_n_day = flight_times(k+1);
                temp_interval(ctr) = temp_n_day-temp_c_day;
            end
        end
        IFIs{i} = temp_interval;
    end  
    
    rm_outliers = sort(cell2mat(IFIs))';
    rm_outliers_mean = mean(rm_outliers);
    rm_outliers_sd = std(rm_outliers);
    lb = rm_outliers_mean - (2*rm_outliers_sd); ub = rm_outliers_mean + (2*rm_outliers_sd);
    no_outlier_data = rm_outliers(rm_outliers >lb & rm_outliers < ub);
    
    figure(); hold on;
    hist(sort(cell2mat(IFIs))',300);
    title("Distribution of Interflight intervals for all flights");
    line([rm_outliers_mean rm_outliers_mean],[0 120],'LineStyle',':','LineWidth',2);
    
    figure(); hold on; 
    title("Distribution of Interflight intervals for all flights no outliers");
    xlabel("Time (samples)");
    histogram(no_outlier_data/120',300,'normalization','probability');
    line([rm_outliers_mean/120 rm_outliers_mean/120],[0 .025],'LineStyle',':','LineWidth',2);
    
end
