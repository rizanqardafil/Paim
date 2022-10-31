B = imread("GaussSegmentedBinary.jpg");
C = im2bw(B);
objek = bwlabel(C, 8);,


[L, num] = bwlabel(C);
jumlah_objek = max(objek(:));
label = zeros(size(C));

[row, col] = size(label);

for i=1:row
    for j=1:col
        if(L(i,j) == 15 || L(i,j) == 30 || L(i,j) == 60)
            label(i,j) = 1;
        end;
    end;
end;
stats = regionprops(L , 'Area', 'Perimeter', 'Centroid')
area = [stats.Area]
index = find(area < 400)


index1 = find(area ~= 0 & area>400)

Baru = zeros(size(L));
k = length(index1);
for i=1:k
    Baru(find(L==(index1(i)))) = 1;
end;
figure;
subplot(1,2,1), imshow(L), subplot(1,2,2),imshow(Baru);
