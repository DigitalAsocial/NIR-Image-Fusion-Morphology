% Based on paper:
M_rgb2xyz = [0.5141, 0.3239, 0.1604; 0.2651, 0.6702, 0.0641; 0.0241, 0.1228, 0.8444];
M_xyz2lms = [0.3897, 0.6890, -0.0787; -0.2298, 1.1834, 0.0464; 0.0000, 0.0000, 1.0000];
% Calculate the combined RGB to LMS matrix
M_rgb2lms = M_xyz2lms * M_rgb2xyz;
% Calculate the inverse for LMS to RGB
M_lms2rgb = inv(M_rgb2lms);
% Display the results
disp('RGB to LMS Matrix:');
disp(M_rgb2lms);
disp('LMS to RGB Matrix:');
disp(M_lms2rgb);
