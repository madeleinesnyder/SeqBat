function SeqBat_interflight_interval_cluster(flightPaths,clusters2use,co)

    % Function to calculate the interflight interval between all flights 
    
    % Get the in-order flight clusters
    [ss_1,rr_1] = sort(flightPaths.flight_starts_idx);
    c_s_34 = flightPaths.id(rr_1);
    days = flightPaths.day(rr_1);
    flight_times = flightPaths.flight_starts_idx(rr_1);
    
    colormap = distinguishable_colors(length(unique(c_s_34)));
    
    % Construct bi-grams of flights
    bigrams_ = [];
    for i=1:length(c_s_34)-1
        new_bigram = [c_s_34(i),c_s_34(i+1)];
        bigrams_ = [bigrams_;new_bigram];
    end
    
    % Exclude bigrams between days 
    bigrams = [];
    for i=1:length(bigrams_)-1
        if days(i) ==days(i+1)
            bigrams = [bigrams;bigrams_(i,:)];
        end
    end
    
    % Find matrix of transitions
    bigram_matrix = zeros(length(unique(c_s_34)),length(unique(c_s_34)));
    for i=1:length(unique(c_s_34))
        for j=1:length(unique(c_s_34))
            for k=1:length(bigrams)
                if bigrams(k,1) == i & bigrams(k,2) == j
                    bigram_matrix(i,j) = bigram_matrix(i,j) + 1;
                end
            end
        end
    end
    
    % Overlay histograms of the distribution of IFIs
    for i=1:length(clusters2use)
        cluster=clusters2use(i);
        %figure(); hold on;
        %title(strcat("IFI from cluster",num2str(cluster)," ","to cluster..."));
        bigram_row = bigram_matrix(cluster,:);
        bigrams_for_cluster = find(bigram_row~=0);
        %bigrams_for_cluster = bigrams_for_cluster(1:5);
        cluster_IFIs = cell([1,length(bigrams_for_cluster)]);
        for k=1:length(bigrams_for_cluster)
            for m=1:length(c_s_34)-1
                if c_s_34(m) == cluster & c_s_34(m+1) == bigrams_for_cluster(k)
                    cluster_IFIs{k} = [cluster_IFIs{k},(flight_times(m+1) - flight_times(m))];
                end
            end
        end
        for k=1:length(bigrams_for_cluster)
            figure('name',num2str(i));
            histogram(cluster_IFIs{k}/120','DisplayStyle','stairs','LineWidth',2,'normalization','probability','BinWidth',4,'EdgeColor',colormap(bigrams_for_cluster(k),:));
            line([mean(cluster_IFIs{k}/120') mean(cluster_IFIs{k}/120')], [0 .3],'LineStyle',':','LineWidth',1.5);
        end
        xlabel("Time (samples)");
        ylabel("Frequency");
        l = {};
        alphabet = {};
        for k=1:length(bigrams_for_cluster)
            alphabet{k} = num2str(bigrams_for_cluster(k));
        end
        for i=1:length(alphabet)
            l{i} = alphabet{i};
        end
    end
    
    %% Construct bigrams for individual days
    day = 14;
    % Construct bi-grams of flights
    bigrams_day = [];
    c_s_34_day = c_s_34(days==day);
    flight_times_day = flight_times(days==day);
    
    for i=1:length(c_s_34_day)-1
        new_bigram = [c_s_34_day(i),c_s_34_day(i+1)];
        bigrams_day = [bigrams_day;new_bigram];
    end
    
    % Find matrix of transitions
    bigram_matrix_day = zeros(length(unique(c_s_34_day)),length(unique(c_s_34_day)));
    unique_T = unique(c_s_34_day);
    for i=1:length(unique_T)
        for j=1:length(unique_T)
            for k=1:length(bigrams_day)
                if bigrams_day(k,1) == unique_T(i) & bigrams_day(k,2) == unique_T(j)
                    bigram_matrix_day(i,j) = bigram_matrix_day(i,j) + 1;
                end
            end
        end
    end
    
    % Overlay histograms of the distribution of IFIs for a single day
    for i=1:length(clusters2use)
        cluster=clusters2use(i);
        %figure(); hold on;
        %title(strcat("IFI from cluster",num2str(cluster)," ","to cluster..."));
        bigram_row_day = bigram_matrix_day(cluster,:);
        bigrams_for_cluster_day = find(bigram_row_day~=0);
        %bigrams_for_cluster = bigrams_for_cluster(1:5);
        cluster_IFIs_day = cell([1,length(bigrams_for_cluster_day)]);
        for k=1:length(bigrams_for_cluster_day)
            for m=1:length(c_s_34_day)-1
                if c_s_34_day(m) == cluster & c_s_34_day(m+1) == bigrams_for_cluster_day(k)
                    cluster_IFIs_day{k} = [cluster_IFIs_day{k},(flight_times_day(m+1) - flight_times_day(m))];
                end
            end
        end
        for k=1:length(bigrams_for_cluster_day)
            figure('name',num2str(i));
            histogram(cluster_IFIs_day{k}/120','DisplayStyle','stairs','LineWidth',2,'normalization','probability','BinWidth',4,'EdgeColor',colormap(bigrams_for_cluster_day(k),:));
            line([mean(cluster_IFIs_day{k}/120') mean(cluster_IFIs_day{k}/120')], [0 .3],'LineStyle',':','LineWidth',1.5);
        end
        xlabel("Time (samples)");
        ylabel("Frequency");
        l = {};
        alphabet = {};
        for k=1:length(bigrams_for_cluster_day)
            alphabet{k} = num2str(bigrams_for_cluster_day(k));
        end
        for i=1:length(alphabet)
            l{i} = alphabet{i};
        end
    end
    
    
       
end
