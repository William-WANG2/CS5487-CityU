function [z, N, pi, mu, sigma] = emgmm(x, k, maxiteration, round)
    %% Function Parameter Notes
    % x represents number and dimension
    % k is the pre-defined number of clusters
    % maxiteration is the maximum number of iterations we allow in every
    % emgmm
    % round is the number of iterations of emgmm
    % we run several iteration of emgmm to get the convergence with largest
    % data log likelihood

    d = size(x, 1);
    n = size(x, 2);
    alpha = 0.5*eye(d, d); %regularization constant to avoid singular
    likelihood = -exp(30);
    for r = 1:round
        %initialization
        rnd = randperm(n);
        temp_mu = x(:, rnd(1:k));
        [temp_pi, temp_sigma] = init_parameter(x, temp_mu, k);
        iterator = 0;
        temp_z = zeros(n, k);
        ll = -exp(30);
        while iterator < maxiteration
            iterator = iterator+1;
            %E-step
            %P is n*k matrix of probability of gaussian (drop out the constant terms)
            P = multiGaussian(x, k, temp_mu, temp_sigma);
            weightedsum = sum(temp_pi' .* P, 2);
            temp_z = temp_pi' .* P ./weightedsum;

            %M_step
            temp_N = (sum(temp_z))';
            temp_pi = temp_N./n;
            temp_mu = x * temp_z ./temp_N';
            temp_sigma = zeros(d, d, k);
            for j = 1:k
                shift = x - repmat(temp_mu(:,j), 1, n);
                temp_sigma(:,:,j) = shift * diag(temp_z(:,j)) * shift'./temp_N(j);
                temp_sigma(:,:,j) = temp_sigma(:,:,j) + alpha;
            end
            
            %loglikelihood
            temp_ll = log(sum(P * temp_pi));
            
            %determine convergence
            if(abs((temp_ll - ll)/abs(ll)) < exp(-6))
                ll = temp_ll;
                break
            end
            ll = temp_ll;
        end

        %test the goodness of initialization
        if(ll > likelihood)
            likelihood = ll;
            z = temp_z;
            N = temp_N;
            pi = temp_pi;
            mu = temp_mu;
            sigma = temp_sigma;
        end
    end
end