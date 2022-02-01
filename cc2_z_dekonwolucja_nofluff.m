%%%%%%%%%%%%%%%%%%%%%%
%written by Monika Paw³owska, monika.pawlowska@fuw.edu.pl
%version 01.02.2022
%comments: 
%I use it with Localizer.mexw64, cblas.dll, gsl.dll, tbb.dll in the same directory as script
%FastTiff is optional and taken from
%https://www.mathworks.com/matlabcentral/answers/105739-how-to-show-tiff-stacks
%my_image_showing and my_saving are written by me and also optional
%%%%%%%%%%%%%%%%%%%%%%

clear variables
clear output

[fname,dirpth] = uigetfile('*.tif');
status=mkdir([dirpth,'results']);
template=[dirpth,'results/',extractBefore(fname, '.tif')];

%read image
im = FastTiff([dirpth, fname]);

%compute, show, save mean
im_mean=transpose(mean(im, 3));
my_image_showing(im_mean, 'Mean')
my_saving(transpose(im_mean), template,'_mean.tif', false);

%do SOFI
sofi2=Localizer('sofi', 2, strcat(dirpth, fname), 'nFramesToInclude', 2000);
sofi2=sofi2{1,1};

%show and save
my_image_showing(sofi2, 'SOFI crosscumulant2')
my_saving(transpose(sofi2),template, '_SOFI2.tif', false);

%do deconvolution
PSF0 = fspecial('gaussian', [31,31], 1);
sofi2_dec=deconvlucy(sofi2, PSF0, 5);

%show and save
my_image_showing(sofi2_dec, 'Deconvolved')
my_saving(transpose(sofi2_dec),template,'_SOFI2_Deconv.tif', false);
disp(strcat('done saving ', template))