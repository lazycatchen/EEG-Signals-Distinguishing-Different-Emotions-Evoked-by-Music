clear;clc;

mydir=uigetdir('E:\aa0011\音乐+脑电\database\data','选择一个目录');
if mydir(end)~='\'
 mydir=[mydir,'\'];
end
DIRS=dir([mydir,'*.txt']);  %扩展名
n=length(DIRS);
for i=1:n
    if ~DIRS(i).isdir
    filename=DIRS(i).name;
str=filename;
str(end-3:end)=[];
% raw_data=importdata([str,'.txt']);
raw_data=importdata(filename);
data=raw_data.data(2:end,2:2:end);
num=str2double(raw_data.textdata(3:end,:));
cut_num=max(num)-900; 
[zero,index]=min(abs(num-cut_num));
true_data=data(index+1:end,:);
[row,line]=size(true_data);
intervel=row/20;
for i=1:20
    front=(i-1)*intervel+1;
    behind=i*intervel;
    data_single{:,i}=true_data(front:behind,:);
    mean_single(i,:)=mean(data_single{:,i});
    var_single(i,:)=var(data_single{:,i});
end
meanvar={mean_single var_single};
strmean=[str,'_meanvar'];
eval(['save ' strmean  ' meanvar']);

eval(['save ' str ' data_single']);%字符串转命令行
    end
    display=[str ' process completely'];
    disp(display); 
end
% [H,P,CI]=ttest2(mean_single{:,1},mean_single{:,2})
