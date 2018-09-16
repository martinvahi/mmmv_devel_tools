#!/usr/bin/env bash 

cp -f ./bonnet/hello_HTML_world_template.html ./hello_HTML_world.html

echo ""
echo "The hello world before:"
echo ""
cat ./hello_HTML_world.html

../../src/renessaator -f ./hello_HTML_world.html

echo ""
echo "The hello world after:"
echo ""
cat ./hello_HTML_world.html

rm -f ./hello_HTML_world.html

