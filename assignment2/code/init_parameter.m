function [pi, sigma] = init_parameter(x, mu, k)
    [d, n] = size(x);
    pi = zeros(k, 1);
    sigma = zeros(d,d,k);
    %n*k dis matrix
    dis = sum(x.*x)' + sum(mu.*mu) - 2*x'*mu;
    [~, labels] = min(dis, [], 2);
    
    alpha = 0.5*eye(d, d); %regularization constant to avoid singular
    %cal each covariance and pi
    for j = 1:k
        temp = x(:, labels' == j);
        pi(j) = size(temp, 2)/n;
        sigma(:,:,j) = cov(temp') + alpha;
    end
end