%% robust regression (RR)
function theta = RR(phi, y)
    % phi is the feature transformation matrix
    % y is the observation vectors
    n = size(phi, 2);
    d = size(phi, 1);
    %obj
    f = [zeros(d,1); ones(n, 1)];
    %constraint
    A = [-phi', -eye(n) ; phi', -eye(n)];
    b = [-y ; y];
    x = linprog(f,A,b);
    theta = x(1:d);
end
