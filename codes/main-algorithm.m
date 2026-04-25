clear all
clc
% Read the images
V = imread('0055_rgb.tiff'); % Visible image
N = imread('0055_nir.tiff'); % NIR image
% Ensure NIR image is double and normalized
lN = double(N);
lN = (lN - min(lN(:))) / (max(lN(:)) - min(lN(:))); % Ensuring range [0, 1]
[x, y, z] = size(V);
% Reshape the visible image for matrix operations
V_reshaped = reshape(im2double(V), [], 3);
% Define transformation matrices
M_rgb2lms = [0.3811 0.5783 0.0402; 0.1967 0.7244 0.0782;
0.0241 0.1288 0.8444]; % M_rgb2lms=M_xyz2lms * M_rgb2xyz;
M_lms2lab1 = [1/sqrt(3) 0 0; 0 1/sqrt(6) 0; 0 0 1/sqrt(2)];
M_lms2lab2 = [1 1 1; 1 1 -2; 1 -1 0];
M_lab2lms1 = [sqrt(3)/3 0 0; 0 sqrt(6)/6 0; 0 0 sqrt(2)/2];
M_lab2lms2 = [1 1 1; 1 1 -1; 1 -2 0];
% Convert to LMS space
LMS_V = M_rgb2lms * V_reshaped';
% Take the log of LMS
LMS_V = log10(max(LMS_V, 1/255));
% Convert to lαβ space
lab_V = M_lms2lab1 * M_lms2lab2 * LMS_V;
% Extract the luminance channel
lV = lab_V(1, :);
% Apply Top-Hat Transformation
se = strel('disk', 9); % Structuring element with λ = 9
TV = imtophat(reshape(lV, x, y), se);
TN = imtophat(reshape(lN, x, y), se);
% Select Relevant Structures and Perform Fusion
TT = max(TV, TN); % Ensure TT is the same size as TV and TN
lT = reshape(lV, x, y) - TV + TT;
% Replace the luminance channel in lαβ
lab_V(1, :) = lT(:)';
% Convert lαβ back to LMS
LMS_res = M_lab2lms2 * M_lab2lms1 * lab_V;
for ch = 1:3
LMS_res(ch, :) = 10.^LMS_res(ch, :);
end
% Convert back to RGB
M_lms2rgb = [4.4679 -3.5873 0.1193; -1.2186 2.3809 -0.1624; 0.0497 -0.2439 1.2045];
F = M_lms2rgb * LMS_res;
F = reshape(F', x, y, 3);
% Display the results
figure;
subplot(1, 3, 1);
imshow(im2uint8(reshape(V_reshaped, x, y, 3)));
title('Visible Image');
subplot(1, 3, 2);
imshow(N);
title('NIR Image');
subplot(1, 3, 3);
imshow(im2uint8(F));
title('Fused Image');
