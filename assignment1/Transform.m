%% Feature Transformation
function phi = Transform(x, d)
    % x is the data points
    % d is the order
    phi = [ones(size(x)); x; zeros(d-1, size(x, 2))];
    ordered_x = x;
    for i = 3:d+1
        ordered_x = x.*ordered_x;
        phi(i,:) = ordered_x;
    end
end
