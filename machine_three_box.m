clc;
clear;
rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\周迪豪01\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\周迪豪01\AA_finial_ave.mat');
value2=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\唐陈飞01\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\唐陈飞01\AA_finial_ave.mat');
value3=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\张树德01\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\张树德01\AA_finial_ave.mat');
value4=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\扈婉婷01\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\扈婉婷01\AA_finial_ave.mat');
value5=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\李晗01\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\李晗01\AA_finial_ave.mat');
value6=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\李永平01\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\李永平01\AA_finial_ave.mat');
value7=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\薛明镇01\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\薛明镇01\AA_finial_ave.mat');
value8=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\刘俊杭02\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\刘俊杭02\AA_finial_ave.mat');
value9=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\周迪豪02\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\周迪豪02\AA_finial_ave.mat');
value10=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\唐陈飞02\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\唐陈飞02\AA_finial_ave.mat');
value11=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\张树德02\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\张树德02\AA_finial_ave.mat');
value12=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\扈婉婷02\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\扈婉婷02\AA_finial_ave.mat');
value13=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\李晗02\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\李晗02\AA_finial_ave.mat');
value14=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\李永平02\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\李永平02\AA_finial_ave.mat');
value15=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征

rate1=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\薛明镇02\svm_recog_three1.mat');
maxx=importdata('E:\aa0011\音乐+脑电\database\data\addwavle\薛明镇02\AA_finial_ave.mat');
value16=[rate1(10:12,1:3) maxx(10:12,25)];%选择的最大识别率，对应特征数；全选特征
value=[value2 value3 value4 value5 value6 value7 value8 value9 ...
       value10 value11 value12 value13 value14 value15 value16]';
 reco_box=value(:)';
% save BP_reco_three reco_box

