run init.m

%% digital dodging vs. VGG143

% parameters
n_epochs = 4;
stop_prob = 0.01;
kappa = 0.25;
lr = 5e-5;
weight_decay = 1e-5;

% cpu/gpu?
platform = 'cpu';
if gpuDeviceCount>0
    platform = 'gpu';
end

% model and attacker images
face_net_path = 'models/vgg143-recognition-nn.mat';
im_filepath = {'data/test/aligned_vgg_kurtis1.jpg'};

% attacker's class
target = 19;

% run attack
[gen, discrim, objective] = agn('kappa', kappa, ...
                                'lr_gen', lr, ...
                                'weight_decay', weight_decay, ...
                                'attack', 'dodge', ...
                                'targets', target, ...
                                'stop_prob', stop_prob, ...
                                'face_im_paths', im_filepath, ...
                                'n_epochs', n_epochs, ...
                                'platform', platform, ...
                                'face_net_path', face_net_path ...
                                );

% store results
result = struct('gen', gen, 'discrim', discrim, 'objective', objective, ...
                'target', target, 'im_path', im_filepath,  ...
                'attack_type', 'dodge', 'stop_prob', stop_prob, ... 
                'lr', lr, 'kappa', kappa, 'face_net_path', face_net_path, ...
                'weight_decay', weight_decay);
save('results/adams-digital-dodge-vgg143.mat', 'result');