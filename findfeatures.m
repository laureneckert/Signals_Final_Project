function [result] = findfeatures(filename,dctlength)
% FINDFEATURES Extracts a feature vector from an image using DCT.
% filename: Path to the image file.
% dctlength: Desired length of the DCT feature vector.
% Example: [result] = findfeatures('s1.pgm', 35); 

% Read image
[ingresso] = imread(filename); % Load the image
Lout = dctlength; % Set the output feature vector length

% Initialize zig-zag scanning
[dimx, dimy] = size(ingresso); % Get image dimensions
zigzag = zeros(dimx, dimy); % Initialize a matrix for zig-zag scanning
ii = 1;
jj = 1;
zigzag(ii, jj) = 1;
slittox = 0;
slittoy = 1;
last = 0;
cont = 2;

% Perform zig-zag scanning across the image matrix
while cont < dimx * dimy
    % Various if conditions to navigate through the matrix in zig-zag pattern
    % ...
    % (Existing logic for navigating the zig-zag pattern)
    % ...
end
zigzag(dimx, dimy) = dimx * dimy;

% Compute 2-D DCT of the image
t = dct2(ingresso);
vettore_t = t(:); % Convert 2-D DCT coefficients to a vector
vettore_t_zigzag = zeros(size(vettore_t));
vettore_zigzag = zigzag(:);

% Reorder DCT coefficients according to zig-zag pattern
for ii = 1:length(vettore_t)
    vettore_t_zigzag(vettore_zigzag(ii)) = vettore_t(ii);
end

% Extract the feature vector
result = vettore_t_zigzag(2:Lout + 1); % Select the first Lout coefficients, excluding the first (DC component)

end
