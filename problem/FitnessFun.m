function Fit = FitnessFun(Pn,Wn,solution,C,k)
for i = 1:size(solution,1)
    x = solution(i,:);
    fx = x*Pn';
    gx = x*Wn' - C;
    Fit(i) = fx - k*max(gx,0);
end
end