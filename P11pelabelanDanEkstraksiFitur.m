
B = imread("Normal-bovine-erythrocytes.jpg");
I = im2bw(B);
[row col] = size(I);
imshow(I), title('citra biner')
[L, n] = bwlabel(I);
figure, imshow(L), title('citra label');

##stats = regionprops('table', L, 'Area', 'Perimeter', 'Centroid')
stats = regionprops(L, 'Area', 'Perimeter', 'Centroid')
luas = [stats.Area]

idxLabel = find ((luas~=0) & (luas <= 22))

citraL400 = zeros(row, col);

for k=1:length(idxLabel)
	citraL400(find(L==idxLabel(k))) = 1;
end
figure, imshow(citraL400), title('citra objek <400');

