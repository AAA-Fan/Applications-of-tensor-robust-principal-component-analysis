clc;clear;
pic=imread('/Users/apple/Desktop/yhy/Yuhong_matlab.PNG'); %
imshow(pic);  %
save('picture.mat','pic'); %
struct = load('picture.mat');
pic = struct.pic(:,:,:);
pic = im2double(pic);
rhos = 0.05;
[n1,n2,n3]=size(pic);
ind = find(rand(n1*n2*n3,1)<rhos);
pic(ind) = rand(length(ind),1);
n=size(pic);
matrix=zeros(n(1)*n(2),n(3));
for i=1:n(3)    %matrix??
    for j=1:n(2)   %matrix??
        matrix(n(1)*(j-1)+1:n(1)*j,i)=pic(:,j,i);
    end
end
[L,S,Y,iteration]=RPCA(matrix);
for i = 1:size(L,2)
    Limg(:,:,i)=reshape(L(:,i),[336,496]);   %change
    Simg(:,:,i)=reshape(abs(S(:,i)),[336,496]);   %change
end