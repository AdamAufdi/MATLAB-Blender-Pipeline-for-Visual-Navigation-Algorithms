# blender_sim_pipeline

This respository contains all files necessary to operate the MATLAB-Python-Blender pipeline for simulating an environment in Blender and returning image features to MATLAB. 

To test MATLAB-Python communication, open the matlab_python_interface_test scripts (one is a Python script (.py) and the other a MATLAB script (.m)). Once both are open, run the MATLAB script first. Then, run the Python script. MATLAB will send some random vectors over to Python, Python will do an operation on them and send them back. You can verify this from the MATLAB command window, which should show the vectors transmitted and the vectors received. 
