%% Bayesian regression (BR)
function [mean, cov] = BR(phi, y, alpha, sigma_square)
    % phi is the feature transformation matrix
    % y is the observation vectors
    % alpha is the diagonal coefficient of covariance matrix in prior
    % sigma_square is the diagonal coefficient of covariance matrix in data
    phi_symmetry = phi*phi';
    cov = inv(1/alpha * eye(size(phi_symmetry)) + 1/sigma_square * phi_symmetry);
    mean = 1/sigma_square * cov * phi * y;
end