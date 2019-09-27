function [res] = CosineSmilarity(data)
% N = size(feature,1);
% W = zeros(N);
% FZ = feature*feature';
% FM = feature.^2;
% FM = sqrt(sum(FM,2));  
% FM = FM*FM';
% W = FZ./FM;
% W(find(isnan(W)))=0;
% function [res] = cosineSimilarityNaive(data)
% get the dimensions
[n_row n_col] = size(data);
% calculate the norm for each row
%
norm_r = sqrt(sum(abs(data).^2,2));
%
for i = 1:n_row
    % 
    for j = i:n_row
        %
        res(i,j) = dot(data(i,:), data(j,:)) / (norm_r(i) * norm_r(j));
        res(j,i) = res(i,j);
    end
end
end
