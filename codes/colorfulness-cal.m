% Read the image
image = imread('your_image_file.jpg');
% Convert the image to Lab color space
lab_image = rgb2lab(image);
% Extract the 'a' and 'b' channels
a_channel = lab_image(:, :, 2);
b_channel = lab_image(:, :, 3);
% Calculate the mean and standard deviation of 'a' and 'b' channels
mu_a = mean(a_channel(:));
mu_b = mean(b_channel(:));
sigma_a = std(a_channel(:));
sigma_b = std(b_channel(:));
% Calculate the colorfulness metric components
sigma_ab = sqrt(sigma_a^2 + sigma_b^2);
C_p = sqrt(a_channel.^2 + b_channel.^2);
mu_c = mean(C_p(:));
% Calculate the Colorfulness metric (CF)
CF = sigma_ab + 0.94 * mu_c;
% Display the result
disp(['The calculated Colorfulness (CF) is: ', num2str(CF)]);
