clc;
clear;
close all;
x=load('x.mat')
load('detect.mat');
% x=xlsread('C:\Users\Administrator\Desktop\info.xls')
x=x.x;
scatter(getcolumn(x(:,[2,4])-4,1),getcolumn(x(:,[2,4])-4,2),'k');

hold on; 

[i,j]=find(x(:,2)<3.2&x(:,2)>0&x(:,3)<2.7&x(:,4)<3.2&x(:,4)>0&x(:,5)<2.7);
z=x(i,:);
a1=scatter(getcolumn(z(:,[2,4])-4,1),getcolumn(z(:,[2,4])-4,2),'g');

% new_fig_handle = shift_axis_to_origin( gca ) ;
hold on;%sad

[i,j]=find(x(:,2)<3.2&x(:,2)>0&x(:,3)<2.7&x(:,4)<8&x(:,4)>4.4&x(:,5)<2.7);
z=x(i,:);
a2=scatter(getcolumn(z(:,[2,4])-4,1),getcolumn(z(:,[2,4])-4,2),'b');

hold on;%peaceful

[i,j]=find(x(:,2)<8&x(:,2)>6&x(:,3)<1.3&x(:,4)<8&x(:,4)>6&x(:,5)<1.3);
z=x(i,:);
a3=scatter(getcolumn(z(:,[2,4])-4,1),getcolumn(z(:,[2,4])-4,2),'r');
hold on;%joy

[i,j]=find(x(:,2)<8&x(:,2)>5&x(:,3)<3.2&x(:,4)<3.7&x(:,4)>0&x(:,5)<3.2);
z=x(i,:);
a4=scatter(getcolumn(z(:,[2,4])-4,1),getcolumn(z(:,[2,4])-4,2),'y');
hold on;%angry


new_fig_handle = shift_axis_to_origin( gca ) ;

ylabel('Arousal','FontSize',14,'color','g')
xlabel('Valence','FontSize',14,'color','g')
legend([a1,a2,a3,a4],'Sad','Angry','Joy','Calm');
hold on
