function [P] = multiGaussian(x, k, mu, sigma)
    [d,n] = size(x);
    P = zeros(n,k);

    for j = 1:k
        % x - uk, shift is N*D matrix
        t = repmat(mu(:, j), 1, n);
        shift = x-repmat(mu(:, j), 1, n);
        inv_sigma = inv(sigma(:, :, j)); 
        % tmp (N*1) is covariance matrix
        tmp = sum((shift'*inv_sigma).*shift', 2);     
        coef = (2*pi)^(-d/2)*sqrt(det(inv_sigma));  %we drop the constant as the numerator and denominator will cancel out
        P(:, j) = coef * exp(-0.5*tmp);  
    end
end
