import socket
import struct


def handle_client(client_socket):
    while True:
        data = client_socket.recv(1024)
        if not data:
            break
        # Unpack the received data (assuming double precision floats)
        received_vector = struct.unpack('d' * (len(data) // 8), data)
        print('Received from MATLAB:', received_vector)

        # Multiply the received vector by 2
        response_vector = [x * 2 for x in received_vector]

        # Pack the response vector and send it back
        response_data = struct.pack('d' * len(response_vector), *response_vector)
        client_socket.sendall(response_data)
    client_socket.close()


# Python server
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('127.0.0.1', 12345))
server.listen(5)
print('Python server started. Waiting for connection...')

try:
    while True:
        client_socket, addr = server.accept()
        print(f'Accepted connection from {addr}')
        handle_client(client_socket)
except KeyboardInterrupt:
    print('Shutting down server...')
finally:
    server.close()
    print('Server closed.')

