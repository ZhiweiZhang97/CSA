function new_solution = ReceptorEditing(solution,Tr,sigma)
%% КЬМе±ај­
n = size(solution,2);
new_solution = solution;
for i = 1:size(solution,1)
    randT = rand(1);
    if randT <= Tr
        q = randi([1,50],1,1);
    else
        continue
    end
    [Ge,m] = GenePool(n,sigma);
    Ge = Ge(randi([1,m],1,1),:);
    if q + length(Ge)-1 <= n
        new_solution(i,[q:q+length(Ge)-1]) = Ge;
    else
        new_solution(i,[q:n]) = Ge(1:n-q+1);
        new_solution(i,[1:length(Ge)-(n-q+1)]) = Ge(n-q+2:end);
    end
end