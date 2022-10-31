data = imread('Kasus6.jpg');
dataB = rgb2gray(data);
imwrite(dataB, 'Kasusgray.jpg');
[counts, idx] = imhist(dataB);

[baris, kolom] = size(dataB);
[baris1, kolom1] = size(dataB);
g = zeros(baris, kolom);
level = graythresh(dataB);
[level, EM]=graythresh(dataB);

for i = 1:baris
    for j = 1:kolom
        if dataB(i,j) > 202 && dataB(i,j) < 214
            g(i,j) = 1;
        end;

    end;
end;

h = zeros(baris1, kolom1);
for i = 1:baris1
    for j = 1:kolom1
        if dataB(i,j) < 202
            h(i,j) = 1;
        end;
    end;
end;

h = logical(h);
g = logical(g);
figure;
subplot(1,3,1), imshow(dataB),subplot(1,3,2), imshow(h),subplot(1,3,3), imshow(g);
