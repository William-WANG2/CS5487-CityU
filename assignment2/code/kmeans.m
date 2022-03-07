function [z, mu] = kmeans(k, x, maxiteration, round)
    %% Function Parameter Notes
    % x represents number and dimension
    % k is the pre-defined number of clusters
    % maxiteration is the maximum number of iterations we allow in every
    % k-means
    % round is the number of iterations of k-means
    %we run several iteration of k-means to get the convergence with least
    %totdis where totdis indicates the sum of distance between data points
    %to its cluster
    totdis = inf;
    for r = 1:round
        % initialization: random select k points
        max_x = max(x, [], 2);
        min_x = min(x, [], 2);
        d = size(x, 1);
        n = size(x, 2);
        rnd = randperm(n);
        temp_mu = x(:, rnd(1:k));
        
        %iteration
        iterator = 0;
        prev_dis = 0;
        while iterator < maxiteration
            iterator = iterator+1;
            %cal Distance
            D = zeros(n, k);
            for i = 1:n
                for j = 1:k
                    D(i, j) = sum((x(:,i)-temp_mu(:,j)).^2);
                end
            end
            %assignment
            temp_z = zeros(n, k);
            [~,idx] = min(D, [], 2);
            for i = 1:n
                temp_z(i, idx(i)) = 1;
            end
            %cal mu
            for j = 1:k
                temp_mu(:,j) = sum(temp_z(:,j).*(x'))'/sum(temp_z(:,j));
            end
            %compute the total distance of the data to the cluster
            temp_dis = 0;
            for i = 1:n
                for j = 1:k
                    if temp_z(i,j)==1
                        temp_dis = temp_dis + sum((x(:,i)-temp_mu(:,j)).^2);
                    end
                end
            end
            if(norm(temp_dis-prev_dis) < exp(-10))
                break;
            else
                prev_dis = temp_dis;
            end
        end

        %update z, mu and totdis if any
        if temp_dis < totdis
            totdis = temp_dis;
            mu = temp_mu;
            z = temp_z;
        end
    end
end