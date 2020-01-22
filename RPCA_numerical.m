function [L,S,Y,iteration,error]=RPCA_numerical(M,L_0)
n=size(M);
u=n(1)*n(2)/(4*sum(sum(abs(M))));
r=1/(sqrt(max(n)));
L=zeros(n);
S=zeros(n);
Y=zeros(n);
terminate=10^-3;    %numerical
iteration=0;
while 1
    [A,B,C]=svd(M-S+(u^-1)*Y,'econ');
    L=A*(shrinkage(B,1/u))*C';  %C??????
    S=shrinkage(M-L+(u^-1)*Y,r/u);
    Y=Y+u*(M-L-S);
    iteration=iteration+1
    i=sqrt(sum(sum((L-L_0).^2)))/sqrt(sum(sum((L_0).^2)));  %numerical
    if i<terminate
        break
    end
end
error=i;

function S_t=shrinkage(N,t)
S_t = sign(N) .* max(abs(N) - t, 0);