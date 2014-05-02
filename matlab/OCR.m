%{
Optical Character Recognition in MATLAB
using Neural Network

by Saurav Tomar
(@sauravtom)
 
<
Source Code License
and url
>

%}

warning off %#ok<WNOFF>

% Clear all
clc, close all, clear all

% Read image
imagen=imread('test.png');

% Show image
imshow(imagen);
title('INPUT IMAGE WITH NOISE')

% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end

% Convert to BW
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);

% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);

% Show image
imshow(imagen);
title('INPUT IMAGE WITHout NOISE')

%Storage matrix word from image
word=[ ];
re=imagen;

%Opens text.txt as file for write
fid = fopen('result.txt', 'wt');

% Load templates
load templates
global templates

% Compute the number of letters in template file
num_letras=size(templates,2);

imgn = imagen;
[L Ne] = bwlabel(imgn);
for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
        imshow(img_r);pause(0.5)
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        letter=read_letter(img_r,num_letras);
        % Letter concatenation
        word=[word letter];
end
fprintf(fid,'%s\n',word);
fclose(fid);

%Open 'result.txt' file
winopen('result.txt')
clear all

