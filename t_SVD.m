function [U_time,S_time,V_time]=t_SVD(A_time,u)
A_freq=fft(A_time,[],3);
n=size(A_time);
U_freq=zeros(n(1),n(1),n(3));
S_freq=zeros(n(1),n(2),n(3));
V_freq=zeros(n(2),n(2),n(3));
for i=1:n(3)
    [U_freq(:,:,i),S_freq(:,:,i),V_freq(:,:,i)]=svd(A_freq(:,:,i));
     S_freq(:,:,i)=shrinkage(S_freq(:,:,i),1/u);
end
U_time=ifft(U_freq,[],3);
S_time=ifft(S_freq,[],3);
V_time=ifft(V_freq,[],3);
end