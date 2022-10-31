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

