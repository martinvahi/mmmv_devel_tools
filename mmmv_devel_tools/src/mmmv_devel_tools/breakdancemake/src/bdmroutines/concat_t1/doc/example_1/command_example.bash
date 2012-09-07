#!/bin/bash
# The assumption is that the ../../../breakdancemake is on the PATH .

breakdancemake concat_t1 --plain
#breakdancemake concat_t1 --yui_compressor_t1

rm -f ./demo_data/kitty_1_plus_kitty_2.js

