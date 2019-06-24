function aff = affinity(pn,Wn,x,C)
%% Ç×ºÍÁ¦º¯Êý
fx = sum(x.*pn);
gx = sum(x.*Wn) - C;
if gx <= 0
    aff = fx;
else
    aff = 1/(gx+1);
end
