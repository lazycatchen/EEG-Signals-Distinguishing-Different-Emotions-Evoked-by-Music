% clc;
% clear;
% close all;
% load('E:\aa0011\音乐+脑电\database\data\张树德01\zsd_anxious_01.mat');%装载信号
% s=data_single{1, 15}(5121:7680,10)*10;%偶数项为脑电信号
%  w=filter50(s,256)';%滤波50HZ
% % load singal
% % s=sig;
% fs=256; %采样频率
function [feature]=wave_brain(s,fs)
s=filter50(s,256)';%滤波50HZ
N=length(s);
nfft = 2^nextpow2(N);
order=512;%滤波器阶数
figure(1);
subplot(311);plot(s,'r');title('原始信号');
l=wmaxlev(s,'db4');       %求分解的最大尺度
%除噪，用极大极小原理进行阈值选择，在不同层估计噪声并调整阈值
sd=wden(s,'minimaxi','s','mln',real(l),'db4');
% sd=s;
subplot(312);plot(sd,'r');title('滤除噪声信号');%Xlabel('图2 原始信号与除噪信号对比');
ff=fft(sd,nfft)/N;%快速傅里叶变换
f=fs/2*linspace(0,1,nfft/2+1);

subplot(313);plot(f,2*abs(ff(1:nfft/2+1)),'r');xlabel('频率Hz');title('信号频谱');axis([0 60 0,20]);
[C,L]=wavedec(sd,5,'db4'); %用小波db4对信号进行多尺度分解(0~128Hz)
 
%提取一维小波变换高频系数
D5=detcoef(C,L,5);
D4=detcoef(C,L,4);
D3=detcoef(C,L,3);
D2=detcoef(C,L,2);
D1=detcoef(C,L,1);
% figure(2);
% subplot(515);plot(D5);ylabel('D5');
% subplot(514);plot(D4);ylabel('D4'); 
% subplot(513);plot(D3);ylabel('D3');
% subplot(512);plot(D2);ylabel('D2');
% subplot(511);plot(D1);ylabel('D1');title('细节系数');
 
%提取一维小波变换低频系数
A5=appcoef(C,L,'db4',5);
A4=appcoef(C,L,'db4',4);
A3=appcoef(C,L,'db4',3);
A2=appcoef(C,L,'db4',2);
A1=appcoef(C,L,'db4',1);
% figure(3);
% subplot(515);plot(A5);ylabel('A5');
% subplot(514);plot(A4);ylabel('A4'); 
% subplot(513);plot(A3);ylabel('A3');
% subplot(512);plot(A2);ylabel('A2');
% subplot(511);plot(A1);ylabel('A1');title('近似系数');
 
%用分解系数重构
SRA5=wrcoef('a',C,L,'db4',5);
SRA4=wrcoef('a',C,L,'db4',4);
SRA3=wrcoef('a',C,L,'db4',3);
SRA2=wrcoef('a',C,L,'db4',2);
SRA1=wrcoef('a',C,L,'db4',1); 
SRD5=wrcoef('d',C,L,'db4',5); 
SRD4=wrcoef('d',C,L,'db4',4); 
SRD3=wrcoef('d',C,L,'db4',3);             
SRD2=wrcoef('d',C,L,'db4',2);             
SRD1=wrcoef('d',C,L,'db4',1); 

figure(2);
dalt=[SRA5];    %δ-wave(1~4Hz) 
thalt=[SRD5];   %θ-wave(4~8Hz)
alpha=[SRD4];   %α-wave(8~13Hz)
belta=[SRD3];   %β-wave(14~30Hz)
subplot(411);plot(dalt,'r');ylabel('dalt');axis([0 1000 -30 30]);%title('各频段信号');
subplot(311);plot(thalt,'r');ylabel('thalt');axis([0 1000 -30 30]);
subplot(312);plot(alpha,'r');ylabel('alpha');axis([0 1000 -30 30]);
subplot(313);plot(belta,'r');ylabel('belta');axis([0 1000 -30 30]);%Xlabel('图3 各频段时域信号');
%% 波形特征
[alp_wavepeak,wavpestation1]=max(alpha);
alp_mean=mean(alpha);
alp_std=std(alpha)^2;

[tha_wavepeak,wavpestation2]=max(thalt);%峰值
tha_mean=mean(thalt);%均值
tha_std=std(thalt)^2;%方差

[dal_wavepeak,wavpestation3]=max(dalt);
dal_mean=mean(dalt);
dal_std=std(dalt)^2;

[bel_wavepeak,wavpestation4]=max(belta);
bel_mean=mean(belta);
bel_std=std(belta)^2;
%% 频谱
figure(3);
%dalt频段频谱
ff1=fft(dalt,nfft)/N;
ff_1=2*abs(ff1(1:nfft/2+1));
% subplot(411);plot(f,ff_1);ylabel('δ-1~4Hz');axis([0 50 0,15]);
% thalt频段频谱
ff2=fft(thalt,nfft)/N;
ff_2=2*abs(ff2(1:nfft/2+1));
subplot(311);plot(f,ff_2,'r');ylabel('θ-4~8Hz');axis([0 50 0,5]);
%alpha频段频谱
ff3=fft(alpha,nfft)/N;
ff_3=2*abs(ff3(1:nfft/2+1));
subplot(312);plot(f,ff_3,'r');ylabel('α-8~13Hz');axis([0 50 0,5]);
%belta频段频谱
ff4=fft(belta,nfft)/N;
ff_4=2*abs(ff4(1:nfft/2+1));
subplot(313);plot(f,ff_4,'r');xlabel('频率Hz');ylabel('β-14~30Hz');axis([0 60 0,0.5]);%Xlabel('图4 各频段信号频谱');
%% 频谱特征
[alp_frepeak1,frepestation1]=max(ff_1(18:end,:));%alpha波最大功率,18为去掉0HZ-1HZ频率，下面计算实则不必，不过亦无不可
alp_frepeak=frepestation1+17;
alp_cenfre=f(1,alp_frepeak);%alpha波中心频率
alp_sum=sum(ff_1(18:end,:));%alpha功率和
[tha_frepeak1,frepestation2]=max(ff_2(18:end,:));%thalt波最大功率
tha_frepeak=frepestation2+17;
tha_cenfre=f(1,tha_frepeak);%thalt波中心频率
tha_sum=sum(ff_2(18:end,:));%thalt功率和
[dal_frepeak1,frepestation3]=max(ff_3(18:end,:));%dalt波最大功率
dal_frepeak=frepestation3+17;
dal_cenfre=f(1,dal_frepeak);%dalt波中心频率
dal_sum=sum(ff_3(18:end,:));%thalt功率和
[bel_frepeak1,frepestation4]=max(ff_4(18:end,:));%belt波最大功率
bel_frepeak=frepestation4+17;
bel_cenfre=f(1,bel_frepeak);%belt波中心频率
bel_sum=sum(ff_4(18:end,:));%thalt功率和
feature=[alp_wavepeak alp_mean alp_std alp_cenfre alp_frepeak1 alp_sum tha_wavepeak tha_mean tha_std tha_cenfre tha_frepeak1 tha_sum ...
  dal_wavepeak dal_mean dal_std dal_cenfre dal_frepeak1 dal_sum ];

