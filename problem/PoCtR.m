clear;
home;
m=4; %商人、仆人数
z=2; %船上可载人数

m=m+1; %矩阵中不存在0位置
A=zeros(m); %列表示商人，行表示仆人
for i=0:m-1 %寻找安全状态，1为安全，0为不安全
    for j=0:m-1
        if (i==j)||(i==m-1)||(i==0)
            A(i+1,j+1)=1;
        end
    end
end
s={}; %用来存放路径
p=1;  %用来表示放在每一行的第几列
R=[]; %特殊情况
s{1,1}=[m,m,1]; %[a,b,c]a表示此岸商人数，b表示此岸仆人数，c表示由上面情况c推的

for t=1:100 %循环上界适当
    flag=0; %用来判断是否重复
    trump=0; %用来判断是否已经存在可安全渡河的情况
    k=t; %k表示渡河次数
    if z>=2*(m-1) %当船载人数大于或等于总人数
        k=1 
        R=[m-1,m-1;0,0]
        break;
    end 
    
    for a=1:sum(~cellfun(@isempty, s(k,:))) %表示有几种情况（相对于同一个k来说）
        if a==1 %第一种情况，从第一个列开始存
            p=1;
        end
        n1=s{k,a}(1,1); %赋值，商人数
        n2=s{k,a}(1,2); %赋值，仆人数
        
        for i=0:z %渡河
            for j=0:z
                if (i+j>=1 && i+j<=z) && (n1+i*(-1)^k<=m && n1+i*(-1)^k>=1) && (n2+j*(-1)^k<=m && n2+j*(-1)^k>=1) && (A(n1+i*(-1)^k,n2+j*(-1)^k)==1)
                %条件判断
                    if k>=2 %判断是否重复
                        for e=1:sum(~cellfun(@isempty, s(k-1,:)))
                            if (s{k-1,e}(1,1)==n1+i*(-1)^k) && (s{k-1,e}(1,2)==n2+j*(-1)^k)
                                flag=1; %如果发现重复，则flag==1
                                break;
                            end
                        end
                    end
                    if flag==0 %不重复存入
                        s{k+1,p}=[n1+i*(-1)^k,n2+j*(-1)^k,a];
                        p=p+1;
                    end
                    flag=0; %每一次判断之后flag都要归0
                end
            end
        end
    end
    
    k=k+1; %一次考虑完后k+1
    s{k+1,1}=[]; %往下创建空cell
    if sum(~cellfun(@isempty, s(k,:)))==0 %判断是否有新的情况生成，0表示s{k,:}全部为空
        'No answer!'
        break;
    end
    
    for win=1:sum(~cellfun(@isempty, s(k,:))) %判断是否已有完成任务的情况
        if s{k,win}(1,1)==1 && s{k,win}(1,2)==1
            trump=1;
            break;
        end
    end
    if trump==1
        k=k-1
        break;
    end
end

if trump==1  %输出一组结果
    W=[];
    qq=win;
    for oo=1:k+1
        W(oo,1)=s{k+2-oo,qq}(1,1)-1;
        W(oo,2)=s{k+2-oo,qq}(1,2)-1;
        qq=s{k+2-oo,qq}(1,3);
    end
    W=flipud(W)
end