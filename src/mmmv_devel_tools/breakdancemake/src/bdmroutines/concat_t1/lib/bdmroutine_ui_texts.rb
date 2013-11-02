#!/opt/ruby/bin/ruby -Ku
#==========================================================================
=begin

 Copyright 2012, martin.vahi@softf1.com that has an
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
BREAKDANCEMAKE_ROUTINE_CONCAT_T1_UI_TEXTS_INCLUDED=true
#==========================================================================

# For the i18n.
class Breakdancemake_bdmroutine_concat_t1_ui_texts
   def initialize(s_bdmcomponent_name)
      @s_bdmcomponent_name=s_bdmcomponent_name
   end #initialize

   #--------------------------------------------------------------------------

   def s_summary_for_identities(s_language)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\n"+
         "bdmfunktsioon \""+@s_bdmcomponent_name+"\" kopeerib seadistuses kirjeldatud \n"+
         "tekstifailiradade nimekirjas olevad failid nimekirjas ette antud järjekorras \n"+
         "seadistuses kirjeldatud rajaga ühtseks failiks ning, sõltuvalt \n"+
         "bdmfunktsioonile antud lisaargumendist, järeltöötleb selle ühtse faili.\n"+
         "\n"+
         "Järeltöötlusvaba kokkukopeerimine:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+" --plain \n"+
         "\n"+
         "Kokkukopeerimine järeltöödeldes Yahoo YUI Compressor'ga:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+" --yui_compressor_t1\n"+
         "\n"+
         "\n"
         #"Kokkukopeerimine järeltöödeldes Google Closure Compiler'iga \n"+
         #"ilma, et kasutataks optimeeringuid:\n"+
         #"\n"+
         #"        breakdancemake "+@s_bdmcomponent_name+" --google_closure_t1\n"+
         #"\n"+
         #"\n"
      else # probably s_language=="uk"
         s_out="\n"+
         "The bdmroutine \""+@s_bdmcomponent_name+"\" copies text files to a single file \n"+
         "and then, depending on the arguments given to it, postprocesses \n"+
         "the single file. The origin textfile paths and the destination textfile \n"+
         "path are determined by bdmroutine configuration.\n"+
         "\n"+
         "A command for assembling the single file and omitting all postprocessing:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+" --plain\n"+
         "\n"+
         "A command for assembling the single file and postprocessing:\n"+
         "it with the Yahoo YUI Compressor:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+" --yui_compressor_t1\n"+
         "\n"+
         "\n"
         #"A command for assembling the single file and postprocessing:\n"+
         #"it with the Google Closure Compiler:\n"+
         #"\n"+
         #"        breakdancemake "+@s_bdmcomponent_name+" --google_closure_t1\n"+
         #"\n"
      end # case s_language
      return s_out
   end # s_summary_for_identities

   #--------------------------------------------------------------------------

end # class Breakdancemake_bdmroutine_concat_t1_ui_texts
#==========================================================================

