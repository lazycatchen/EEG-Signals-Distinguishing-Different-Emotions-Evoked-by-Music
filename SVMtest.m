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
datax=datamap(datax);
rate_ave=zeros(12,1);
%% c g初始化 遗传算法
% datay=[add datax];
% num_1=size(datay,1);
% k=rand(1,num_1);
% [m,n]=sort(k);
% traindata_1=datay(n(1:num_1),2:end);
% trainlabel_1=datay(n(1:num_1),1);
% 
% ga_option.maxgen = 200;
% ga_option.sizepop = 20; 
% ga_option.cbound = [0,100];
% ga_option.gbound = [0,100];
% ga_option.v = 5;
% ga_option.ggap = 0.9;
%  [bestacc,bestc,bestg] = gaSVMcgForClass(trainlabel_1,traindata_1,ga_option);
% bestg=54.2398;%1.736547; %%原107维计算出来惩罚参数
% bestc=7.824;
% bestacc=25;
% bestg=5.78299; %%GA+CFS计算出来惩罚参数
%%
% opt_feature=cell(8,12);
for jj=11:12
dataxx=datax(:,27*jj-26:27*jj);

%%
for select=1:27;
disp(['正在坑爹的计算',num2str(jj),'电极']);
%*******************cfs*************
% [cfs_num,index_cfs]=brain_CFS(dataxx, select,(1:27));
% opt_feature{select-1,jj}=index_cfs;
% dataxy=dataxx(:,index_cfs);
%********************************************

%*******************info_cfs*************

Merits=importdata(strr);
info_index=Merits{1,jj}(3,1:select);
dataxy=dataxx(:,info_index);

%********************************************

% dataxy=dataxx;
%************************************
data=[add dataxy];

num=size(data,1);
k=rand(1,num);
[m,n]=sort(k);
traindata=data(n(1:num),2:end);
trainlabel=data(n(1:num),1);

%% 循环100次
tic
roop_num=100;
for count=1:roop_num
discount=0.9;
k=rand(1,num);
[m,n]=sort(k);
traindata=data(n(1:num*discount),2:end);
trainlabel=data(n(1:num*discount),1);
testdata=data(n(num*discount+1:num),2:end);
testlabel=data(n(num*discount+1:num),1);

%% 
% [bestacc,bestc,bestg] =psoSVMcgForClass(trainlabel,traindata);
cmd = ['-s 1 ','-t 2 ','-c ',num2str(bestc),' -g ',num2str(bestg)];
% cmd = ['-s 1 ','-t 2 ','-c ',2,' -g ',1];
%%
 model=svmtrain(trainlabel,traindata,cmd);
 [ptrain,accuracy,acctrain]=svmpredict(trainlabel,traindata,model);
 [ptest,accuracy1,acctest]=svmpredict(testlabel,testdata,model);
 [m,n]=find(testlabel==ptest);
 
 kk=zeros(1,4);
 for right_num=1:size(testlabel,1)
     switch testlabel(right_num)
         case 1
             kk(1,1)=kk(1,1)+1;
         case 2
             kk(1,2)=kk(1,2)+1;    
         case 3
             kk(1,3)=kk(1,3)+1;  
         case 4
             kk(1,4)=kk(1,4)+1;         
     end      
             
 end

k1=zeros(1,4);
 for right_num=1:size(testlabel(m),1)
     switch testlabel(m(right_num))
         case 1
             k1(1,1)=k1(1,1)+1;
         case 2
             k1(1,2)=k1(1,2)+1;    
         case 3
             k1(1,3)=k1(1,3)+1;  
         case 4
             k1(1,4)=k1(1,4)+1;    
     end      
             
 end
 
%  picture1(count,:)=testlabel;
%  picture2(count,:)=ptest; 
 rate_single(count,:)=k1./kk;
 AA(count)=accuracy1(1,1);
%  str=['计算次数',num2str(count)];
%  clc;
%  disp(str) 
end
toc

rate_single(any(isnan(rate_single),2),:)=[];
% rate_s=mean(rate_single);
rate_s=sum(sum(rate_single)/100)/4;
rate_ave(jj,select)=mean(rate_s);

AA_ave(jj,select)=mean(AA);
end 
% rate=mean(AA)
end
str2=[strx 'recogn_ave'];  
eval(['save ' str2 ' rate_ave']);

% str3=[mydir 'opt_cfs'];
% eval(['save ' str3 ' opt_feature']);

str4=[strx 'AA_finial_ave'];  
eval(['save ' str4 ' AA_ave']);
disp(mydir);
% plot(rate_ave);
% figure;
% hold on;
% plot(picture1(1,:),'o','LineWidth',1);
% plot(picture2(1,:),'r*','LineWidth',1);
% xlabel('SVM验证GA+CFS方法测试集样本分类图','FontSize',14);
% ylabel('分类标签','FontSize',14);
% legend('实际测试集分类','预测测试集分类');
% % title('SVM验证GA+CFS方法分类图','FontSize',12);
% grid on;

