
%(a) initilization


K = 5;
n = 576;


london = [zeros(229, 1); ones(211, 1); 2*ones(93, 1); 3*ones(35, 1); 4*ones(7, 1); 5*ones(1,1)];
Antwerp = [zeros(325, 1); ones(115, 1); 2*ones(67, 1); 3*ones(30, 1); 4*ones(18, 1); 5*ones(21,1)];
logloss_london = ones(K, 1);
logloss_Antwerp = ones(K, 1);

lambda_london = zeros(K, K);
lambda_Antwerp = zeros(K, K);

for k = 1:5
    w = 1/k * ones(1, k);
    lambda = rand(1, k)*3;
    z = E(w, lambda, london, k, n);
    temp = ll(z,w,london,lambda);
    while abs(logloss_london(k)-temp)/abs(logloss_london(k)) > exp(-10)
        logloss_london(k) = temp;
        [lambda, w] = M(z, london, n);
        z = E(w, lambda, london, k, n);
        temp = ll(z,w,london,lambda);
    end
    lambda_london(k,1:k) = lambda;
end


w = 1;
lambda = 2*rand();
for k = 1:5
    w = 1/k * ones(1, k);
    lambda = rand(1, k)*3;
    z = E(w, lambda, Antwerp, k, n);
    temp = ll(z,w,Antwerp,lambda);
    while abs(logloss_Antwerp(k)-temp)/abs(logloss_Antwerp(k)) > exp(-10)
        logloss_Antwerp(k) = temp;
        [lambda, w] = M(z, Antwerp, n);
        z = E(w, lambda, Antwerp, k, n);
        temp = ll(z,w,Antwerp,lambda);
    end
    lambda_Antwerp(k,1:k) = lambda;
end
%% 

plot(1:5, logloss_london);
xlabel("Number of Component(s)");
ylabel("Log Loss");
title("Log Loss for London");
%% 

plot(1:5, logloss_Antwerp);
xlabel("Number of Component(s)");
ylabel("Log Loss");
title("Log Loss for Antwerp");
