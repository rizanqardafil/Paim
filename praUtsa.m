B = imread('grayBaru.jpg');

[row, col] = size(B);

Gx = zeros(row,col);
Gy = zeros(row,col);
G = zeros(row,col);

sx = (1/8)*[-1 0 1;-2 0 2; -1 0 1];
sy = (1/8)*[1 2 1; 0 0 0; -1 -2 -1];

Gx = conv2(double(B), sx, 'same');
Gy = conv2(double(B), sy, 'same');
absGx = uint8(abs(Gx));
absGy = uint8(abs(Gy));

Gx = uint8(Gx);
Gy = uint8(Gy);
G = absGx + absGy;

imwrite(G, 'TepiSobel.jpg');
subplot(1,2,1), imshow(Gx),  title('Gx'), subplot(1,2,2), imshow(absGx), title('|Gx|');
figure;
subplot(1,2,1), imshow(Gy), title('Gy'), subplot(1,2,2), imshow(absGy), title('|Gy|');
figure;
subplot(1,2,1), imshow(B), title('binary'), subplot(1,2,2), imshow(G), title('Tepi/Edge');
