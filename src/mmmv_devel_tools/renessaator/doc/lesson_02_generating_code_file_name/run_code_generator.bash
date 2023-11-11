#!/usr/bin/env bash

S_FP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $S_FP_DIR

cp -f ./bonnet/demo_template.bash ./part_of_this_file_is_generated.bash
wait ; sync ; wait 
echo ""
echo "The file before:"
echo ""
cat ./bonnet/demo_template.bash

../../src/renessaator -f ./part_of_this_file_is_generated.bash
wait ; sync ; wait 

echo ""
echo "The file after running the code generator:"
echo ""
cat ./part_of_this_file_is_generated.bash
wait

rm -f ./part_of_this_file_is_generated.bash

