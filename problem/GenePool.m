function [Ge,m] = GenePool(n,sigma)
%% 生成基因库
if mod(n,sigma) == 0
    m = n/sigma;
    l1 = sigma;
    l2 = sigma;
else
    m = floor(n/sigma) + 1;
    l1 = sigma;
    l2 = n - (m - 1) * sigma;
end
Ge = [];
for i = 1:m
    if i < m
        Ge(i,:) = randi([0,1],1,l1);
    else
        Ge(i,:) = randi([0,1],1,l2);
    end
end