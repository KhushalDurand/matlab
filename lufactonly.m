function [A,R] = lufactonly(A)

[~,N]=size(A);
R=1:N;

% partial pivoting

for p = 1:N-1
    [~,j] = max(abs(A(p:N,p)));

    % swap
    if j~=p
        A([p j+p-1],:)=A([j+p-1 p],:);
        R([p j+p-1])=R([j+p-1 p]);
    end

    if A(p,p)==0
        error("A IS SINGULAR, NO UNIQUE SOLUTION");
    end

    % in place LUDecomposition

    for k = p+1:N
        m = A(k,p)/A(p,p);
        A(k,p)= m;
        A(k,p+1:N)=A(k,p+1:N)-m*A(p,p+1:N);
    end
end