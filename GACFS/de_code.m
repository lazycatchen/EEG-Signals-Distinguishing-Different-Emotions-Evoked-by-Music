function Merits=de_code(x)


%%  cfs
global S  data1
% global p t r s s1 s2
% 数据提取
xx=data1(:,1:S);
[mx,nx]=find(x==1);%nx 参与建模的特征
xnew=xx(:,nx);
n=length(nx);%个数
if n==2
    Merits=0;
else
m=length(data1);
select=nchoosek((1:n),2);

for i=1:length(select)
   cf(1,i)=corr(xnew(:,(select(i,1))),xnew(:,(select(i,2))) );%两两相关系数
end
cff=mean(cf);
ff=corr(xnew,data1);
fff=mean(mean(ff));
Merits=(n*cff)./sqrt(n+n*(n-1)*fff);
end
%%



end