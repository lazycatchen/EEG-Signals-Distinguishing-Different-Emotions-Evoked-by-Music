clc;
clear;
close all;
% x=repmat(1:12,1,15);
% catx=repmat({'FP1' 'FP1' 'FP2' 'FP2' 'F3' 'F3' 'F4' 'F4' 'F7' 'F7' 'F8' 'F8'....
%              'Fz' 'Fz' 'C3' 'C3' 'C4' 'C4' 'T3' 'T3' 'T4' 'T4' 'Pz' 'Pz'},1,15  );
catx0=repmat({'T3' 'T3' 'T3' 'T3'},1,15  );
catx1=repmat({'T4' 'T4' 'T4' 'T4'},1,15  );%
catx2=repmat({'Pz' 'Pz' 'Pz' 'Pz'},1,15  );
catx=[catx0 catx1 catx2];
c=repmat({'线性特征' '非线性特征' '综合特征' '原27维特征'},1,45);
% y=2+y+x+c*0.5;
% y=randn(1,40);
% y=importdata('E:\aa0011\wavelet_eeg\result_reco.mat');
y=importdata('E:\aa0011\wavelet_eeg\process_CFSDATA\svm_reco_three1.mat');
y=y/100;
y1=importdata('E:\aa0011\wavelet_eeg\process_CFSDATA\svm_reco_three.mat');
y2=importdata('E:\aa0011\wavelet_eeg\process_CFSDATA\BP_reco_three.mat');

% y=importdata('E:\aa0011\wavelet_eeg\process_CFSDATA\c45_reco_three.mat');
clear g
g(1,1)=gramm('x',catx,'y',y,'color',c);
g(2,1)=gramm('x',catx,'y',y1,'color',c);
g(3,1)=gramm('x',catx,'y',y2,'color',c);

g(1,1).stat_boxplot('width',0.7,'dodge',0.6);
% g(1,1).geom_vline('xintercept',0.5:1:12.5,'style','w-');
g(2,1).stat_boxplot('width',0.7,'dodge',0.6);
% g(2,1).geom_vline('xintercept',0.5:1:12.5,'style','w-');
g(3,1).stat_boxplot('width',0.7,'dodge',0.6);
% g(3,1).geom_vline('xintercept',0.5:1:12.5,'style','w-');
% g(1,1).set_title('SVM验证CFS降维识别率');
% g(2,1).set_title('C4.5验证CFS降维识别率');
% g(3,1).set_title('BP验证CFS降维识别率');

% g.set_title('C4.5验证CFS降维识别率');

figure('Position',[200 200 700 700]);
% figure
g.draw();
