function [SSE] = SVDen(ts, L)

%
%  Performs decomposition stage of the Caterpillar-SSA algorithm,
%  i.e. construction of trajectory matrix from a time series 
%  and its Singular Value Decomposition
%
%  Parameters:
%    ts -- a time series (a column)
%    L -- window length (1<L<t.s.length)
%
%  Returns:
%    sing_values -- array of M singular values (square roots of eigen values),
%                   M=min(rank(ts),L)
%    U -- a matrix of M eigenvectors of length L (R^LxM), M=min(rank(ts),L)
%    V -- a matrix of M factorvectors of length K (R^KxM), M=min(rank(ts),L)
%
%
%  If you modify this source code somehow, please send me the modified version.
%
%
%  (c) Theodore Alexandrov (autossa@gmail.com)
%  Last modified: 8 May 2006 
%


N=length(ts);
K=N-L+1;  % K must be >=1!
if K<1
    errordlg('Wrong L. SSA is cancelled.', 'Error');
    return
end

%form trajectory matrix
X=zeros(L,K);
for i=1:L
    X(i,:)=ts(i:i-1+K)';
end

% prepare to finite rank time series
% M=min( rank(X), L );
M=20;

%SVD
[U,S,V] = svd(X); % U_i is a column in U, {V_i} are the first L columns of V


%extract sing.values and cut them to the rank if rank<L, 
%it's necessary for finite rank time series
sing_values=diag(S);
if M<L %if rank(ts)<L
    sing_values=sing_values(1:M);
end

%cut eigen vectors to the rank if rank<L
if M<L %if rank(ts)<L
    U=U(:,1:M);
end

%extract factor vectors
V=V(:,1:M);
sum_S=sum(sing_values);
pi=sing_values./sum_S;
SSE=-sum(pi.*log(pi));

