function trainingdata_selected = set_selection(feature_data,sample_num)
% function to select a random subset of sample_num samples contained in
% feature_data tranining set,and keeps the healthy/cancer ratio.
% the input feature_data is the features data structure
% sample_num - The number of samples in the subset.
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% 
N_OLD = size(feature_data.training,1);
labels = unique(feature_data.training(:,end-1));

% the ratio of samples per class
ratio = sum(bsxfun(@eq,feature_data.training(:,end-1),labels(:)'),1)/N_OLD;

% new samples per class
spc = round(ratio*sample_num);

% a logic vector containing the selected samples
selected = false(size(feature_data.training,1),1);

for i=1:numel(labels)
    ind = find(feature_data.training(:,end-1)==labels(i));
    ind = ind(randsample(numel(ind),spc(i)));
    selected(ind) = true;
end

trainingdata_selected= feature_data.training(selected,:);