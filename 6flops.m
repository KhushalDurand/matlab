clc
clear
N=9;
P=6;
Total_LU = zeros(N, P);
Total_GE = zeros(N, P);

figure
hold on
grid on
for n = 1:N
    LU_FE = n*(n-1)*(4*n+1)/6 ;
    LU_FS = n^2 - n;
    LU_BS = n^2;
    GE_FE = n*(n-1)*(4*n+7)/6 ;
    GE_FS = 0;
    GE_BS = n^2;
    for p = 1:P
        Total_LU(n,p) = LU_FE + p * (LU_FS + LU_BS);
        Total_GE(n,p) = p * (GE_FE + GE_BS);
    end
    plot(1:P,Total_GE(n,:),"*-","DisplayName",['dimention ' num2str(n)])
    plot(1:P,Total_LU(n,:),"*-","DisplayName",['dimention ' num2str(n)])
end
legend
Total_LU
Total_GE


