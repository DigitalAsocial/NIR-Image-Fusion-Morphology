% Read the image
image = imread('your_image_file.jpg');
% Convert the image to grayscale if it is not already
if size(image, 3) == 3
image = rgb2gray(image);
end
% Convert the image to double
image = double(image);
% Calculate the histogram
[counts, ~] = imhist(image);
% Normalize the histogram to get the probability distribution
P = counts / numel(image);
% Calculate the entropy
entropy = -sum(P(P > 0) .* log2(P(P > 0)));
% Display the result
disp(['The calculated entropy is: ', num2str(entropy)]);
