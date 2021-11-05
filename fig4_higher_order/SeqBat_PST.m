function SeqBat_PST(out_markov,bat);

% Function to make the PST x pmin plot for a given bat over all days.
x_val_Tree_ = {};
x_val = linspace(0.001,0.02,25);
for i=1:length(x_val)
    [Tree_] = ImBat_ProbSuffixTree(out_markov,5,x_val(i));
    if length(Tree_) > 2
        for j=3:length(Tree_)
            temp_tree_(j) = length(Tree_{j});
        end
        x_val_Tree_{i} = temp_tree_(temp_tree_~=0);
        close all;
    end
end

for i=1:length(x_val_Tree_)
    step2(i) = x_val_Tree_{i}(1);
    if length(x_val_Tree_{i}) > 1
        step3(i) = x_val_Tree_{i}(2);
    else
        step3(i) = NaN;
    end
    if length(x_val_Tree_{i}) > 2
        step4(i) = x_val_Tree_{i}(3);
    else
        step4(i) = NaN;
    end
    if length(x_val_Tree_{i}) > 3
        step5(i) = x_val_Tree_{i}(4);
    else
        step5(i) = NaN;
    end 
end

figure('name',bat); hold on; 
scatter(x_val,step2,'b','filled'); plot(x_val,step2,'b');
scatter(x_val,step3,'g','filled'); plot(x_val,step3,'g');
scatter(x_val,step4,'r','filled'); plot(x_val,step4,'r');
scatter(x_val,step5,'m','filled'); plot(x_val,step5,'m');
xlabel('pmin threshold');
ylabel('number of clusters with higher-order structure');

end