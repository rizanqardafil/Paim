%memasukkan gambar
gambar = imread('Normal-bovine-erythrocytes.jpg');

%Mengganti gambar menjadi grayscale
change = rgb2gray(gambar);
[counts, idx] = imhist(change);

%otsu
pilih = graythresh(change)*255;

%memisahkan antara background dan foreground
[baris, kolom] = size(change);
g = zeros(baris,kolom);
for i= 1:baris
    for j = 1:kolom
        if change(i,j) < pilih
            g(i,j) = 1;
        end
    end
end
g = logical(g);


%morphology
kecil = strel('square', 3);
tutup = imclose(g,kecil);

besar = strel ('disk',2, 0);
melebar = imdilate(tutup,besar);
Tepian = xor(melebar,tutup);

%mengeliminasi sel tidak sempurna
[L,num] = bwlabel(melebar,4);

EkstraksiCiri = regionprops(L, 'Area', 'Perimeter', 'Eccentricity')
luas = [EkstraksiCiri.Area]

perimeter = [EkstraksiCiri.Perimeter]

index = find(luas > 907 & perimeter > 100);

Baru = zeros(size(L));
k = length(index);
for i=1:k
    Baru(L==(index(i)))= 1;
end

figure, imshow(L), title('labelled cells');
figure, imshow(Baru), title('selected cells by area')

%penghapusan sel ungu dari var baru
[L,num] = bwlabel(melebar,4);

EkstraksiCiri1 = regionprops(L, 'Area', 'Perimeter', 'Eccentricity');
luas1 = [EkstraksiCiri1.Area]
perimeter1 = [EkstraksiCiri1.Perimeter]
index = find(luas1 > 700 & perimeter1 > 90);
Baru1 = zeros(size(L));


k = length(index);
for i=1:k
    Baru(L==(index(i)))= 1;
end

imshow(L), title('labelled cells');
figure, imshow(Baru), title('selected cells by area')


%pewarnaan sel yang sudah di eliminasi dari var Baru
[L2,num2] = bwlabel(Baru,4);
C = zeros(baris,kolom,3);
for i = 1:baris
    for j =1:kolom
        if L2(i,j)
            C(i,j,:) = gambar(i,j,:);
        end
    end
end


C = uint8(C);
figure, imshow(L2), title('labelled cells');
figure, imshow(C), title('segmented colour');

MeanR = regionprops(L2, C(:,:,1),'MeanIntensity');
MeanG = regionprops(L2, C(:,:,2),'MeanIntensity');
MeanB = regionprops(L2, C(:,:,3),'MeanIntensity');

FiturWarna = [MeanR.MeanIntensity MeanG.MeanIntensity MeanB.MeanIntensity];
ShapeDescp = regionprops(L2,'Perimeter','Area');

perimeter2 = [ShapeDescp.Perimeter]
area2 = [ShapeDescp.Area]
Roundness = (perimeter2.^2)./(4*pi*area2);

Ciri = [FiturWarna area2 perimeter2 Roundness];

%seleksi berdasar ciri warna dan bentuk
indeksTrombosit = find(Ciri(:,1) > 135 & Ciri(:,3) > 150 & Ciri(:,6) <= 2);

Baru2 = zeros(baris,kolom);
k = length(indeksTrombosit);
for i=1:k
       Baru2(L2==(indeksTrombosit(i)))= 1;
end
Baru2 = logical(Baru2);
%visualize(Baru2)

[L3,num10] = bwlabel(Baru2,4);
figure, imshow(L3), title('labelled cells');

