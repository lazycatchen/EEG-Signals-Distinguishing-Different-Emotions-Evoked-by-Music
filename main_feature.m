clc;
clear;
close all;

mydir=uigetdir('E:\aa0011\音乐+脑电\database\data','选择一个目录');
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
    
    songs_feature=cell(1,20);%预先分配内存
    SSE_feature=zeros(20,12);
    wave_feature=zeros(20,216);
    D_frature=zeros(20,12);
    k_frature=zeros(20,12);
    APEn_frature =zeros(20,12);
    SampEn_frature =zeros(20,12);
    Ly_frature =zeros(20,12);
    Coc_frature =zeros(20,12);
    Sps_feature=zeros(20,12);
    lzc_feature=zeros(20,12);
    
    load(str);
    num=length(data_single);
    
    for i=12:num
       data_raw=data_single{1, i}(:,[1,2,3,4,5,6,11,12,13,14,19,21]);%取需要的列数比如C3，C4电极
       [dataraw,datarank]=size(data_raw);
       for ii=1:datarank
           try
         data=data_raw(:,ii);
         data1=filter50(data,256)';%滤波50HZ
         datax=data1(5121:7680,:)*10;%滤波，去除眼电
         
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'电极的奇异谱熵']);
         SSE=SVDen(datax, 256);%奇异谱熵，窗口256采样点，m=20
         SSE_feature(i,ii)=SSE;
       
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'电极的lz复杂度']);
         lzc=LZC(datax);%lz复杂度
         lzc_feature(i,ii)=lzc;
       
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'电极的谱熵']);
         Sps=spectral_entropy(datax,256);%谱熵
         Sps_feature(i,ii)=Sps;
       
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'电极的C0复杂度']);
         [C0,C0_average]=c0complex(datax,256,0);%C0复杂度
         Coc_frature(i,ii)=C0_average;
       
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'电极的最大李雅普诺夫指数']);
         lyanpunov=lyapunov_wolf(datax,2560,5,1,5);%最大李雅普诺夫指数，长度2560，嵌入维数6，时延1s，周期5
         Ly_frature(i,ii)=lyanpunov;
       
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'电极的样本熵']);
         SampEntropy=SampEn(datax);%样本熵
         SampEn_frature(i,ii)=SampEntropy;
       
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'电极的近似熵']);
         ApEntropy=ApEn(datax);%近似熵
         APEn_frature(i,ii)=ApEntropy;
       
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'电极的k熵和关联维']);   
         [D,k]=kEn_correct(datax,10);
         k_frature(i,ii)=k;%k熵
         D_frature(i,ii)=D;%关联维
        
         disp(['正在计算第',num2str(i),'首歌曲第',num2str(ii),'小波各频段时频域特征']);  
         feature=wave_brain(datax*100,256);%alpha,thalt,dalt波的峰值，均值，方差，中心频率，最大功率，功率和
         wave_feature(i,(18*ii-17):ii*18)=feature;%列数为特征，行数为歌曲数
           
             catch
               continue
           end
           end
       sinsong_feature=[wave_feature D_frature k_frature APEn_frature SampEn_frature Ly_frature Coc_frature Sps_feature ...
           lzc_feature SSE_feature];
       songs_feature{1,i}=sinsong_feature;
       clear sinsong_feature datax;
    end 
    
    str(end-3:end)=[];
    str2=[str '_feature'];
    eval(['save ' str2 ' songs_feature']);%字符串转命令行
    clear songs_feature;
end