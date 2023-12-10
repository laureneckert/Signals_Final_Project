function [predicted_labels, success_rate] = knn_classifier(training_data, training_labels, test_filenames, dct_length, k)
    % Extract features from test images using the provided findfeatures function
    test_data = [];
    for i = 1:length(test_filenames)
        test_features = findfeatures(test_filenames{i}, dct_length);
        test_data = [test_data; test_features'];
    end
    
    % Initialize the predicted labels
    predicted_labels = zeros(size(test_data, 1), 1);
    
    % Initialize true labels for the test data
    test_labels = repmat((1:40)', 5, 1); % 40 subjects, 5 images each
    
    % Loop over all test samples
    for i = 1:size(test_data, 1)
        % Compute L2 distance between the test sample and all training samples
        distances = sqrt(sum((training_data - test_data(i, :)).^2, 2));
        
        % Sort distances and select the k-nearest neighbors
        [~, nearest_indices] = sort(distances);
        k_nearest_labels = training_labels(nearest_indices(1:k));
        
        % Assign the label based on majority voting
        predicted_labels(i) = mode(k_nearest_labels);
        
        % Log the predicted label for each test sample
        disp(['Test sample ', num2str(i), ' predicted as label: ', num2str(predicted_labels(i))]);
    end
    
    % Calculate success rate
    correct_matches = sum(predicted_labels == test_labels);
    success_rate = (correct_matches / length(test_labels)) * 100;
end
