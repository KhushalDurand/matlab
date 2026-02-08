% LUDecomposition_with_PP

% x = 1, y = 3, z = 2

A = [2 3 -2; 1 1 1; 3 -1 2];
B = [7;6;4];

[N,~] = size(A);
X = zeros(N,1);
Y = zeros(N,1);
R = 1:N;

% partial pivoting

for p = 1:N-1
    [~,j] = max(abs(A(p:N,p)));

    % swap
    if j~=p
        A([p j+p-1],:)=A([j+p-1 p],:);
        R([p j+p-1])=R([j+p-1 p]);
    end

    if A(p,p)==0
        "A IS SINGULAR, NO UNIQUE SOLUTION"
        break
    end

    % in place LUDecomposition

    for k = p+1:N
        m = A(k,p)/A(p,p);
        A(k,p)= m;
        A(k,p+1:N)=A(k,p+1:N)-m*A(p,p+1:N);
    end
end
 % solve for Y ( FS )
 Y(1)= B(R(1));
 for k = 2:N
      Y(k)= B(R(k))-A(k,1:k-1)*Y(1:k-1);
 end

 % solve for X ( BS ) 

 X(N)= Y(N)/A(N,N);
 for k = n-1:-1:1
     X(k)= (Y(k)-A(k,k+1:N)*X(k+1:N))/A(k,k);
 end
 X





