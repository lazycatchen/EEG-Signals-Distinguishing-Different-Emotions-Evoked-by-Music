function e=filter50(x,y)
 N=length(x);%信号长度
 fs=y;%采样频率
% x1=randn(1,N);%模拟脑电信号
% x2=sin(2*pi*50*[0:N-1]/fs);%50hz工频
% x=x1+x2;
x1=x;
d=x1;%期望信号

randphase=pi*rand;
C=0.4484;
rx1=C*sin(2*pi*50*[0:N-1]/fs+randphase);%参考信号1
rx2=C*cos(2*pi*50*[0:N-1]/fs+randphase);%参考信号2




m=5;%滤波器阶数
w1=zeros(m,1);%权1
w2=zeros(m,1);%权2
y=zeros(1,N);%自适应滤波器输出
e=zeros(1,N);%噪声抵消输出，即滤波输出
u=1/32;

for k=m:N
    x1k=rx1(k-m+1:k);
    x2k=rx2(k-m+1:k); 
   y(k)=x1k*w1+x2k*w2;%+x1k*w2;%系统输出信号
    % y(k)=x1k*w1;
    e(k)=d(k)-y(k);%误差
    w1=w1+2*u*e(k)*x1k.'; 
    w2=w2+2*u*e(k)*x2k.'; 
end


% figure;
% % subplot(3,2,1)
% % plot(x1)
% % title('无噪声信号')
% % subplot(3,2,2)
% % px1=abs(fft(x1));
% % plot(fs/N:fs/N:fs/2,px1(1:N/2))
% % title('无噪声信号频谱')
% subplot(2,2,1)
% plot(x)
% title('原始信号')
% subplot(2,2,2)
% px=abs(fft(x));
% plot(fs/N:fs/N:fs/2,px(1:N/2))
% title('原始信号频谱')
% subplot(2,2,3)
% plot(e)
% title('去工频后信号')
% subplot(2,2,4)
% pe=abs(fft(e));
% plot(fs/N:fs/N:fs/2,pe(1:N/2))
% title('去工频后信号频谱')

% a=[1,-2*(1-u*C*C)*cos(2*pi*50/fs),1-2*u*C*C];
% b=[1,-2*cos(2*pi*50/fs),1];
% figure;    
% [h,ww]=freqz(b,a);
% plot((ww/pi)*(fs/2),20*log10(h));
% title('滤波器幅度特性')
% xlabel('频率(Hz)')
% ylabel('幅度特性（db）')

