function G = GreedyAlgorithm(Cn,Wn,W)
%% 贪婪算法，依据价格密度构造初始解
% Cn：价格
% Wn：重量
% W： 背包最大承重量
D = Cn./Wn;
G = zeros(1,length(Cn));
while 1
    [~,base] = max(D);
    D(base) = 0;
    if sum(Wn(G==1)) + Wn(base) < W+0.00015
        G(base) = 1;
    else
        break
    end
end
end