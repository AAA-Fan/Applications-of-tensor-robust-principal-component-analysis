function RANK=rank_1(M)
n=size(M);
M_fft=fft(M,[],3);
for i=1:n(3);
    RANK(i)=rank(M_fft(:,:,i));
end
RANK=max(RANK);