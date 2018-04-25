function Merits=cfs(A,k,f)%A表示相关性矩阵，k表示选择的特征个数，f表示总特征数%
a=nchoosek(f,k);
n=length(a);
m=length(A);
C=zeros(n,1);
M=zeros(n,1);
D=A;
for i=1:n
    c=a(i,:);
    d=nchoosek(c,2);
    x=d(:,1);
    y=d(:,2);
    index=sub2ind(size(D),x,y);
    B=A(index);
    C(i)=mean(B);
    E=A([1:m-1],end);
    N=nchoosek(E,k);
    M(i)=mean(mean(N,2));
end
Merits=(k.*M)./sqrt(k+k*(k-1).*C);

    

