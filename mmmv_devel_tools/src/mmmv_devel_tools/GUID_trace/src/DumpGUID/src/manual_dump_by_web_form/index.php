<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN">
<html>
	<head>
		<title>DumpGUID web form based manual dumping utility</title>
		<style type="text/css">
			/*According to the Yahoo YUI framework creators,
		the margin and padding on body element
		can introduce errors in determining
		element position and are not recommended;
		we turn them off as a foundation for YUI
		CSS treatments. */
			body {
				margin:0;
				padding:0;
			}
		</style>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
	<body id="the_document_body" class="yui-skin-sam">
		<?php
		function mb_trim($str, $spc='\t\s') {
			$s_0=mb_ereg_replace("^[$spc]*", '',$str);
			$s_1=mb_ereg_replace("[$spc]*$", '',$s_0);
			return $s_1;
		} // mb_trim

		$s_dump='';
		if(array_key_exists('s_for_dumping', $_POST)===true) {
			$s_dump=$_POST['s_for_dumping'];
		} // if
		$s_env_name='MMMV_DEVEL_TOOLS_HOME';
		$s_env_mmmv_devel_tools_home=''.getenv($s_env_name);
		//-----------------------------------------------
		// A hack to conpensate the fact that the web server
		// runs as a different user and therefore does not
		// have the same environment variables set as the
		// developer has
		$s_env_mmmv_devel_tools_home=mb_trim(realpath('./../../../../../../../'));
		//--------------end-of-hack----------------------
		$i_len=mb_strlen($s_env_mmmv_devel_tools_home);
		$b_mmmv_devel_tools_defined=TRUE;
		$b_keep_form_content=FALSE;
		if($i_len<=2) {
			$b_mmmv_devel_tools_defined=FALSE;
			$b_keep_form_content=TRUE;
		} // if
		$b_ruby_available=TRUE;
		$s_0=exec('which ruby');
		$i_len=mb_strlen($s_0);
		if($i_len<=2) {
			$b_ruby_available=FALSE;
			$b_keep_form_content=TRUE;
		} // if
		?>
		<form action="action.php" id="the_form" method="post">
			<textarea name="s_for_dumping" id="s_for_dumping_id" rows="10" cols="75"><?php if($b_keep_form_content) {
					echo($s_dump);
				} ?></textarea>
			<input type="submit" value="Submit" />
		</form>

		<?php
		if($b_mmmv_devel_tools_defined===FALSE) {
			echo('Mandatory environment variable, '.$s_env_name.
				', has not been set.<br/>'.
				'Path of the file, where to dump the form content, '.
				'could not be determined.<br/>');
		} // if
		if($b_ruby_available===FALSE) {
			echo('<br/>This script depends on Ruby to '.
				'find out pat of the file, where to dump the '.
				'form content. <br/>'.
				'Currently ruby is missing from the path.<br/>');
		} // if
		if (($b_mmmv_devel_tools_defined===TRUE) && ($b_ruby_available===TRUE)) {
			$s_fp_core_rb=$s_env_mmmv_devel_tools_home.
				'/src/mmmv_devel_tools/GUID_trace/src'.
				'/JumpGUID/src/core/bonnet'.
				'/jumpguid_core.rb';
			$s_cmd='ruby '.$s_fp_core_rb.' ls guidstack_file_path ';
			$s_0=exec($s_cmd);
			$s_fp=mb_trim($s_0);
			echo 'The content of the above form '.
				'will be dumped to:<br/><br/>'.$s_fp;
			$fp=fopen($s_fp,'w');
			$s0=mb_ereg_replace('[\\\\]"', '"', $s_dump);
			$s1=mb_ereg_replace('[\\r]', '', $s0);
			fwrite($fp,$s1);
			fclose($fp);
		} // if
		flush();
		?>
		<br/><br/>
	</body>
</html>
