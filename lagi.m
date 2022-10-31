citraAsli = imread("Kasus6.jpg");
citraGray = rgb2gray(citraAsli);

h5 = 1/25*ones(5,5);
citraKonv5 = conv2(citraGray, h5, 'same');
[counts,  idx] = imhist(citraGray);

[row col] = size(citraGray);
citraBiner = zeros(row, col);

for i=1:row
  for j=1:col
    if (citraGray(i,j)<216)
      citraBiner(i,j)=1;
    end
  end
end

%citraBiner = im2bw(citraGray);

[L num] = bwlabel(citraBiner);

ciriBentuk = regionprops(L, 'Area');
luas = [ciriBentuk.Area];

rerataR = regionprops(L, citraAsli(:,:,1), 'MeanIntensity');
rerataG = regionprops(L, citraAsli(:,:,2), 'MeanIntensity');
rerataB = regionprops(L, citraAsli(:,:,3), 'MeanIntensity');
ciriWarna = [rerataR.MeanIntensity;rerataG.MeanIntensity;rerataB.MeanIntensity]';

Ciri = [ciriWarna luas'];

idxCanc = find((Ciri(:,1)<203));

citraHasil = zeros(row, col);

for i=1:length(idxCanc)
  indexC = find(L==idxCanc(i));
  citraHasil(indexC) = 1;
end

figure, subplot(2,2,1), imshow(citraAsli), title("Citra Asli"),
subplot(2,2,2), imshow(citraGray), title("Citra Abu"),
subplot(2,2,3), imshow(citraBiner), title("Citra Biner"),
subplot(2,2,4), imshow(citraHasil), title("Hasil")
