function [predicted_labels, success_rate] = knn_classifier(training_data, training_labels, test_filenames, k)
    % Initialize the predicted labels
    predicted_labels = zeros(length(test_filenames), 1);
    
    % Initialize true labels for the test data
    test_labels = zeros(length(test_filenames), 1);
    
    % Process each test file
    for i = 1:length(test_filenames)
        % Extract features from test image
        test_features = findfeatures(test_filenames{i}, size(training_data, 2));

        % Ensure test_features is a row vector for proper subtraction
        test_features = test_features(:)'; % Transpose if necessary

        % Calculate L2 distances to all training data
        % replicate test_features to match the number of rows in training_data
        distances = sqrt(sum((repmat(test_features, size(training_data, 1), 1) - training_data).^2, 2));

        % Find the k closest training samples
        [~, sorted_indices] = sort(distances);
        nearest_labels = training_labels(sorted_indices(1:k));
        
        % Majority voting to decide the predicted label
        predicted_labels(i) = mode(nearest_labels);
        
        % Extract the true label (subject number) from the filename
        test_labels(i) = extractSubjectNumber(test_filenames{i});
    end
    
    % Calculate the success rate
    correct_predictions = sum(predicted_labels == test_labels);
    success_rate = (correct_predictions / length(test_labels)) * 100;
end

function subject_number = extractSubjectNumber(filename)
    % This function extracts the subject number from the filename
    % It assumes the filename format is like 's15/6.pgm'
    tokens = regexp(filename, 's(\d+)', 'tokens');
    subject_number = str2double(tokens{1}{1});
end
