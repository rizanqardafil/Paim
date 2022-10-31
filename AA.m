A = imread('Normal-bovine-erythrocytes.jpg'); #Memanggil File Gambar
B = rgb2gray(A); #Mengubah file gambar RGB menjadi citra graylevel
imwrite(B, 'grayBaru.jpg');
[counts, idx] = imhist(B); #Melihat Statistik Warna
#subplot(1,3,1), imshow(A), title('Asli RGB'), subplot(1,3,2), imshow(B), title('Gray'), subplot(1,3,3), imhist(B), title('Grafik Warna Gray');
[baris, kolom] = size(B); #Menyimpan dimensi matriks sesuai B
g = zeros(baris, kolom); #Memesan matriks g untuk menyimpan hasil segmentasi
for i = 1:baris
  for j = 1:kolom
    if B(i,j) < 212;
      g(i,j) = 1;
    endif
  endfor
endfor
g = logical(g);
figure;
subplot(1,2,1), imshow(B), subplot(1,2,2), imshow(g);


%Batas

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

%Batas


F = imread('Terkikis1.jpg');
[r,c] = size(F);
G = zeros(r,c);
h = (1/9) * ones(3,3);
G = conv2(F,h,'same');
G = uint8(G);
subplot(1,4,1), title('asli'), imshow(F), subplot(1,4,2), title('berubah'), imshow(G), subplot(1,4,3), imhist(F), subplot(1,4,4), imhist(G)

%Batas

function kernel = gausianKernel(k)

kernel = zeros(k,k);
temp = (k-1)/2;
temp1 = (-1*temp);
x = temp1:1:temp;
y = temp1:1:temp;
sigma = 1.5;



n = length(x);

for i=1:n
    for j=1:n
        kernel(i,j) = (1/(2*pi*(sigma^2)))*exp(-((x(i)^2+y(j)^2)/(2*sigma^2)));
    end;
end;

%Batas

function PreProsesGaussian
F = imread('Kasusgray.jpg');
[r,c] = size(F);
G = zeros(r,c);

h = gausianKernel(11);
G = conv2(double(F),h,'same');
G = uint8(G);
subplot(1,4,1), imshow(F),subplot(1,4,2),imshow(G), subplot(1,4,3),imhist(F), subplot(1,4,4),imhist(G)

%Batas
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

%Batas

B = imread("GaussSegmentedBinary.jpg");
I = im2bw(B);
kernel = strel("disk",2, 0)
Terkikis = imerode(I,kernel);
Tepi = xor(Terkikis,I);
imwrite(Terkikis, 'Terkikis1.jpg');
figure;
subplot(2,2,1), imshow(I), title('binary'), subplot(2,2,2), imshow(Terkikis), title('Erosi'), subplot(2,2,3), imshow(Tepi),title('Tepi');

%Batas


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

%Batas

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

%Batas

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

%Batas

citraAsli = imread("imageTest.jpg");
citraGray = rgb2gray(citraAsli);

h5 = 1/25*ones(5,5);
citraKonv5 = conv2(citraGray, h5, 'same');

[row col] = size(citraGray);
citraBiner = zeros(row, col);

for i=1:row
  for j=1:col
    if (citraGray(i,j)<213)
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

idxCanc = find((Ciri(:,1)>100) & (Ciri(:,3)>200) & (Ciri(:,4)>5000));

citraHasil = zeros(row, col);

for i=1:length(idxCanc)
  indexC = find(L==idxCanc(i));
  citraHasil(indexC) = 1;
end

%figure, subplot(2,2,1), imshow(citraAsli), title("Citra Asli"),
%subplot(2,2,2), imshow(citraGray), title("Citra Abu"),
%subplot(2,2,3), imshow(citraBiner), title("Citra Biner"),
%subplot(2,2,4), imshow(citraHasil), title("Hasil")

