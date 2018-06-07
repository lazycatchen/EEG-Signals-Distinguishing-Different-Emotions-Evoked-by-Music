# EEG-Signals-Distinguishing-Different-Emotions-Evoked-by-Music
音频刺激的受众脑电特征（线性，非线性）提取，分类，选择最优特征等
脑电信号提取分类程序说明：

Class_music文件夹：对1000 songs of database数据库参考二维情感模型进行分类。其中Info.xls为1000 songs of database二维（效价维，激活维）信息。Plotscat.m文件为划分程序，其原始图形如图1，文件可得到a1，a2，a3，a4四变量即对应喜怒哀静四种感情。shift_axis_to_origin,m文件为坐标轴重置程序。
 test_Data文件夹：四个测试数据，每个数据包括20个cell（代表20首歌），每个cell包含24维脑电数据（偶数电极维脑电数据，奇数为参考电极）。
CFS程序文件夹：相关系数法的特征选择程序（复杂度较高）。
GACFS文件夹：CFS公式作为GA适应度函数，改进GA。ga_speech_opt.m为主程序，文件夹所给出的.mat数据皆为138维的音乐特征数据，进行的是音乐特征的降维，若需要降维其他特征则用其他数据代替ga_speech_opt.m中的data即可。Fitness.m文件为适应度函数子程序。
datacut.m：脑电设备信号txt转mat数据且分割存储。
datamap.m：归一化程序。
main_feature.m：为特征提取主要程序,其中调用filter50.m子程序为50HZ工频滤噪；调用ApEn.m c0complex.m kEn_correct.m lyapunov_wolf.m LZC.m spectral_entropy.m SVDen.m SampEn.m子程序为非线性特征（近似熵，C0复杂度，K熵等）提取；wave_brain为小波分析频段特征提取。其中采样频率皆为256HZ。
Bptest.m:为BP分类器分类主程序，其主要代码为选择、导入、筛选脑电数据。调用BP_child.m为BP分类器主代码（PS参考神经网络的43个神经网络一书）。
C45_test.m：为C4.5分类器分类主程序，其主要代码为选择、导入、筛选脑电数据。调用C4_5.m为c4.5分类器主代码。
SVMtest.m：为SVM分类器分类主程序，需要调用林智仁的libsvm包，参数优化gaSVMcgForClass.m参考神经网络的43个神经网络一书。
machine_three_box.m:画上述三种分类器结果的箱线图，其中用到piermorel-gramm-005ffc4.rar工具箱（作用为仿R语言画图，作图好看，当然部分人不这么认为）。
histogram_feature.m：画特征频数分布直方图。
音乐t检验结果.doc:检验音乐效价激活维相关性，用SPSS检验。




