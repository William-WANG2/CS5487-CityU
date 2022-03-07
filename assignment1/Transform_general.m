%% Feature Transformation Generalization -> select mode
function phi = Transform_general(x, d, mode)
    % x is the data points
    % d is the order
    % mode is the transformation you'd like to apply
    % for cross-terms, implement order 2, though can be extended
    if strcmp(mode, "nocross")
        phi = [x; zeros((d-1)*size(x, 1),size(x, 2))];
        ordered_x = x;
        for i = 2:d
            phi((i-1)*size(x,1)+1:i*size(x,1),1:size(x, 2)) = x.*ordered_x;
        end
    elseif strcmp(mode, "cross")
        if d == 2
            phi = [x; zeros((size(x, 1)*(size(x, 1)-1)/2), size(x, 2))];
            k = size(x, 1);
            for i = 1:size(x, 1)
                for j = i:size(x, 1)
                    k = k+1;
                    phi(k, 1:size(x, 2)) = x(i,:).*x(j,:);
                end
            end
            unique(phi, "rows");
        end
    end
end
