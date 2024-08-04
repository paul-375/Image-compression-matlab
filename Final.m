clc
clear all 
close all
x = imread("C:\Users\user1\Documents\Study Material\Signal Processing\Signal Processing Project\rose_bw.jpg")
x = rgb2gray(x)
figure,imshow(x);title('Original Image');
figure,imhist(x);title('Histogram of Original Image')
F = dct2(x);
ff = idct(F);

[r,c] = size(x); %storing image as rows and columns
DF = zeros(r,c);
DFF = DF;
IDF = DF;
IDFF = DF;
depth = 1;
N = 8; %block size 
for i = 1 : N : r %iterating through rows   
    for j = 1 : N : c %iterating through columns
        f = x(i:i+N-1,j:j+N-1);
        df = dct2(f);
        DF(i:i+N-1,j:j+N-1) = df;%DCT of blocks
        dff = idct2(df);
        DFF(i:i+N-1,j:j+N-1) = dff;%inverse DCT of the blocks

        df(N:-1:depth+1,:) = 0;
        df(:,N:-1:depth+1) = 0;
        IDF(i:i+N-1,j:j+N-1) = df;%DCT of blocks with depth considered
        dff = idct2(df);
        IDFF(i:i+N-1,j:j+N-1) = dff;
    end
end
figure;imshow(DF/255);title('DF/255')
A = DFF/255;
figure;imshow(A);title('Image without depth considered')
figure;imhist(A);title('Histogram of image without depth considered')
imwrite(A,'image_no_depth.jpeg')
B = IDFF/255;
imwrite(B,'compressed.jpeg');
figure;imshow(B);title('Compressed Image');
figure;imhist(B);title('Histogram of Compressed Image');


