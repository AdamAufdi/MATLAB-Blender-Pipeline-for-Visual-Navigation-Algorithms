%% Blender Command Script
clear; clc; close all

%set up the socket server client (number must match Blender script)
t = tcpclient('localhost', 9998);

%define the pose vector(s) to send to Blender (one pose vector/row)
pose = [5.45, 0, 0, 90, 0, 90; ...
    5.45, 0, 0, 100, 10, 100];

%loop through vectors and send to Blender
for i = 1:size(pose, 1)

    %convert pose vector to character array, send to Blender
    poseStr = sprintf('%.6f,%.6f,%.6f,%.6f,%.6f,%.6f', pose(i, :));
    write(t, poseStr);

    %wait for response from Blender and print message to command window
    print_message(t)

end

%send command for Blender to shut-down socket server
write(t, 'terminate');
print_message(t)

%close the socket server
clear t;


function print_message(t)

while t.NumBytesAvailable == 0
    pause(0.1);
end
message = read(t);
fprintf(char(message))

end

% %picks up image and shows it
% keyboard;
% image_path = "C:\tmp\render_0.png";
% img = imread(image_path);
% imshow(img);