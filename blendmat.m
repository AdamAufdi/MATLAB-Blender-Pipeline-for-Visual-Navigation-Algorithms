% Define the vector to send
vector = [5.45, 0, 0, 90, 0, 90];
% Convert the vector to a string
vectorStr = sprintf('%.5f,%.5f,%.5f,%.5f,%.5f,%.5f', vector);
% Set up the socket client
t = tcpclient('localhost', 9997);
% Send the vector to Blender
write(t, vectorStr);
% Close the connection
clear t;

%picks up image and shows it
keyboard;
image_path = "C:/Users/Adam/Documents/render.png";
img = imread(image_path);
imshow(img);