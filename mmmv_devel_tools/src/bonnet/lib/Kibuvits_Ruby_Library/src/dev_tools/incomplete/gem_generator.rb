#!/opt/ruby/bin/ruby -Ku
#==========================================================================
=begin
 Copyright 2010, martin.vahi@softf1.com that has an
 Estonian personal identification code of 38108050020.
 All rights reserved.

 Redistribution and use in source and binary forms, with or
 without modification, are permitted provided that the following
 conditions are met:

 * Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer
   in the documentation and/or other materials provided with the
   distribution.
 * Neither the name of the Martin Vahi nor the names of its
   contributors may be used to endorse or promote products derived
   from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=end
#==========================================================================
require 'pathname'
# The APPLICATION_STARTERRUBYFILE_PWD is not the
# same as the Dir.pwd. It's expaned in kibuvits_io.rb.
APPLICATION_STARTERRUBYFILE_PWD=Pathname.new($0).realpath.parent.to_s if not defined? APPLICATION_STARTERRUBYFILE_PWD
Dir.chdir(APPLICATION_STARTERRUBYFILE_PWD)
if !defined? KIBUVITS_HOME
   x=ENV['KIBUVITS_HOME']
   if x==nil or x==""
      x=Pathname.new(APPLICATION_STARTERRUBYFILE_PWD).realpath.parent.to_s
      puts "\nWarning: environment variable named KIBUVITS_HOME is \n"+
      "either unset or not defined.\n"
   end # if
   KIBUVITS_HOME=x # The x is due to IDE code browser
   ENV['KIBUVITS_HOME']=KIBUVITS_HOME   # for the kibuvits_all.rb
end # if
require 'find'
#require  KIBUVITS_HOME+"/include/kibuvits_boot.rb"
require  KIBUVITS_HOME+"/include/kibuvits_shell.rb"
sh(KIBUVITS_HOME+"/include/kibuvits_all.rb") # for the kibuvits_all.rb auto-update
#==========================================================================
s_gemspec=<<HEREDOC
SPEC = Gem::Specification.new do |s|
	s.name      = "kibuvits"
	s.version = KIBUVITS_s_NUMERICAL_VERSION # is replaced with a string after the heredoc declr.
	s.author    = "Martin Vahi (Estonian national identification number:38108050020)"
	s.email     = "martin.vahi@softf1.com"
	s.homepage = "http://kibuvits.rubyforge.org"
	s.rubyforge_project="kibuvits"
	s.platform = Gem::Platform::RUBY
	s.required_ruby_version = '>= 1.8.7'
	s.summary = "A mixture of components/utilities for "+
	  "writing Ruby applications. "+
	  "The Kibuvits Ruby Library is under the BSD license. "
	s.files= Dir.glob("kibuvits/src/{./,experimental/,bonnet/}*.rb")
	s.require_paths      << "kibuvits/src"
	s.require_paths      << "kibuvits/src/experimental"
	s.require_paths      << "kibuvits/src/include/incomplete"
	s.require_paths      << "kibuvits/src/bonnet"
	s.has_rdoc          = false
	s.add_dependency("monitor", ">= 0.1.3")
	s.add_dependency("termios", ">= 0.9.4") # UNIX specific
end
HEREDOC
s_gemspec.gsub!("KIBUVITS_s_NUMERICAL_VERSION","\""+KIBUVITS_s_NUMERICAL_VERSION+"\"")

require  KIBUVITS_HOME+"/include/kibuvits_io.rb"
require  KIBUVITS_HOME+"/include/kibuvits_shell.rb"
s_gem_folder=Pathname.new(KIBUVITS_HOME+"/../../").realpath.to_s
s_gemspec_path=s_gem_folder+"/kibuvits.gemspec"
str2file(s_gemspec,s_gemspec_path)
puts ""
puts sh("cd "+s_gem_folder+" ; gem uninstall kibuvits ;")['s_stdout']
puts ""
puts sh("cd "+s_gem_folder+" ; gem build "+ s_gemspec_path)['s_stdout']
puts "\nInstalling kibuvits GEM ...\n"
puts sh("cd "+s_gem_folder+
" ; gem install kibuvits-"+KIBUVITS_s_NUMERICAL_VERSION+".gem ;")['s_stdout']
puts ""
File.delete(s_gemspec_path) if File.exists? s_gemspec_path
