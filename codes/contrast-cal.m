% Read the image
image = imread('your_image_file.jpg');
% Convert the image to grayscale if it is not already
if size(image, 3) == 3
image = rgb2gray(image);
end
% Convert the image to double
image = double(image);
% Get the dimensions of the image
[n, m] = size(image);
% Calculate the metric C
sum_I2 = sum(sum(image.^2));
sum_I = sum(sum(image));
C = (1/(n*m)) * sum_I2 - ( (1/(n*m)) * sum_I )^2;
% Display the result
disp(['The calculated metric C is: ', num2str(C)]);
