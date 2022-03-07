
function z = E(w, lambda, x, component, num)
    z = ones(num, component);
    for i = 1:num
        totsum = sum(w.*exp(-lambda).*(lambda.^x(i)));
        for j = 1:component
            z(i, j) = w(j) * exp(-lambda(j)) * (lambda(j).^x(i))/(totsum);
        end
    end
end