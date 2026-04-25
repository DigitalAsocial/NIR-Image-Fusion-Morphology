% Read the image
image = imread('your_image_file.jpg');
% Ensure the image is in the correct format
if size(image, 3) == 1
% Convert grayscale image to RGB by replicating the single channel
rgb_image = cat(3, image, image, image);
else
% Ensure the image is already an MxNx3 array
rgb_image = image;
end
% Verify the RGB image format
if size(rgb_image, 3) ~= 3
error('The image must be a color image (MxNx3 array).');
end
% Convert the image to HSV color space
hsv_image = rgb2hsv(rgb_image);
% Extract the saturation component
saturation = hsv_image(:, :, 2);
% Calculate the average saturation
average_saturation = mean(saturation(:));
% Display the result
disp(['The average saturation is: ', num2str(average_saturation)]);
