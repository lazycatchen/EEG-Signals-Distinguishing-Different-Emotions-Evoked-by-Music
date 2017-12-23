function lzc = LZC(data)
%% 计算一维信号的复杂度
% data时间序列 
% lzc:信号的复杂度
%% 
MeanData = mean(data); % 数据二值化处理,基于均值的二值化处理
b=(data> MeanData);
x(1:length(b))='0';  
x(b)='1';%二值化后得到01序列字符串。
%% 
c = 1; %模式初始值
S = x(1);
Q = [];
SQ = []; %S Q SQ初始化
for i=2:length(x)
   Q = strcat(Q,x(i));
   SQ = strcat(S,Q);
   SQv = SQ(1:length(SQ)-1);
   if isempty(strfind(SQv,Q)) %如果Q不是SQv中的子串，说明Q是新出现的模式，执行c 加1操作 
     S = SQ;
     Q = [];
     c = c+1; 
   end
end
c=c+1;    %循环得到的c是字符串断点的数目，所以要加1
b = length(x)/log2(length(x));
lzc = c/b;
%fprintf('\n\n序列data的LZ复杂度是\n\n');
%fprintf('%f', lzc);
end

