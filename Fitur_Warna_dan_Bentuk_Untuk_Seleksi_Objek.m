C = imread('Terkikis1.jpg');


MeanR = regionprops('table',L,C(:,:,1), 'MeanIntensity');
MeanG = regionprops('table',L,C(:,:,2), 'MeanIntensity');
MeanB = regionprops('table',L,C(:,:,3), 'MeanIntensity');

FiturWarna = [MeanR.MeanIntensity MeanG.MeanIntensity MeanB.MeanIntensity];


