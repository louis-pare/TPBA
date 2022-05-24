#!/usr/bin/env python3
import os
def verify_output_directory(output_path):
    if not os.path.exists(output_path):
        os.makedirs(output_path)
    
    if output_path[-1] != "/":
        output_path = output_path + "/"
    
    return(output_path)