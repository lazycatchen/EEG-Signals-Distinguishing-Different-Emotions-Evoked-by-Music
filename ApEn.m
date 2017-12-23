function Amean=ApEn(A)
%filename='F:\data\2010.06.06\jiequ\1.txt';
% load(input);
% A=data_single{1, 15}(5121:7680,12)*10;%偶数项为脑电信号
m=2;
r=0.2;
%A=load(input);
G=length(A);
N=1024;%每次计算的序列长度
g=128;%每次滑动的点数
t=((G-N)/g);
h=floor(t);
Em=zeros(h,1);
for i=0:h %滑动的次数
    data=A(1+i*g:N+i*g);%数据滑动读取
    R=r*std(data,1);
   Em(i+1)=Bm(data,R,m,N)-Bm(data,R,m+1,N);
end
Amean=mean(Em);
% fid1=fopen(output,'at+');
% fprintf(fid1,'%f\r\n',Em);
% fclose(fid1);
% fid=fopen(output,'at+');
% fprintf(fid,'%f\r\n',Amean);
% fclose(fid);
