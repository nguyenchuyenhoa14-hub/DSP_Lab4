clc; clear; clf;

atomsLoad('IPCV');

img = imread('/Users/vohoangnguyen/Documents/DSP_Lab/DSP_Lab4/image.png');
gray = rgb2gray(img);

subplot(2,2,1); imshow(gray); title('Original');

subplot(2,2,2);
h = imhist(gray);
plot2d3(0:255, h/1000, style=color('blue'));
title('Original Histogram');

function eq_img = my_histeq(img)
    h = imhist(img);
    cdf = cumsum(h);
    cdf_min = min(cdf(cdf > 0));
    num_pixels = prod(size(img));
    eq_map = uint8((cdf - cdf_min) / (num_pixels - cdf_min) * 255);
    eq_img = eq_map(img + 1);
endfunction

eq = my_histeq(gray);

subplot(2,2,3); imshow(eq); title('After Equalization');

subplot(2,2,4);
h_eq = imhist(eq);
plot2d3(0:255, h_eq/1000, style=color('red'));
title('Equalized Histogram');
