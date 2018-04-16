% funcao para decodificar resultados obtidos pela arquitetura de hardware
% do filtro Sobel para iamgem NxN. A imagem de saída fica sem as bordas
% superior e inferior, porem as bordas laterais continuam na imagem.

clc
close all
clear all
% ImSize=100*100; % numero de pixels da imagem de saida

img = imread('tape.png'); % board.tif
img = imresize((img),[100 100]);

[ row col p ] =size(img);
if p == 3
    img = rgb2gray(img);
end
figure; imshow(img)

out_img_bin=textread('res_tape1.txt', '%s');
out_img_str=cell2mat(out_img_bin);


hw_sobel=255*ones(99,99);
for i=1:size(out_img_bin)    
    %hw_sobel(sync_v,sync_h)=bin2dec(out_img_str(i,:));
    %dec = dec + str2num(out_img_str(i,j)) * 2^(length(out_img_str(i,:)) - j);
    
%     if i==5409
%         i
%     end
    
    if out_img_str(i,1)=='1'
        s = strcat('1111',out_img_str(i,:));
        s = bitStrCmp(s);
        dec = -(bin2dec(s)+1);
        
    else
        s = strcat('0000',out_img_str(i,:));
        dec = bin2dec(s);
    end
    
%     if dec > 255
%         dec = 255;
%     elseif dec < 0
%         dec = 0;
%     end
    
    out_img_dec(i) = dec;
      
end

sync_h=0;
sync_v=1;
i = 1;
while i < length(out_img_dec)
    if sync_h == 99
        sync_v = sync_v+1;
        sync_h = 1;
        i = i+1;
    else
        sync_h = sync_h+1;
    end
    
    hw_sobel(sync_v,sync_h)=out_img_dec(i);
    i = i+1;
end
        

% pixMax = max(max(hw_sobel));
% pixMin = min(min(hw_sobel));
% 
% hw_sobel = round( (hw_sobel - pixMin)*255./(pixMax - pixMin) );

figure; 
imshow(hw_sobel,[])

% SObel Matlab
[E My] = GSobel(img,3);
E = E(2:100,2:100);

figure; 
imshow(E,[])

xx = E == hw_sobel;
