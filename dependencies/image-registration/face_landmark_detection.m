function face_landmark_detection(folder_path, wildcard)

    python = '/usr/bin/python3.8'; % Full path to the python executable
    dlib = '/home/cyber-computer-003-admin/Documents/agns-master/dependencies/shape_predictor_68_face_landmarks.dat'; % Full path to dlib's 'shape_predictor_68_face_landmarks.dat'
    command_str = [python ' ' ...
                   fullfile(pwd, 'dependencies/image-registration/face_landmark_detection.py ') ...
                   dlib ' '...
                   '%s "%s"'];
    command_str = sprintf(command_str, folder_path, wildcard);
    system(command_str);

end