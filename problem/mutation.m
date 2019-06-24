function new_solution = mutation(solution,Pm)
n = size(solution,2);
m = randi([1,10],1,1);
new_solution = solution;
for i = 1:size(solution,1)
    ismutation = rand();
    if ismutation >= Pm
        q = randi([1,size(solution,2)],1,1);
    else
        continue
    end
    Ge = randi([0,1],1,m);
    if q + length(Ge)-1 <= n
        new_solution(i,[q:q+length(Ge)-1]) = Ge;
    else
        new_solution(i,[q:n]) = Ge(1:n-q+1);
        new_solution(i,[1:length(Ge)-(n-q+1)]) = Ge(n-q+2:end);
    end
end