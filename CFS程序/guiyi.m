clc;
clear all;
close all;
A=xlsread('E:\aa0011\MV实验结果\CFS程序\1.xls');%读取数据%
for i=1:size(A,2);
    temp=A(:,i);
    temp=(temp-min(temp))/(max(temp)-min(temp));%归一化%
    A(:,i)=temp;
    B=corr(A,'type','Spearman');%求数据的相关性%
    C=abs(B);
end
A=B;