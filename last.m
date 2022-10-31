c9citraAsli = imread("imageTest.jpg");
citraGray = rgb2gray(citraAsli);
[row col] = size(citraGray);
rerataR = regionprops(L, citraAsli(:,:,1), 'MeanIntensity');
rerataG = regionprops(L, citraAsli(:,:,2), 'MeanIntensity');
rerataB = regionprops(L, citraAsli(:,:,3), 'MeanIntensity');
ciriWarna = [rerataR.MeanIntensity;rerataG.MeanIntensity;rerataB.MeanIntensity]';
stats = regionprops(L, 'Area', 'Perimeter', 'Centroid');
Roundness = (stats.Perimeter).^2./(4*pi*stats.Area);
Ciri = [ciriWarna stats.Area stats.Perimeter Roundness]
indeksUngu = find(Ciri(:,1) > 200 & Ciri(:,3) > 200)
citraL400 = zeros(row, col);

for k=1:length(indeksUngu)
  citraL400(find(L==indeksUngu(k))) = 1;
end
figure, imshow(citraL400), title('citra objek <400');
