
F = imread('Terkikis1.jpg');
[r,c] = size(F);
G = zeros(r,c);
h = (1/9) * ones(3,3);
G = conv2(F,h,'same');
G = uint8(G);
subplot(1,4,1), title('asli'), imshow(F), subplot(1,4,2), title('berubah'), imshow(G), subplot(1,4,3), imhist(F), subplot(1,4,4), imhist(G)
