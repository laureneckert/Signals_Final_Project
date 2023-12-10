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

%{
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
%}

%Part 3
[trdata_raw, trclass] = face_recog_knn_train([1 40], 70);

%Part 4
% Load the training data
% Load the training data from the MAT file
loadedData = load('raw_data.mat');

% Check if the required variables are in the loaded data
if isfield(loadedData, 'trdata_raw') && isfield(loadedData, 'trclass')
    % Extract the variables from the structure
    trainingData = loadedData.trdata_raw;
    trainingLabels = loadedData.trclass;

    % Display a message confirming successful loading
    disp('Training data and labels successfully loaded.');
    disp(['Size of training data: ', mat2str(size(trainingData))]);
    disp(['Size of training labels: ', mat2str(size(trainingLabels))]);
else
    % Display an error message if the variables are not found
    error('Required variables are not found in the MAT file.');
end

% Define the range for k and dimensions
k_values = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21];
dimension_values = 25:15:70; % Adjusted to go up to 70
results = zeros(length(dimension_values), length(k_values)); % Store success rates

% Define the base directory for the images
base_image_dir = 'C:\Users\laure\Dropbox\School\BSE\Coursework\23 Fall\SignalsAndSystems\Labs\final project\Signals_Final_Project\att_faces\';  % Replace with the actual directory path

% Loop over each dimension
for d_idx = 1:length(dimension_values)
    dimension = dimension_values(d_idx);

    % Reduce the training data to the current dimension
    reduced_training_data = trdata_raw(:, 1:dimension);

    % Prepare filenames for test images
    test_filenames = {};
    for subject = 1:40
        for img_num = 6:10
            test_filenames{end+1} = fullfile(base_image_dir, sprintf('s%d/%d.pgm', subject, img_num));
        end
    end

    % Loop over each k value
    for k_idx = 1:length(k_values)
        k = k_values(k_idx);
        
        % Call the kNN classifier
        [~, success_rate] = knn_classifier(reduced_training_data, trclass, test_filenames, dimension, k);
        % Log the dimension and success rate
        disp(['Testing dimension: ', num2str(dimension), ', k: ', num2str(k), ', Success rate: ', num2str(success_rate), '%']);

        % Store the success rate
        results(d_idx, k_idx) = success_rate;
    end
end

% Generate the 3-D plot
[X, Y] = meshgrid(k_values, dimension_values);
Z = results;
surf(X, Y, Z);
xlabel('k value');
ylabel('Dimension of feature vector');
zlabel('Identification Success Rate (%)');
title('kNN Classifier Performance');

% Analyze the best values for k and the dimension
[max_success_rate, idx] = max(Z(:));
[best_dimension_idx, best_k_idx] = ind2sub(size(Z), idx);
best_dimension = dimension_values(best_dimension_idx);
best_k = k_values(best_k_idx);
fprintf('Best dimension: %d, Best k: %d, Success Rate: %.2f%%\n', best_dimension, best_k, max_success_rate);
