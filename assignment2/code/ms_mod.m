function [centroid, ass] = ms_mod(x, hc, hp, maxiteration)
    %% Function Parameter Notes
    % x represents number and dimension
    % maxiteration is the maximum number of iterations we allow in every
    % h is the bandwidth of the kernal
    h = hc;
    x = [x(1:2, :); x(3:4, :)/(hp/hc)];
    [d, n] = size(x);
    centroid = [];
    ass = zeros(n, 1);
    threshold = 0.01;
    for k = 1:n
        iterator = 0;
        prev = x(:, k);
        while iterator < maxiteration
            %convergence
            %drop out the constant term
            cur = sum(x .* exp(-sum((x-prev).*(x-prev)/(h*h))), 2);
            sumpdf = sum(exp(-sum((x-prev).*(x-prev)/(h*h))), 2);
            cur = (cur/sumpdf);
            if(norm(prev-cur)/norm(prev)<exp(-10))
                break;
            end
            prev = cur;
        end
        %decide whether it is a new centroid
        ifmerge = 1;
        for i = 1:size(centroid,2)
            if(norm(centroid(:,i)-prev)/norm(prev)<threshold)
                ifmerge = 0;
                assidx = i;
            end
        end
        if ifmerge
            centroid = [centroid, prev];
            ass(k) = size(centroid, 2);
        else
            ass(k) = assidx;
        end
    end
end

