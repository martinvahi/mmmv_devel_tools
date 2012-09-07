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


		<form action="action.php" id="the_form" method="post">
			<textarea name="s_for_dumping" id="s_for_dumping_id" rows="10" cols="75"></textarea>
			<input type="submit" value="Submit" />
		</form>

		<?php
// The receiving end...
		$s_wildfile_path='/home/zornilemma/tmp/wild.txt';

		echo 'The content of the above form will be dumped to:<br/>'.
				$s_wildfile_path;

		$s_dump=$_POST['s_for_dumping'];
		if($s_dump!=NULL) {
			$fp=fopen($s_wildfile_path,'w');
			$s0=mb_ereg_replace('[\\\\]"', '"', $s_dump);
			$s1=mb_ereg_replace('[\\r]', '', $s0);
			fwrite($fp,$s1);
			fclose($fp);
		} // if

		?>
		<br/><br/>

	</body>
</html>
