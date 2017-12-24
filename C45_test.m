
clc;
clear;
close all;

mydir=uigetdir('E:\aa0011\音乐+脑电\database\data\addwavle\','选择一个目录');

% mydir=uigetdir('E:\aa0011\音乐+脑电\database\data\feature_backup_origin\','选择一个目录');
if mydir(end)~='\'
 mydir=[mydir,'\'];
end
DIRS=dir([mydir,'*.mat']);  %扩展名
n=length(DIRS);
for i=1:n
    if ~DIRS(i).isdir
    filename=DIRS(i).name;
    str=[mydir filename];
    end
    temp=importdata(str);
    datax(i*20-19:i*20,:)=temp{1, 20};
end
strx=mydir(1:end-8);
strr=[strx 'info_Merits.mat'];
add1=ones(size(datax,1)/4,1);
add=[add1;add1*2;add1*3;add1*4];

%%
% data(1:500,:)=c1(1:500,:);
% data(501:1000,:)=c2(1:500,:);
% data(1001:1500,:)=c3(1:500,:);
% data(1501:2000,:)=c4(1:500,:);

%从1到2000间随机排序
k=rand(1,length(add));
% [m,n]=sort(k);

%输入输出数据
% input=datamap(data(:,2:25));
% input=data(:,2:25);
% output =data(:,1);

for jj=10:12
    
dataxx=datax(:,27*jj-26:27*jj);
sub_feature1=[4,8,10,14,16,17];
sub_feature2=[20,21,22,24,25,26];
sub_feature={sub_feature1;sub_feature2;[sub_feature1 sub_feature2]};
for roop_num=1:3
%     info_index=sub_feature{1,roop_num};
     info_index=sub_feature{roop_num,1};% 此为验证用时写
%      for roop_num=3:27

% datay=[add dataxx]; 
%***********************
% Merits=importdata(strr);
% info_index=Merits{1,jj}(3,1:roop_num);
% dataxy=dataxx(:,info_index);
dataxy=dataxx(:,info_index);
%*************************
for roop=1:10
    try
k=rand(1,length(add));
[m,n]=sort(k);
input=dataxy;
output =add;
input_train=input(n(1:72),:)';
output_train=output(n(1:72),:)';
input_test=input(n(73:80),:)';
output_test=output(n(73:80),:)';
output_traget=C4_5(input_train, output_train, input_test, 7, 10);
[a,b]=find(output_test==output_traget);
single_reco(1,roop)=length(a)/8;
    catch
        continue
    end
end
% disp(length(a)/8);
% recog(jj,roop_num-2)=mean(single_reco);
recog(jj,roop_num)=mean(single_reco);
disp(['计算',num2str(jj),'电极',num2str(roop_num),'特征'])
end
end
str2=[strx 'c45_recogn_three'];  
eval(['save ' str2 ' recog']);
disp(str2);
load gong;
sound(y,Fs);