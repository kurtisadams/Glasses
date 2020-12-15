%% physical impersonation vs. VGG10

% parameters
n_epochs = 1;
n_ims = 6;
stop_prob = 0.924;
kappa = 0.25;
lr = 5e-5;
weight_decay = 1e-5;

% gpu/cpu?
platform = 'cpu';
if gpuDeviceCount>0
    platform = 'gpu';
end
             
% model and attacker's images
face_net_path = 'models/vgg10-recognition-nn.mat';
im_wildcard = 'aligned_*.png';
im_dir = 'data/demo-data2/';
im_files = dir(fullfile(im_dir, im_wildcard));
im_files = im_files(randperm(numel(im_files)));
im_files = im_files(1:min([n_ims numel(im_files)]));
im_filepath = fullfile(im_dir, extractfield(im_files, 'name'));

% target to impersonate
target = 6;
targets = repmat(target, [numel(im_filepath) 1]);

% transform eyeglasses based on the green marks
load('data/auxiliary/eyeglass_marks_centers.mat', 'eyeglass_marks_centers');
eyeglass_tforms = [];
for i_m = 1:numel(im_filepath)
    im = imread(im_filepath{i_m});
    centers = find_green_marks(im, 0, [155 155 155]);
    tform = fitgeotrans(eyeglass_marks_centers, centers, 'projective');
    eyeglass_tforms = cat(1, eyeglass_tforms, tform);
end

% run attack
[gen, discrim, objective] = agn_realizable(...
                                           'face_net_path', face_net_path, ...
                                           'kappa', kappa, ...
                                           'lr_gen', lr, ...
                                           'weight_decay', weight_decay, ...
                                           'attack', 'impersonate', ...
                                           'targets', targets, ...
                                           'stop_prob', stop_prob, ...
                                           'face_im_paths', im_filepath, ...
                                           'eyeglass_tforms', eyeglass_tforms, ...
                                           'n_epochs', n_epochs, ...
                                           'platform', platform ...
                                           );

% store results
result  = struct('gen', gen, 'discrim', discrim, 'objective', objective, ...
                 'target', targets, 'im_path', im_filepath, 'attack_type', 'impersonate', ...
                 'stop_prob', stop_prob, 'lr', lr, 'kappa', kappa, ...
                 'weight_decay', weight_decay, 'face_net_path', '', ...
                 'eyeglass_tforms', eyeglass_tforms);
save('results/danh-physical-impersonation-6photo-vgg10.mat', 'result');
