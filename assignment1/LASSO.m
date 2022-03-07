%% L1-regularized LS (LASSO)
function theta = LASSO(phi, y, lambda)
    % phi is the feature transformation matrix
    % y is the observation vectors
    % lambda is the coefficient of the regularization term

    %obj
    phi_symmetry = phi * phi';
    H = [phi_symmetry, -phi_symmetry; -phi_symmetry, phi_symmetry];
    f = lambda - [phi*y; -phi*y];
    %constraint
    A = -eye(size(H));
    b = zeros(size(A,1),1);
    %solver
    x = quadprog(H,f,A,b);
    theta_pos = x(1:size(x)/2);
    theta_neg = x(size(x)/2+1:end);
    theta = theta_pos-theta_neg;
end