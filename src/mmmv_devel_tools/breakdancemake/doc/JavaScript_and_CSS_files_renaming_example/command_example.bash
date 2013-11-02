#!/bin/bash

RUBYOPT="-Ku" rake build
rm -f ./demo_data/x_v50.js
mv -f ./demo_data/demo_2_file_v50.css ./demo_data/demo_2_file_v77.css

