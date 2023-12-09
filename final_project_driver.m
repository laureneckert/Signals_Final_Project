% Lauren Eckert
% Jaric Abadinas
% Driver for Final Project

%{
% Part 1

% 1.1 Read and plot the image.
path_to_image = 'C:\Users\laure\Dropbox\School\BSE\Coursework\23 Fall\SignalsAndSystems\Labs\final project\Signals_Final_Project\att_faces\s15\5.pgm';

% Displaying a message indicating image loading
disp('Loading and displaying the original image...');
[img, map] = imread(path_to_image); % Replace 'path_to_image' with the actual path to your image file.

% Display the original image in a separate window with a caption
figure('Name', 'Original Image', 'NumberTitle', 'off');
imshow(img, map);
title('Original Image');

% 1.2 Find the 2-D DCT of the image.
disp('Calculating the 2-D DCT of the image...');
img2dct = dct2(img);

% 1.3 Plot the 2-D DCT
% Display the 2-D DCT coefficients in a separate window with a caption
figure('Name', '2-D DCT', 'NumberTitle', 'off');
imshow(img2dct, map);
title('2-D DCT Coefficients');

% 1.4 Find the inverse 2-D DCT to recover the original image and plot it
disp('Recovering the original image from 2-D DCT...');
img_recover = idct2(img2dct);

% Display the recovered image in a separate window with a caption
figure('Name', 'Recovered Image', 'NumberTitle', 'off');
imshow(img_recover, map);
title('Recovered Image');

% Compute and plot the log magnitude of 2-D DCT
disp('Computing and displaying the log magnitude of 2-D DCT...');
t1 = 0.01 * abs(img2dct);
t2 = 0.01 * max(max(abs(img2dct)));
c_hat = 255 * (log10(1 + t1) / log10(1 + t2));

% Display the log magnitude of 2-D DCT in a separate window with a caption
figure('Name', 'Log Magnitude of 2-D DCT', 'NumberTitle', 'off');
imshow(c_hat, map);
title('Log Magnitude of 2-D DCT');
%}

% Part 2

% 2.3 Generate and plot 1-D Feature Vectors

% Image choice 1: S3.2
path_to_image_1 = "C:\Users\laure\Dropbox\School\BSE\Coursework\23 Fall\SignalsAndSystems\Labs\final project\Signals_Final_Project\att_faces\s3\2.pgm";

% generate for dimension 9
feature_vector = findfeatures(path_to_image_1, 9);
% plot for dimension 9
figure; % Open a new figure window
plot(feature_vector);
title('1-D Feature Vector, Image: S3.2, Dimension: 9');

% generate for dimension 35
feature_vector = findfeatures(path_to_image_1, 35);
% plot for dimension 35
figure; % Open another new figure window
plot(feature_vector);
title('1-D Feature Vector, Image: S3.2, Dimension: 35');

% generate for dimension 100
feature_vector = findfeatures(path_to_image_1, 100);
% plot for dimension 100
figure; % Open yet another new figure window
plot(feature_vector);
title('1-D Feature Vector, Image: S3.2, Dimension: 100');

% Image choice 2: S15.9
path_to_image_2 = "C:\Users\laure\Dropbox\School\BSE\Coursework\23 Fall\SignalsAndSystems\Labs\final project\Signals_Final_Project\att_faces\s15\9.pgm";

% generate for dimension 9
feature_vector = findfeatures(path_to_image_2, 9);
% plot for dimension 9
figure; % Open a new figure window
plot(feature_vector);
title('1-D Feature Vector, Image: S15.9, Dimension: 9');

% generate for dimension 35
feature_vector = findfeatures(path_to_image_2, 35);
% plot for dimension 35
figure; % Open another new figure window
plot(feature_vector);
title('1-D Feature Vector, Image: S15.9, Dimension: 35');

% generate for dimension 100
feature_vector = findfeatures(path_to_image_2, 100);
% plot for dimension 100
figure; % Open yet another new figure window
plot(feature_vector);
title('1-D Feature Vector, Image: S15.9, Dimension: 100');
