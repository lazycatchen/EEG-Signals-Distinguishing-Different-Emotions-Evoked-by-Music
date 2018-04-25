% clc;clear all;

% clear
% 
% load ('pingjing.mat');
% data(1:50,:)=xx(1:50,:);
% 
% load  ('kongju.mat');
% data(51:100,:)=xx(1:50,:);
% 
% load ('gaoxing.mat');
% data(101:150,:)=xx(1:50,:);
% 
% load ('jingya.mat');
% data(151:200,:)=xx(1:50,:);
%  
% load ('beishang.mat');
% data(201:250,:)=xx(1:50,:);
% 
% load ('fennu.mat');
% data(251:300,:)=xx(1:50,:);
% % 降维
%       gnd = [ones(50,1)*1;ones(50,1)*2;ones(50,1)*3;ones(50,1)*4;ones(50,1)*5;ones(50,1)*6];
% 
%       options = [];
%       options.gnd = gnd;
%       FeaNumCandi = [6:2:32];
% 
%       [FeaIndex,FeaNumCandi] = MCFS_p(data,FeaNumCandi,options);
% 
%       for i = 1:length(FeaNumCandi)
%           SelectFeaIdx = FeaIndex{i};  
%           data1 = data(:,SelectFeaIdx);
%       end
% data1=data(:,[28;15;20;25;61;46;41;17;18;27;23;19;24;26;14;13;16;21;22;11]);
% data1=data(:,[11;22;21;16;26;13;14;26;24;19;23]);
% data1=data(:,[41;46;36;32]);
% [15;17;18;19;20;21;24;25;27;28;30;36;41]
% data1=data(:,[11;22;21;16;13;14;26;24;19;23;18;17;25;20;15])%15维基频向量
% data1=data(:,[41;46;61;36;32])
% add1=ones(size(data,1)/3,1);
% add2=ones(size(data,1)/3,1)*2;
% add3=ones(size(data,1)/3,1)*3;
% add4=ones(size(data,1)/6,1)*4;
% add5=ones(size(data,1)/6,1)*5;
% add6=ones(size(data,1)/6,1)*6;
% add=[add1;add2;add3];%%数据标号
% data=[data1 add];
% A=data;
clc;
clear;
A=importdata('1.txt');
A=A.data;
A=A(:,1:6)
% A=A(:,3:end);

% temp1=ones(size(a,1),1)*1;
% temp2=ones(size(a,1)/2,1);
% temp=[temp1;temp2]
% A=[a temp];

for i=1:size(A,2);
    temp=A(:,i);
    temp=(temp-min(temp))/(max(temp)-min(temp));%归一化%
    A(:,i)=temp;
    B=corr(A,'type','Spearman');%求数据的相关性%
    C=abs(B);
end
A=B;
% A=data;%读取归一化之后的相关性矩阵%
f=1:6;%f代表共有多少特征%
k=2;%k代表选择的特征个数%
a=nchoosek(f,k);
Merits=cfs(A,k,f);
b=find(Merits==max(max(Merits)));
c=a(b,:)
