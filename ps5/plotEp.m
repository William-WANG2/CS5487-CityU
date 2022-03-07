x = 0:0.01:3;

val = [Ep(x, 1, 1); Ep(x, 1, 1/4); Ep(x, 1, 1/16)];

plot(x, val);

legend(["h = 1", "h = 1/4", "h = 1/16"])

%% 
h = 0.01/(2*log(10));
a = 1;
x = 0:0.0001:0.55;
val = Ep(x, a, h);
plot(x, val);
ylim([0 1.2])

%% 

u = [5 5]; Sigma = [100 0; 0 100];

u2 = [1 1];
u3 = [2 7];
[X1,X2] = meshgrid(linspace(-20,20,60)', linspace(-20,20,60)'); 
X = [X1(:) X2(:)]; 
p = mvnpdf(X, u, Sigma); 

p2 = mvnpdf(X, u2, Sigma);
p3 = mvnpdf(X, u3, Sigma);
surf(X1,X2,reshape(p,size(X1)));
hold on
surf(X1,X2,reshape(p2,size(X1)));
surf(X1,X2,reshape(p3,size(X1)));
hold off
colorbar
title('条件概率密度函数曲线');

