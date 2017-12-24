function BP_recogn=BP_child(datax,Merits)
% data1=datax(:,27*1-26:27*1);

chenr=zeros(12,27);
% BP_recogn=zeros(12,27);


for elect=10:12
data1=datax(:,27*elect-26:27*elect);

add1=ones(size(data1,1)/4,1);
add=[add1;add1*2;add1*3;add1*4];
data=[add data1];
%从1到2000间随机排序

%输入输出数据
str=['处理 ',num2str(elect),'电极'];
disp(str)

for cheni=1:3
%***********************
info_index=Merits{1,cheni};
input=data1(:,info_index);
% input=data(:,2:aaa);
output1 =data(:,1);
%*************************
k=rand(1,size(data1,1));
[m,n]=sort(k);
aaa= size(input,2)+1;

%把输出从1维变成4维

for i=1:size(data1,1)
    switch output1(i)
        case 1
            output(i,:)=[1 0 0 0];
        case 2
            output(i,:)=[0 1 0 0];
        case 3
            output(i,:)=[0 0 1 0];
        case 4
            output(i,:)=[0 0 0 1];

    end
end


%随机提取1500个样本为训练样本，500个样本为预测样本
input_train=input(n(1:72),:)';
output_train=output(n(1:72),:)';
input_test=input(n(73:80),:)';
output_test=output(n(73:80),:)';
%输入数据归一化
[inputn,inputps]=mapminmax(input_train);


%% 网络结构初始化
innum=aaa-1;
midnum=(aaa-1);
outnum=4;
 

%权值初始化
w1=rands(midnum,innum);
b1=rands(midnum,1);
w2=rands(midnum,outnum);
b2=rands(outnum,1);

w2_1=w2;w2_2=w2_1;
w1_1=w1;w1_2=w1_1;
b1_1=b1;b1_2=b1_1;
b2_1=b2;b2_2=b2_1;

%学习率
xite=0.1
alfa=0.01;

%% 网络训练


for ii=1:100
   
    E(ii)=0;
    for i=1:1:72
       %% 网络预测输出 
        x=inputn(:,i);
        % 隐含层输出
        for j=1:1:midnum
            I(j)=inputn(:,i)'*w1(j,:)'+b1(j);
            Iout(j)=1/(1+exp(-I(j)));
        end
        % 输出层输出
        yn=w2'*Iout'+b2;
        
       %% 权值阀值修正
        %计算误差
        e=output_train(:,i)-yn;     
        E(ii)=E(ii)+sum(abs(e));
        
        %计算权值变化率
        dw2=e*Iout;
        db2=e';
        
        for j=1:1:midnum
            S=1/(1+exp(-I(j)));
            FI(j)=S*(1-S);
        end      
        for k=1:1:innum
            for j=1:1:midnum
                dw1(k,j)=FI(j)*x(k)*(e(1)*w2(j,1)+e(2)*w2(j,2)+e(3)*w2(j,3)+e(4)*w2(j,4));
                db1(j)=FI(j)*(e(1)*w2(j,1)+e(2)*w2(j,2)+e(3)*w2(j,3)+e(4)*w2(j,4));
            end
        end
           
        w1=w1_1+xite*dw1'+alfa*(w1_1-w1_2);
        b1=b1_1+xite*db1'+alfa*(b1_1-b1_2);
        w2=w2_1+xite*dw2'+alfa*(w2_1-w2_2);
        b2=b2_1+xite*db2'+alfa*(b2_1-b2_2);
        
        w1_2=w1_1;w1_1=w1;
        w2_2=w2_1;w2_1=w2;
        b1_2=b1_1;b1_1=b1;
        b2_2=b2_1;b2_1=b2;
    end
end
 

%% 语音特征信号分类
inputn_test=mapminmax('apply',input_test,inputps);

for ii=1:10
    for i=1:8  %1500
        %隐含层输出
        for j=1:1:midnum
            I(j)=inputn_test(:,i)'*w1(j,:)'+b1(j);
            Iout(j)=1/(1+exp(-I(j)));
        end
        
        fore(:,i)=w2'*Iout'+b2;
    end
end

%% 结果分析
%根据网络输出找出数据属于哪类
for i=1:8
    output_fore(i)=find(fore(:,i)==max(fore(:,i)));
end

%BP网络预测误差
error=output_fore-output1(n(73:80))';
right=length(find(error==0));

chenr(elect,cheni)=right/8;
clear I Iout fore output_fore FI db1 dw1;
end
end
BP_recogn=chenr;


end