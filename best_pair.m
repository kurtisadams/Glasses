% Load in the results matrix from the training.
load('results/danh-physical-dodege-openface143.mat', 'result');
gen = result.gen;

% Set options.
% These are the same as the ones in agn.m
latent_dim = 25;
sample_latent = @(n,d)(single(2*(rand(n,d)-0.5)));
batch_size = 25;
inv_transform = @(im)((permute(im, [3 4 2 1])+1)*127.5);

% Create the "noise"(?)
z = sample_latent(batch_size, latent_dim);

% Dislpay the first pair of eyeglasses.
res = vl_simplenn(gen, z);
A = uint8(inv_transform(res(end).x));
%124 364
A = imresize( A, [300 881] );
imshow(A(:,:,:,1));
