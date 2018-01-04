clear;clc;
load('E:\aa0011\音乐+脑电\database\data\李永平02\lyp_joy_02.mat');
x=data_single{1, 8}(:,10);
fs=256; 
N=5000;  
NFFT = 2^nextpow2(N);
f= fs/2*linspace(0,1,NFFT/2); 
E_change=fft(x,NFFT)/N; 
figure
plot(f,2*abs(E_change(1:NFFT/2)));
title('脑电')
xlabel('频率')
ylabel('频谱')
window=boxcar(length(x)); 
nfft=1024;
[Pxx,f]=periodogram(x,window,nfft,fs); 
figure
plot(f,10*log10(Pxx));
title('脑电')
xlabel('频率')
ylabel('功率谱')
