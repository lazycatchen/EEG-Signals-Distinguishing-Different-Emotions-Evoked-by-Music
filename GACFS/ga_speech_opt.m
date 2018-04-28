% function[n]=ga_speech_opt(~)
%% 音乐
angry=importdata('E:\aa0011\音乐+脑电\database\data_songs\angry1.mat');
clam=importdata('E:\aa0011\音乐+脑电\database\data_songs\calm1.mat');
joy=importdata('E:\aa0011\音乐+脑电\database\data_songs\joy1.mat');
sad=importdata('E:\aa0011\音乐+脑电\database\data_songs\sad1.mat');

data=[angry;clam;joy(1:20,:);sad];
temp=importdata('opt_feature.mat');
temp1=importdata('opt_feature1.mat');
temp2=importdata('opt_feature2.mat');
data=data(:,temp(:,temp1(:,temp2)));

lable1=ones(1,20)';
lable=[lable1;lable1*2;lable1*3;lable1*4];
data=[lable data];
data(isnan(data))=0;

% data=data(:,1:31);

%% 语音
% happy=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_happy.mat');
% angry=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_angry.mat');
% surprise=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_surprise.mat');
% sad=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_sad.mat');
% fear=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_fear.mat');
% neutral=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_neutral.mat');
% % data=[happy(:,1:60);angry(:,1:60);surprise(:,1:60);sad(:,1:60);fear(:,1:60);neutral(:,1:60)];
% data=[happy;angry;surprise;sad;fear;neutral];
% data=data';
% data(any(isnan(data),2),:)=[];
% data=data';
% 
% lable1=ones(1,50)';
% lable=[lable1;lable1*2;lable1*3;lable1*4;lable1*5;lable1*6];
% data=[lable data];
% data(isnan(data))=0;
%%
global  P_train T_train P_test T_test mint maxt 
global S s1 data1
S=size(data,2)-1;
s1=30;
data1=datamap(data(:,2:end));

%%
a=randperm(80);
Train=data(a(1:72),:);
Test=data(a(73:end),:);
% 训练数据
P_train=Train(:,2:end)';
T_train=Train(:,1)';
% 测试数据
P_test=Test(:,2:end)';
T_test=Test(:,1)';
%%
[P_train,minp,maxp,T_train,mint,maxt]=premnmx(P_train,T_train);
P_test=tramnmx(P_test,minp,maxp);
%% 初始种群
popu=30;  
bounds=ones(S,1)*[0,1];
% 产生初始种群
% initPop=crtbp(popu,S);
initPop=randint(popu,S,[0 1]);
% 计算初始种群适应度
initFit=zeros(popu,1);
for i=1:size(initPop,1)
    initFit(i)=de_code(initPop(i,:));
end
initPop=[initPop initFit];
gen=200; 
%%
[X,EndPop,BPop,Trace]=ga(bounds,'fitness',[],initPop,[1e-6 1 0],'maxGenTerm',...
    gen,'normGeomSelect',0.1,'simpleXover',8,'boundaryMutation',[2 gen 3]);
[m,n]=find(X==1);
disp(['优化筛选后的输入自变量编号为:' num2str(n)]);
figure
plot(Trace(:,1),Trace(:,3),'r:')
hold on
plot(Trace(:,1),Trace(:,2),'b')
xlabel('进化代数')
ylabel('适应度函数')
title('适应度函数进化曲线')
legend('平均适应度函数','最佳适应度函数')
xlim([1 gen])
