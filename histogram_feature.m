clear;
clc;
close all;
clear g
% load example_data;
raw=importdata('class_featuredata.mat');
data=raw(:,323);
emo1{1,1}='angry';emo2{1,1}='calm';emo3{1,1}='joy';emo4{1,1}='sad';
a1=repmat(emo1,300,1);a2=repmat(emo2,300,1);a3=repmat(emo3,300,1);a4=repmat(emo4,300,1);
num=[a1;a2;a3;a4];
num1=[ones(1,300)';ones(1,300)'*2;ones(1,300)'*3 ;ones(1,300)'*4];
% num2=[ones(1,200)';ones(1,300)'*2;ones(1,300)'*3 ;ones(1,300)'*4;ones(1,100)'*5];
g(1,1)=gramm('x',data,'y',num1,'color',num);


g(1,1).stat_bin('nbins',8,'width',0.6,'fill','edge');

% g.set_names('x','Pz电极K熵','y','xxx');
% g.set_names('x','Pz电极近似熵','y','xxx');
% g.set_names('x','Pz电极最大李雅普诺夫指数','y','xxx')
% g.set_names('x','Pz电极C0复杂度','y','xxx')
% g.set_names('x','Pz电极谱熵','y','xxx')
g.set_names('x','Pz电极lz复杂度','y','xxx')
% g.set_title('Visualization of Y~X relationships with X as categorical variable');

figure('Position',[400 400 800 550]);
g.draw();
set(gca,'FontSize',12)
set(get(gca,'YLabel'),'Fontsize',20) 
set(get(gca,'XLabel'),'Fontsize',20) 