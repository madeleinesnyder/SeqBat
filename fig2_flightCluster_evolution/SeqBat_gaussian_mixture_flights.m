function SeqBat_gaussian_mixture_flights(within_cluster_position_vector,min_position_idx,Euc_D,bat,cluster)

    % For a given dimension, find the mean position at the max point, and
    % the vector of all other positions.
    
    for i=1:3
        temp = squeeze(within_cluster_position_vector(i,:,:));
        temp1 = temp(min_position_idx);
        Variance_at_max_point(i) = var(temp1);
        Mean_at_max_point(i) = mean(temp1);
        
        AIC = zeros(1,4);
        GMModels = cell(1,4);
        options = statset('MaxIter',500);
        for k = 1:4
            GMModels{k} = fitgmdist(temp1',k,'Options',options,'CovarianceType','full');
            AIC(k)= GMModels{k}.AIC;
        end

        [minAIC,numComponents] = min(AIC);
        numComponents;

        BestModel = GMModels{numComponents}


        [minAIC,numComponents] = min(AIC);
        numComponents;

        % Sim data
        % Generate some sample data
        for j = 1:size(BestModel.mu,1)
            mu(j) = BestModel.mu(j);
            sig(j) = sqrt(BestModel.Sigma(:,:,j));
            p(j) = BestModel.ComponentProportion(j);
        end

        Sigg(1,:,:) = sig;
        gm = gmdistribution(mu',Sigg,p);
        %gmPDF = pdf(gm,linspace(min(temp1):max(temp1),.1)');
        xran = linspace(min(temp1),max(temp1)+0.1,500)';
        %gmPDF = pdf(BestModel,linspace(min(temp1),max(temp1),.1)');

        
        figure('name',strcat(bat,';',num2str(cluster))); hold on;
        title(strcat("Gaussian mixture model of deviance from the mean along dimension "," ",num2str(i), " ","in flights in cluster"," ",num2str(cluster)));
        colors_hist = distinguishable_colors(length(mu));
        for j=1:length(mu)
            plot(xran, p(j) * pdf('Normal', xran, mu(j), sig(j)),'Color',colors_hist(j,:))
        end
    end
    
    
    %% For Euc D
    
    AIC = zeros(1,4);
    GMModels = cell(1,4);
    options = statset('MaxIter',500);
    for k = 1:4
        GMModels{k} = fitgmdist(Euc_D',k,'Options',options,'CovarianceType','full');
        AIC(k)= GMModels{k}.AIC;
    end

    [minAIC,numComponents] = min(AIC);
    numComponents;

    BestModel = GMModels{numComponents}


    [minAIC,numComponents] = min(AIC);
    numComponents;

    % Sim data
    % Generate some sample data
    for j = 1:size(BestModel.mu,1)
        mu(j) = BestModel.mu(j);
        sig(j) = sqrt(BestModel.Sigma(:,:,j));
        p(j) = BestModel.ComponentProportion(j);
    end

    Sigg(1,:,:) = sig;
    gm = gmdistribution(mu',Sigg,p);
    %gmPDF = pdf(gm,linspace(min(temp1):max(temp1),.1)');
    xran = linspace(min(temp1),max(temp1)+0.1,500)';
    %gmPDF = pdf(BestModel,linspace(min(temp1),max(temp1),.1)');


    figure('name',strcat(bat,';',num2str(cluster))); hold on;
    title(strcat("Gaussian mixture model of deviance from the mean along dimension "," ",num2str(i), " ","in flights in cluster"," ",num2str(cluster)));
    colors_hist = distinguishable_colors(length(mu));
    for j=1:length(mu)
        plot(xran, p(j) * pdf('Normal', xran, mu(j), sig(j)),'Color',colors_hist(j,:))
    end

        
        
        
        
        
   
end