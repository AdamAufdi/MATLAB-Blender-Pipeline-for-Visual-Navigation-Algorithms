%% MATLAB-Python Interface Test
%By Tim Goulet
clear; clc; close all

% MATLAB as a client to send and receive data
client = tcpclient('127.0.0.1', 12345);
disp('Connected to Python server.');

% Example loop for multiple exchanges
for i = 1:5
    % Example vector to send
    vectorToSend = [i, i+1, i+2, i+3, i+4];
    write(client, vectorToSend, 'double');
    disp(['Sent to Python: ', mat2str(vectorToSend)]);
    
    % Wait for response from Python
    while true
        if client.NumBytesAvailable > 0
            receivedData = read(client, client.NumBytesAvailable / 8, 'double');
            disp('Received from Python:');
            disp(receivedData);
            break;
        end
        pause(0.1); % Small pause to prevent busy-waiting
    end
    
    % Quick operation in MATLAB (example: add 1 to each element)
    vectorToSend = receivedData + 1;
    write(client, vectorToSend, 'double');
    disp(['Sent to Python: ', mat2str(vectorToSend)]);
end

% Close the connection
clear client;
disp('Connection closed.');



