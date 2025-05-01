import socket
import cv2 as cv
from matplotlib import pyplot as plt

#set up the socket server for Python-Blender connection
blender_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
blender_socket.bind(('localhost', 9998))
blender_socket.listen(1)
print("Waiting for connection...")
conn_Blender, addr_Blender = blender_socket.accept()
print(f"Connected to Blender by {addr_Blender}")

#set up the socket server for Python-MATLAB connection
matlab_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
matlab_socket.bind(('localhost', 9997))
matlab_socket.listen(1)
print("Waiting for connection...")
conn_MATLAB, addr_MATLAB = matlab_socket.accept()
print(f"Connected to MATLAB by {addr_MATLAB}")

#wait for Blender to provide file location of a rendered image
try:
    while True:
        message = blender_socket.recv(1024)
        if message:
            print("Received image location from Blender")
            img = cv.imread(message, cv.IMREAD_GRAYSCALE)
            orb = cv.ORB_create()
            kp = orb.detect(img, None)
            kp, des = orb.compute(img, kp)
            img2 = cv.drawKeypoints(img, kp, None, color=(0, 255, 0), flags=0)
            plt.imshow(img2), plt.show()
        else:
            print("Connection closed by the server.")
            break
finally:
    blender_socket.close()




