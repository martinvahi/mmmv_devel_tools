#!/bin/bash
# The assumption is that the environment variable, 
# MMMV_DEVEL_TOOLS_HOME, is set properly. 

RUBYOPT="-Ku" rake run_demo
rm -f ./demo_data/kitty_1_plus_kitty_2.js

