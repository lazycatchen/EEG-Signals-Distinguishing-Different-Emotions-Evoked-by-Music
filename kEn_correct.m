function [a,k]=kEn_correct(s,mm)

% load('E:\aa0011\音乐+脑电\database\data\张树德01\zsd_anxious_01.mat');%装载信号
% s=data_single{1, 10}(5121:7680,14)*10;%偶数项为脑电信号
X=s';
%--------------------------------------------------------------------------
% G-P算法计算关联维

rr = 0.5;
Log2R = -6:rr:0;        % log2(r)
R = 2.^(Log2R);

fs = 256;               % 信号采样频率
t = 12;                 % 时延
% dd = 4;                 % 嵌入维间隔
% D = 4:dd:36;            % 嵌入维    
dd = 2;                 % 嵌入维间隔
% D = 2:dd:80; 
D = 2:dd:mm;
p = 50;                 % 限制短暂分离，大于序列平均周期(不考虑该因素时 p = 1)  

% tic 
Log2Cr = log2(CorrelationIntegral(X,t,D,R,p));   % 输出每一行对应一个嵌入维
% toc

%--------------------------------------------------------------------------
% 结果作图

% figure
% plot(Log2R,Log2Cr','k.-'); axis tight; hold on; grid on;
% xlabel('log2(r)'); 
% ylabel('log2(C(r))');
% title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% 最小二乘拟合

Linear = [8:12];                            % 线性似合区域
[a,B] = LM2(Log2R,Log2Cr,Linear);           % 最小二乘求斜率和截距

disp(sprintf('Correlation Dimension = %.4f',a));

% for i = 1:length(D)
%     Y = polyval([a,B(i)],Log2R(Linear),1);
%     plot(Log2R(Linear),Y,'r');
% end
% hold off;

%--------------------------------------------------------------------------
% 求梯度

Slope = diff(Log2Cr,1,2)/rr;                % 求梯度
xSlope = Log2R(1:end-1);                    % 梯度所对应的log2(r)

% figure;
% plot(xSlope,Slope','k.-'); axis tight; grid on;
% xlabel('log2(r)'); 
% ylabel('Slope');
% title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% 差分求K熵

KE = -diff(B)/(dd*t)*fs*log(2);             % 用采样频率 fs 和公式 log(x) = log2(x)*log(2) 将单位转化成 nats/s
D_KE = D(1:end-1);                          % K熵所对应的嵌入维

% figure;
% plot(D_KE,KE,'k.-'); grid on; hold on;
% xlabel('m'); 
% ylabel('Kolmogorov Entropy (nats/s)');
% title(['Lorenz, length = ',num2str(k2)]);

%--------------------------------------------------------------------------
% 输出显示
k=min(KE);

disp(sprintf('Kolmogorov Entropy = %.4f',min(KE)));
end



