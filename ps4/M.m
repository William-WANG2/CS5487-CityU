function [lambda, w] = M(z, x, num)
    totz = sum(z, 1);
    totxz = sum((z.*x), 1);
    lambda = totxz./totz;
    w = totz./num;
end