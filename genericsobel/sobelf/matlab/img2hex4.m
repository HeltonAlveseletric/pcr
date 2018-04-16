% Image to text conversion


% Read the image from the file
 %[filename, pathname] = uigetfile('*.bmp;*.tif;*.jpg;*.pgm','Pick an M-file');
clear all
close all
clc
img = imread('rice.png'); % board.tif
img = imresize((img),[200 200]);

[ row col p ] =size(img);
if p == 3
    img = rgb2gray(img);
end
imshow(img)

% noise add
% rectImg = img(16:80,16:80);
% rectImg = imnoise(rectImg,'salt & pepper', 0.02);
% img(16:80,16:80) = rectImg;

% Image Transpose
imgTrans = img';
% iD conversion
img1D = imgTrans(:);
% Decimal to Hex value conversion
imgHex = dec2hex(img1D);
imgBin = dec2bin(img1D,10);
% New txt file creation
fid = fopen('rice.txt', 'wt'); %board
% value write to the txt file
for i=1:size(img1D)
    fprintf(fid, '%s\n', imgBin(i,:));
end
% Close the txt file
fclose(fid)









