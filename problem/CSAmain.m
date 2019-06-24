function CSAmain()
Cn = [220 208 198 192 180 180 165 162 160 ...
    158 155 130 125 122 120 118 115 110 105 101 ...
    100 100 98 96 95 90 88 82 80 77 75 73 72 70 ...
    69 66 65 63 60 58 56 50 30 20 15 10 8 5 3 1];
Wn = [80 82 85 70 72 70 66 50 55 25 50 ...
    55 40 48 50 32 22 60 30 32 40 38 35 32 25 28 ...
    30 22 50 30 45 30 60 50 20 65 20 25 30 10 20 ...
    25 15 10 10 10 4 4 2 1];
W = 1000;
N = 100;
n = length(Cn);
GenMax = 1000;
alpha = 0.4;
Pm = 1/n;
mu = 0.1;
k = 10 * sum(Cn)/sum(Wn);
solution = randi([0,1],N,n);
t = 1;
OptimalValue = sum(Cn(solution(1,:)==1));
Gbest = solution(1,:);
while t <= GenMax
    fit = FitnessFun(Cn,Wn,solution,W,k);
    for i = 1:ceil(alpha*N)
        [~,location] = max(fit);
        fit_B(i) = fit(location);
        fit(location) = -1;
        B(i,:) = solution(location,:);
    end
    i = 1;l=1;
    while l <= ceil(alpha*N)
        Nc = ceil(N*(fit_B(l)/sum(fit_B)));
        for m = i:i+Nc-1
            C(m,:) = B(l,:);
        end
        i = i + Nc;
        l = l + 1;
    end
    D = mutation(C,Pm);
    fit_D = FitnessFun(Cn,Wn,D,W,k);
    for i = 1:N
        [~,location] = max(fit_D);
        fit_E(i) = fit_D(location);
        fit_D(location) = -1;
        E(i,:) = D(location,:);
    end
    for i = 1:floor(mu*N)
        [~,location] = min(fit_E);
        fit_E(location) = Inf;
        E(location,:) = randi([0,1],1,n);
    end
    solution = E;
    fit_solution = FitnessFun(Cn,Wn,solution,W,k);
    [~,location] = max(fit_solution);
    max_solution = solution(location,:);
    Pbest(t) = sum(Cn(max_solution==1));
    if Pbest(t) >= OptimalValue
        OptimalValue = Pbest(t);
        Gbest = max_solution;
    end
    t = t + 1;
end
disp('最优值：')
disp(OptimalValue)
disp('最优解：')
disp(Gbest)
x = 0:1:GenMax-1;
plot(x,Pbest,'-.r')
xlabel('Generation')
ylabel('Single generation optimal solution')