% Define the vector to send
pose = [5.44, 0, 0, 90 + 10, 0 + 10, 90 + 10];

% Convert the vector to a string
poseStr = sprintf('%.5f,%.5f,%.5f,%.5f,%.5f,%.5f', pose);

% Set up the socket client
t = tcpclient('localhost', 9998);

% Send the vector to Blender
write(t, poseStr);

% Send the close command to Blender
keyboard
write(t, 'terminate')

% Close the connection
clear t;