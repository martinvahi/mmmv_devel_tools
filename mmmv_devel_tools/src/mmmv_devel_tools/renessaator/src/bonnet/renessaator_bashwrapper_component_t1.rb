#!/usr/bin/env ruby
#==========================================================================

if !defined? RENESSAATOR_HOME
   x=ENV["RENESSAATOR_HOME"]
   if (x==nil)||(x=="")
      puts "\nThe environment variable, RENESSAATOR_HOME, \n"+
      "should have been defined in the bash script that calls this ruby file.\n"+
      "GUID=='27fb2610-bbc9-45bd-b4c1-d21301b13dd7'\n\n"
      exit
   end # if
   RENESSAATOR_HOME=x
end # if

require(RENESSAATOR_HOME+"/src/bonnet/renessaator.rb")

Renessaator_console_UI.new.run()

