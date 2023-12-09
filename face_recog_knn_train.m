%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function  [trdata_raw,trclass]=face_recog_knn_train(subject_range,dct_coef)
% Name: face_recog_knn_train
% Function: Create a matrix of training vectors from training photos to be 
%       used for KNN recognition
% Input: subject_range - range of faces to be used, maximum is 40. Usually
%                       input as a vector. For example [1 29] means
%                       subjects 1 to 29 inclusive. The first entry must be
%                       a 1.
%       dct_coef - length of the feature DCT vector used for comparison
% Output: 
%       trdata_raw - trainng data of DCT vectors
%       trclass - class labels for each training data vector
% Run: Loop through the user defined number of subjects wanted (defined in
%     the subject range) and create a matrix of length # of subjects x
%     length of DCT (defined by the dct_coef).
% Output file: Mat file that includes the training vectors with 
%       corresponding labels. This file will be used in performance
%       evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [trdata_raw, trclass] = face_recog_knn_train(subject_range, dct_coef)
% FACE_RECOG_KNN_TRAIN Prepares training data for kNN classifier.
% subject_range: Vector of subject IDs to include in the training.
% dct_coef: Number of DCT coefficients for the feature vectors.
% Example usage:
% [trdata_raw, trclass] = face_recog_knn_train([1 40], 70);

% Set the base directory for the image files
image_dir = 'C:\Users\laure\Dropbox\School\BSE\Coursework\23 Fall\SignalsAndSystems\Labs\final project\Signals_Final_Project\att_faces\';  % actual images directory path

% Initialize training data and class labels
trdata_raw = []; 
trclass = []; 

% Initialize error log
error_log = {};

% Loop through the specified range of subjects
for i = subject_range(1):subject_range(2)
    face_feat = zeros(5, dct_coef);  % Initialize feature vectors for the current subject
    
    % Loop through the first five images for each subject
    for j = 1:5
        % Construct the full path to the image file
        file_path = [image_dir 's' num2str(i) '\' num2str(j) '.pgm'];
        
        % Check if the image file exists
        if exist(file_path, 'file') == 2
            % If the file exists, extract features
            face_feat(j,:) = findfeatures(file_path, dct_coef);
        else
            % If the file does not exist, log an error message
            error_message = ['File does not exist: ' file_path];
            disp(error_message);
            error_log{end+1} = error_message;
            continue;  % Skip to the next image
        end
    end
    
    % Concatenate the feature vectors and class labels
    trdata_raw = [trdata_raw; face_feat];  % Append current subject's feature vectors
    trclass = [trclass; i * ones(5, 1)];  % Append current subject's labels
end

% Optionally, save the training data and error log to a .mat file
save('training_data_and_errors.mat', 'trdata_raw', 'trclass', 'error_log');

end
