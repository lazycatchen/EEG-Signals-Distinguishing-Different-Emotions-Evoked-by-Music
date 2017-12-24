function [data]=datamap(datax)
% [data,y]=mapminmax(datax,-1,1);
[x,y]=size(datax);

for i = 1:y

    data(:,i)=datax(:,i)/norm(datax(:,i));

end