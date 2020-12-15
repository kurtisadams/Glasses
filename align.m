% The program to align a phot based on photo location'
addpath('dependencies/image-registration/');


face_landmark_detection('%Folder path goes here', '%File name goes here');
align_vgg_pose('% Exp: data/Danh/', '% Exp: 5.jpg', ...
               'data/auxiliary/canonical_pose_marks.csv');
