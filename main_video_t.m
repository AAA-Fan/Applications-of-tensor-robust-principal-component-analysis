clc;clear;
addpath(genpath(cd));
struct = load('data.mat');
data = struct.my_images(:,:,1:100);   %change
data = im2double(data);
n=size(data);
r=1/(sqrt(max(n(1),n(2))*n(3)));
[L,E,Y,iteration]=T_RPCA(data,r);