%% regularized LS (RLS)
function theta = RLS(phi, y, lambda)
    % phi is the feature transformation matrix
    % y is the observation vectors
    % lambda is the coefficient of the regularization term
    theta = (phi * phi' + lambda * eye(size(phi*phi')))\(phi*y);
end