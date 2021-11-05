function SeqBat_github_contributions_plot(flightPaths,bat,co)

    [ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
    c_s_34 = flightPaths.id(rr_1);
    days = flightPaths.day(rr_1);
    flight_takeoffs = flightPaths.flight_starts_idx(rr_1);
    
    github_matrix = zeros(length(unique(days)),co);
    for i=1:length(unique(days))
        temp_c_s_34 = c_s_34(days==i);
        for j=1:co
            github_matrix(i,j) = length(find(temp_c_s_34==j));
        end
    end
    figure(); 
    heatmap(github_matrix');
    colormap(hot)
    
    % Without the 
    github_matrix_noOne = github_matrix(:,2:end);
    figure(); 
    surf(github_matrix_noOne');
        
        
    end

end