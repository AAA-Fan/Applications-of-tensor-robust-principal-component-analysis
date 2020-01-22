function [M,L_0,S_0]=generator_T(n,r,p)
len=n*r*n;
P=normrnd(0,1/n,[1,len]);
P=reshape(P,[n,r,n]);
Q=normrnd(0,1/n,[1,len]);
Q=reshape(Q,[r,n,n]);
L_0=t_product_1(P,Q);
a=rand([n,n,n]);
a=a<p;
a=double(a);
q=0.5;
b=rand([n,n,n]);
b=b<q;
b=double(b);
for i=1:n
    for j=1:n
        for l=1:n
            if b(i,j,l)==0
                 b(i,j,l)=-1;
            end
        end
    end
end
S_0=a.*b;
M=L_0+S_0;
end

function L=t_product_1(A,B)
    n_A=size(A);
    A_freq=fft(A,[],3);
    B_freq=fft(B,[],3);
    for k=1:n_A(3)
      L_freq(:,:,k)=A_freq(:,:,k)*B_freq(:,:,k);
    end
    L=ifft(L_freq,[],3);
end