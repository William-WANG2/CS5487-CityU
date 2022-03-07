function logloss = ll(z, w, x, lambda)
    tot = 0;
    for i = 1:size(z, 1)
        tot = tot + log(sum(w.*(1/factorial(x(i)).*exp(-lambda).*lambda.^(x(i)))));
    end
    logloss = tot;
end
