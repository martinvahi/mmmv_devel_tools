# Call Eclipse action
# @@dontparse
# @@name hack_01_format_source
# @@shortcut ALT+o

require 'java'
java_import com.mbartl.scripteclipse.EclipseUtils

s_action_id="org.eclipse.jdt.ui.edit.text.java.format"
EclipseUtils.callHandlerAction(s_action_id)


