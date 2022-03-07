function val = Ep(x, a, h)
    con1 = x > 0;
    con2 = a>=x;
    con3 = x>a;
    val = (1/a * (1 - exp(-x./h)).*con2 + 1/a * (exp(a/h) - 1)*exp(-x./h).*con3).*(con1);
end