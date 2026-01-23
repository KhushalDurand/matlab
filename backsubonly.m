function X = backsubonly(A,Y)

%Solve for X
N = length(Y);
X=zeros(N,1);
X(N)=Y(N)/A(N,N);
for k=N-1:-1:1
   X(k)=(Y(k)-A(k,k+1:N)*X(k+1:N))/A(k,k);
end