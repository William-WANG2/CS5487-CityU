%% Function of Least Square
function theta = LS(phi, y)
    % phi is the feature transformation matrix
    % y is the observation vectors
    theta = (phi * phi')\(phi * y);
end
