function lambda_1=lyapunov_wolf(data,N,m,tau,P)
%  该函数用来计算时间序列的最大Lyapunov 指数--Wolf 方法
%  m: 嵌入维数
%  tau:时间延迟
%  data:时间序列
%  N:时间序列长度
%  P:时间序列的平均周期,选择演化相点距当前点的位置差，即若当前相点为I，则演化相点只能在|I－J|>的相点中搜寻
%  lambda_1:返回最大lyapunov指数值
min_point=1  ; %&&要求最少搜索到的点数
MAX_CISHU=5 ;  %&&最大增加搜索范围次数
%FLYINGHAWK
%   求最大、最小和平均相点距离
    max_d = 0;                                         %最大相点距离
    min_d = 1.0e+100;                                  %最小相点距离
    avg_dd = 0;
    Y=reconstitution(data,N,m,tau);                    %相空间重构
    M=N-(m-1)*tau;                                     %重构相空间中相点的个数
    for i = 1 : (M-1)
        for j = i+1 : M
            d = 0;
            for k = 1 : m
                d = d + (Y(k,i)-Y(k,j))*(Y(k,i)-Y(k,j));
            end
            d = sqrt(d);
            if max_d < d
               max_d = d;
            end
            if min_d > d
               min_d = d;
            end
            avg_dd = avg_dd + d;
        end
    end
    avg_d = 2*avg_dd/(M*(M-1));                %平均相点距离
   
    dlt_eps = (avg_d - min_d) * 0.02 ;         %若在min_eps～max_eps中找不到演化相点时，对max_eps的放宽幅度
    min_eps = min_d + dlt_eps / 2 ;            %演化相点与当前相点距离的最小限
    max_eps = min_d + 2 * dlt_eps  ;           %&&演化相点与当前相点距离的最大限
   
%     从P+1～M-1个相点中找与第一个相点最近的相点位置(Loc_DK)及其最短距离DK
    DK = 1.0e+100;                             %第i个相点到其最近距离点的距离
    Loc_DK = 2;                                %第i个相点对应的最近距离点的下标
    for i = (P+1)M-1)                        %限制短暂分离，从点P+1开始搜索
        d = 0;
        for k = 1 : m
            d = d + (Y(k,i)-Y(k,1))*(Y(k,i)-Y(k,1));
        end
        d = sqrt(d);
        if (d < DK) & (d > min_eps)
           DK = d;
           Loc_DK = i;
        end
    end
%     以下计算各相点对应的李氏数保存到lmd()数组中
%     i 为相点序号，从1到(M-1)，也是i-1点的演化点；Loc_DK为相点i-1对应最短距离的相点位置，DK为其对应的最短距离
%     Loc_DK+1为Loc_DK的演化点，DK1为i点到Loc_DK+1点的距离，称为演化距离
%     前i个log2（DK1/DK）的累计和用于求i点的lambda值
    sum_lmd = 0 ;                              % 存放前i个log2（DK1/DK）的累计和
    for i = 2 : (M-1)                          % 计算演化距离      
        DK1 = 0;
        for k = 1 : m
            DK1 = DK1 + (Y(k,i)-Y(k,Loc_DK+1))*(Y(k,i)-Y(k,Loc_DK+1));
        end
        DK1 = sqrt(DK1);
        old_Loc_DK = Loc_DK ;                  % 保存原最近位置相点
        old_DK=DK;
%     计算前i个log2（DK1/DK）的累计和以及保存i点的李氏指数
        if (DK1 ~= 0)&( DK ~= 0)
           sum_lmd = sum_lmd + log(DK1/DK) /log(2);
        end
        lmd(i-1) = sum_lmd/(i-1);
%     以下寻找i点的最短距离：要求距离在指定距离范围内尽量短，与DK1的角度最小
        point_num = 0  ; % &&在指定距离范围内找到的候选相点的个数
        cos_sita = 0  ; %&&夹角余弦的比较初值 ――要求一定是锐角
        zjfwcs=0     ;%&&增加范围次数
         while (point_num == 0)
           % * 搜索相点
            for j = 1 : (M-1)
                if abs(j-i) <=(P-1)      %&&候选点距当前点太近，跳过！
                   continue;     
                end
               
                %*计算候选点与当前点的距离
                dnew = 0;
                for k = 1 : m
                   dnew = dnew + (Y(k,i)-Y(k,j))*(Y(k,i)-Y(k,j));
                end
                dnew = sqrt(dnew);
               
                if (dnew < min_eps)|( dnew > max_eps )   %&&不在距离范围，跳过！
                  continue;            
                end
                              
                %*计算夹角余弦及比较
                DOT = 0;
                for k = 1 : m
                    DOT = DOT+(Y(k,i)-Y(k,j))*(Y(k,i)-Y(k,old_Loc_DK+1));
                end
                CTH = DOT/(dnew*DK1);
               
                if acos(CTH) > (3.14151926/4)      %&&不是小于45度的角，跳过！
                  continue;
                end
               
                if CTH > cos_sita   %&&新夹角小于过去已找到的相点的夹角，保留
                    cos_sita = CTH;
                    Loc_DK = j;
                    DK = dnew;
                end
                point_num = point_num +1;
               
            end        
        
            if point_num <= min_point
               max_eps = max_eps + dlt_eps;
               zjfwcs =zjfwcs +1;
               if zjfwcs > MAX_CISHU    %&&超过最大放宽次数，改找最近的点
                   DK = 1.0e+100;
                   for ii = 1 : (M-1)
                      if abs(i-ii) <= (P-1)      %&&候选点距当前点太近，跳过！
                       continue;     
                      end
                      d = 0;
                      for k = 1 : m
                          d = d + (Y(k,i)-Y(k,ii))*(Y(k,i)-Y(k,ii));
                      end
                      d = sqrt(d);
        
                      if (d < DK) & (d > min_eps)
                         DK = d;
                         Loc_DK = ii;
                      end
                   end
                   break;
               end
               point_num = 0          ;     %&&扩大距离范围后重新搜索
               cos_sita = 0;
            end
        end
   end
%取平均得到最大李雅普诺夫指数
lambda_1=sum(lmd)/length(lmd);
