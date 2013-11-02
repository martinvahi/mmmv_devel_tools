#!/bin/bash

cp -f ./bonnet/hello_world_template.rb ./hello_world.rb

echo ""
echo "The hello world before:"
echo ""
cat ./hello_world.rb

../../src/renessaator -f ./hello_world.rb

echo ""
echo "The hello world after:"
echo ""
cat ./hello_world.rb

rm -f ./hello_world.rb

