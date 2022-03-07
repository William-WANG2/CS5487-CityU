%% Choose the HyperParameter by hand

function res = choosingHyper(small, big, interval, d, polyx, polyy, sampx, sampy, model, mode)
    if strcmp(mode, "original")
        phi_train = sampx;
        phi_test = polyx;
    elseif strcmp(mode, "poly")
        phi_train = Transform(sampx, d);
        phi_test = Transform(polyx, d);
    elseif strcmp(mode, "general_nocross")
        phi_train = Transform_general(sampx, d, "nocross");
        phi_test = Transform_general(polyx, d, "nocross");
    end

    res = 0;
    err = Inf;
    if strcmp(model, "RLS")
        for lambda = small:interval:big
            temp_theta = RLS(phi_train, sampy, lambda);
            temp_err = calMeanSquaredErr(phi_test' * temp_theta, polyy);
            if(temp_err < err)
                err = temp_err;
                res = lambda;
            end
        end
    elseif strcmp(model, "LASSO")
        for lambda = small:interval:big
            temp_theta = LASSO(phi_train, sampy, lambda);
            temp_err = calMeanSquaredErr(phi_test' * temp_theta, polyy);
            if(temp_err < err)
                err = temp_err;
                res = lambda;
            end
        end
    elseif strcmp(model, "BR")
        for alpha = small:interval:big
            %sigma_square = 5 is hardcoded based on the question
            [mean, ~] = BR(phi_train, sampy, alpha, 5);
            temp_err = calMeanSquaredErr(phi_test' * mean, polyy);
            if(temp_err < err)
                err = temp_err;
                res = alpha;
            end
        end
    end
end
