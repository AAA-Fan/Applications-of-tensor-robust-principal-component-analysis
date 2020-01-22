function   [L,E,Y,iteration]=T_RPCA(X,r) %videoandimage [L,E,Y,iteration]=T_RPCA(X,L_0,r)%NUMERICAL
n=size(X);
L=zeros(n);
E=zeros(n);
Y=zeros(n);
iteration=0;
p=1.1;
u=0.001;
u_max=1^10;
e=10^-8; %image
%X_F=sqrt(sum(sum(X.^2))); %video
%terminate=10^-5*X_F;   %video
%terminate=10^-5; %NUMERICAL
while 1 
    [A,B,C]=t_SVD(X-E-(u^-1)*Y,u);
    [n1,n2,n3] = size(C);
    Ct = zeros(n2,n1,n3);
    Ct(:,:,1) = C(:,:,1)';
    if n3 > 1
     for i = 2 : n3
            Ct(:,:,i) = C(:,:,n3-i+2)';
     end
    end
    L=t_product(A,B,Ct); 
     E=shrinkage(X-L-(u^-1)*Y,r/u);
     Y=Y+u*(L+E-X);
     u=min(p*u,u_max);
     figure(1);imshow(L);
     figure(2),imshow(E);
     iteration=iteration+1
     %i=sqrt(sum(sum(sum((L-L_0).^2))))/sqrt(sum(sum(sum((L_0).^2))));%NUMERICAL
     %i=sqrt(sum(sum((X-L-E).^2)));   %video
     error=max(max(max(abs(L+E-X)))); %image
     if error<=e   %image
         break
     end
end
%iter=1:1:iteration;
%plot(iter,error)  %image
end

function S_t=shrinkage(N,t)
S_t = sign(N) .* max(abs(N) - t, 0);
end

function L=t_product(A,B,C)
    n_A=size(A);
    A_freq=fft(A,[],3);
    C_freq=fft(C,[],3);
    B_freq=fft(B,[],3);
    for j=1:n_A(3)
      L_freq(:,:,j)=A_freq(:,:,j)*B_freq(:,:,j)*C_freq(:,:,j);
    end
    L=ifft(L_freq,[],3);
end
