%%  求解样本熵  Sample  Entropy
function [SampEn]=SampEn(xdate)
N=length(xdate);
n=N;
x=xdate;
p= 0.15;   % p  可以选择  在 0.1~0.25
r=p*std(xdate);
%%  求解m=2
m=2;
num=zeros(1,N-m+1);
x2m=zeros(n-m+1,m);%存放变换后的向量
d=zeros(n-m+1,n-m);% 存放距离结果的矩阵
  for i=1:n-m+1  
    for j=1:m   
        x2m(i,j)=xdate(i+j-1); 
    end
  end
  k=1; 
  for i=1:n-m+1 
    for j=1:n-m+1
        if i~=j
            d(i,k)=max(abs(x2m(i,:)-x2m(j,:)));%计算各个元素和响应元素的距离?
            k=k+1;
        end
    end
    k=1;
  end
for  i=1:N-m+1
    for  j=1:N-m
    if d(i,j)<r
        num(i)=num(i)+1;
    end
    end
end
 c=num/(N-m);
 D2=sum(c);
 D2=D2/(N-m+1);
%%  求解m=3
m=3;
num=zeros(1,N-m+1);
x2m=zeros(n-m+1,m);%存放变换后的向量
d=zeros(n-m+1,n-m);% 存放距离结果的矩阵
  for i=1:n-m+1  
    for j=1:m   
        x2m(i,j)=xdate(i+j-1); 
    end
  end
  k=1; 
  for i=1:n-m+1 
    for j=1:n-m+1
        if i~=j
            d(i,k)=max(abs(x2m(i,:)-x2m(j,:)));%计算各个元素和响应元素的距离?
            k=k+1;
        end
    end
    k=1;
  end
for  i=1:N-m+1
    for  j=1:N-m
    if d(i,j)<r
        num(i)=num(i)+1;
    end
    end
end
 c=num/(N-m);
 D3=sum(c);
 D3=D3/(N-m+1);
%%  求得样本熵
SampEn=log(D2/D3);