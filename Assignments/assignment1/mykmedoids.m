function [ class, centroid ] = mykmedoids( pixels, K )
%
% Your goal of this assignment is implementing your own K-medoids.
% Please refer to the instructions carefully, and we encourage you to
% consult with other resources about this algorithm on the web.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

%[class, centroid] = kmeans(pixels, K);
%First tried with Euclidean distance measurent
unique_pixels = unique(pixels,'rows');
if K > length(unique_pixels)
    warning('K is too large, reduced K = %d to %d, a preset maximum K',K,32)
    %K = length(unique_pixels)
    K=32;
end
% % initialization for k cluster centers by randomizing selecting K points
% % from the unique pixels set.
% centroid = unique_pixels((randperm(length(unique_pixels),K)),:);
% %initial class list
% class = zeros(length(pixels),1);
% iterating_class = ones(length(pixels),1);
% 
% iteration = 0;
% max_iteration = 100;
% while true 
%     %step 1: assign points to K clusters centroids
%     for i=1:length(pixels)
%         distance = zeros(K,1);
%         for j = 1:K
%             distance(j) = norm(pixels(i,:)-centroid(j,:));
%         end
%         [~,index_min_dis] = min(distance);
%         iterating_class(i,1) = index_min_dis;
%     end
% 
%     %step 2:replace clusters centroids with one representive point of each
%     %cluster
%     for j = 1:K
%        cluster = pixels(iterating_class == j,:);
%        cluster_mean = mean(cluster);
%        distance_cluster = [];
%        for l = 1:length(cluster)
%            distance_cluster(l) = norm(cluster(l,:)-cluster_mean);
%        end
%        [~,index_min_dis_cluster] = min(distance_cluster);
%        
%        centroid(j,:) = cluster(index_min_dis_cluster,:);
%     end
%     %stoping condition: if iteration is reaching to preset max 100, or the
%     %points not moving from clusters anymore
%     if (class == iterating_class) | (iteration >= max_iteration)
%         break;
%     end
%     class = iterating_class;
%     iteration = iteration +1;
% end
% %First tried with Euclidean distance measurent
% unique_pixels = unique(pixels,'rows');
% if K > length(unique_pixels)
%     warning('K is too large, reduced K = %d to %d, a preset maximum K',K,32)
%     %K = length(unique_pixels)
%     K=32;
% end

% Second tried with Manhattan distance
% initialization for k cluster centers by randomizing selecting K points
% from the unique pixels set.
centroid = unique_pixels((randperm(length(unique_pixels),K)),:);
%initial class list
class = zeros(length(pixels),1);
iterating_class = ones(length(pixels),1);

iteration = 0;
max_iteration = 100;
while true 
    %step 1: assign points to K clusters centroids
    for i=1:length(pixels)
        distance = zeros(K,1);
        for j = 1:K
            distance(j) = sum(abs(pixels(i,:)-centroid(j,:)));
        end
        [~,index_min_dis] = min(distance);
        iterating_class(i,1) = index_min_dis;
    end

    %step 2:replace clusters centroids with one representive point of each
    %cluster
    for j = 1:K
       cluster = pixels(iterating_class == j,:);
       cluster_mean = mean(cluster);
       distance_cluster = [];
       for l = 1:length(cluster)
           distance_cluster(l) = sum(abs((cluster(l,:)-cluster_mean)));
       end
       [~,index_min_dis_cluster] = min(distance_cluster);
       
       centroid(j,:) = cluster(index_min_dis_cluster,:);
    end
    %stoping condition: if iteration is reaching to preset max 100, or the
    %points not moving from clusters anymore
    if (class == iterating_class) | (iteration >= max_iteration)
        break;
    end
    class = iterating_class;
    iteration = iteration +1;
end
end