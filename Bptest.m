
clc;
clear;
close all;

mydir=uigetdir('E:\aa0011\音乐+脑电\database\data\','选择一个目录');

% mydir=uigetdir('E:\aa0011\音乐+脑电\database\data\feature_backup_origin\','选择一个目录');
if mydir(end)~='\'
 mydir=[mydir,'\'];
end
DIRS=dir([mydir]);  %扩展名
n=length(DIRS);

for i=3:n
   %*************打开文件****************
    filename=DIRS(i).name;
    strxy=[mydir filename '\feature'];
    if strxy(end)~='\'
       strxy=[strxy,'\'];
    end
    DIRS1=dir([strxy,'*.mat']);
    for ii=1:length(DIRS1)
        filename1=DIRS1(ii).name;
        str=[strxy filename1];
       temp=importdata(str);
       datax(ii*20-19:ii*20,:)=temp{1, 20};
    end
    strx=strxy(1:end-8);
    strr=[strx 'info_Merits.mat'];
%     Merits=importdata(strr);

sub_feature1=[4,8,10,14,16,17];
sub_feature2=[20,21,22,24,25,26];
Merits={sub_feature1;sub_feature2;[sub_feature1 sub_feature2]}';
%*******************BP验证*****************
    disp(['boom沙卡拉卡 正在计算 ',strx(end-5:end-1)]);
    BP_recogn=BP_child(datax,Merits);
    str2=[strx 'BP1_recogn_three4'];  
    eval(['save ' str2 ' BP_recogn']);
    
end
