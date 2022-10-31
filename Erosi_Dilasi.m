B = imread("GaussSegmentedBinary.jpg");
I = im2bw(B);
kernel = strel("disk",2, 0)
Terkikis = imerode(I,kernel);
Tepi = xor(Terkikis,I);
imwrite(Terkikis, 'Terkikis1.jpg');
figure;
subplot(2,2,1), imshow(I), title('binary'), subplot(2,2,2), imshow(Terkikis), title('Erosi'), subplot(2,2,3), imshow(Tepi),title('Tepi');
