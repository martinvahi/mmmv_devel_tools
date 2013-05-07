# Call Eclipse action
# dontparse
# @@name mmmv_devel_tools/hack_01_format_source
# @@shortcut ALT+o

require 'java'
java_import com.mbartl.scripteclipse.EclipseUtils

b_thrown=false
begin
    s_action_id="org.eclipse.jdt.ui.edit.text.java.format"
    EclipseUtils.callHandlerAction(s_action_id)
rescue Exception=>e
    b_thrown=true
end # try-catch

if b_thrown
    b_thrown=false
    s_action_id="org.eclipse.wst.sse.ui.format.document"
    EclipseUtils.callHandlerAction(s_action_id)
end # if



