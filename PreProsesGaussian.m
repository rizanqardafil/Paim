function PreProsesGaussian
F = imread('Kasusgray.jpg');
[r,c] = size(F);
G = zeros(r,c);

h = gausianKernel(11);
G = conv2(double(F),h,'same');
G = uint8(G);
subplot(1,4,1), imshow(F),subplot(1,4,2),imshow(G), subplot(1,4,3),imhist(F), subplot(1,4,4),imhist(G)
