A = [2 3 -2; 1 1 1; 3 -1 2];
% B = [7;6;4];
inb_inv = inv(A);
[~,N]=size(A);
Ainv=zeros(N,N);
I = eye(N);         % Create an identity matrix of size N
[A,R] = lufactonly(A);
for i = 1:N
      B = I(:,i);
      Y = fwdsubonly(A,R,B);
      X = backsubonly(A,Y);
      Ainv(:,i)= X;
end
inb_inv
Ainv
isequal(round(Ainv),round(inb_inv))



