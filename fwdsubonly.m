function  Y = fwdsubonly(A,R,B)
%Solve for Y
N = length(B);
Y = zeros(N,1);
Y(1) = B(R(1));
for k=2:N
   Y(k)= B(R(k))-A(k,1:k-1)*Y(1:k-1);
end