function [L,S,Y,iteration,error]=RPCA(M)
n=size(M);
u=n(1)*n(2)/(4*sum(sum(abs(M))));
r=1/(sqrt(max(n)));
L=zeros(n);
S=zeros(n);
Y=zeros(n);
M_F=sqrt(sum(sum(M.^2))); %video
%terminate=10^-3;    %numerical
terminate=10^-5*M_F;   %video
%i=sqrt(sum(sum((M-L-S).^2)));
%e=10^-8;%image
iteration=0;
while 1
    [A,B,C]=svd(M-S+(u^-1)*Y,'econ');
    L=A*(shrinkage(B,1/u))*C';  %C??????
    S=shrinkage(M-L+(u^-1)*Y,r/u);
    Y=Y+u*(M-L-S);
    iteration=iteration+1
    i=sqrt(sum(sum((M-L-S).^2)));   %video
    %i=sqrt(sum(sum((L-L_0).^2)))/sqrt(sum(sum((L_0).^2)));  %numerical
    %i=max(max(max(abs(L+S-M)))); %image
    if i<terminate
        break
    end
end
error=i;

function S_t=shrinkage(N,t)
S_t = sign(N) .* max(abs(N) - t, 0);