% The file for aligning an image  based on location'
addpath('dependencies/image-registration/');
face_landmark_detection('data/demo-data1/', 'brad_pitt.jpg');
align_vgg_pose('data/demo-data1/', 'brad_pitt.jpg', ...
               'data/auxiliary/canonical_pose_marks.csv');
