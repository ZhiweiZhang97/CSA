function Gn = RepairSolution(Cn,Wn,Gn,W)
%% 依照价值密度对解进行修复/改进
% Cn：价格
% Wn：重量
% Gn：输入：当前解，输出：修复/改进后解
% W： 背包最大承重量
rho = Cn./Wn;
sigma = Cn./Wn;
if sum(Wn(Gn==1)) > W
    rho(Gn==0) = Inf;
    while 1
        [~,base] = min(rho);
        rho(base) = Inf;
        if sum(Wn(Gn==1)) > W
            Gn(base) = 0;
        else
            break
        end
    end
end
if sum(Wn(Gn==1)) < W
    sigma(Gn==1) = 0;
    while 1
        [~,base] = max(sigma);
        sigma(base) = 0;
        if sum(Wn(Gn==1)) + Wn(base) < W
            Gn(base) = 1;
        else
            break
        end
    end
end
end