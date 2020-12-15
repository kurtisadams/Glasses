%% physical dodging vs. Openface143

% parameters
n_epochs = 4;
n_ims = 32;
stop_prob = 0.01;
kappa = 0.25;
lr = 5e-5;
weight_decay = 1e-5;

% cpu/gpu?
platform = 'cpu';
if gpuDeviceCount>0
    platform = 'gpu';
end

% model and attacker's images
face_net_path = 'models/openface143-recognition-nn.mat';
im_wildcard = 'aligned_*.png';
im_dir = 'data/demo-data2/';
im_files = dir(fullfile(im_dir, im_wildcard));
im_files = im_files(randperm(numel(im_files)));
im_files = im_files(1:min([n_ims numel(im_files)]));
im_filepath = fullfile(im_dir, extractfield(im_files, 'name'));

% attacker's class
target = 142;
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

% find transforms to align images & eyeglasses to the openface pose
ims = [];
for i_im = 1:numel(im_filepath)
    ims = cat(4, ims, imread(im_filepath{i_im}));
end
align_data = load('dependencies/openface/alignment_info.mat');
[~, tforms] = openface_align(ims, align_data.align_info);
alignment.tforms = [];
for i_t = 1:numel(tforms)
    alignment.tforms = cat(1, alignment.tforms, tforms{i_t});
end
alignment.im_size = [align_data.align_info.dim align_data.align_info.dim];

% run attack
[gen, discrim, objective] = agn_realizable_dagnn(...
                                            'face_net_path', face_net_path, ...
                                            'alignment', alignment, ...
                                            'kappa', kappa, ...
                                            'lr_gen', lr, ...
                                            'weight_decay', weight_decay, ...
                                            'attack', 'dodge', ...
                                            'targets', targets, ...
                                            'stop_prob', stop_prob, ...
                                            'face_im_paths', im_filepath, ...
                                            'n_epochs', n_epochs, ...
                                            'platform', platform, ...
                                            'eyeglass_tforms', eyeglass_tforms ...
                                            );

% store results
result  = struct('gen', gen, 'discrim', discrim, 'objective', objective, ...
                 'target', targets, 'im_path', im_filepath, 'attack_type', 'dodge', ...
                 'stop_prob', stop_prob, 'lr', lr, 'kappa', kappa, ...
                 'weight_decay', weight_decay, 'face_net_path', '', ...
                 'eyeglass_tforms', eyeglass_tforms, 'alignment', alignment);
save('results/danh-physical-dodege-openface143.mat', 'result');
