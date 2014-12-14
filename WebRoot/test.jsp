<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
	<script type="text/javascript" src="script/jquery-1.8.0.min.js"></script>
	<head>
		<title>中控科技</title>
		<script type="text/javascript">
			$(function(){
				var iframe = $("iframe[name=kindeditor_upload_iframe_1390202222367]");
				iframe.bind('load', function() {
					var str = $.trim(this.contentWindow.document.body.innerHTML);
					if(str){
						var jsn = eval('(' + str + ')');
						if(jsn.error != 0){
							alert(jsn.message);
							return;
						}
						
						$("#uploadEdImage").attr("src",jsn.url);
					}
				});
				
				$("#uploadImg").click(function(){
					$("#selectFile").click();
				});
				
				$("#selectFile").change(function(){
					$("#uploadForm").submit();
				});
			});
		</script>
	</head>
	<body>
		<iframe name="kindeditor_upload_iframe_1390202222367" style="display: none;"><html><head></head><body></body></html>
		</iframe>
		<form method="post" enctype="multipart/form-data"
			target="kindeditor_upload_iframe_1390202222367"
			action="myFileUpload.do?p=d8c1fb2d592f4fef46781b93ae41c277"
			style="position: relative;overflow: hidden;margin: 0;padding: 0;"
			id="uploadForm"
			>
			<input type="file" name="imgFile" id="selectFile" style="display: block;width: 0px;height: 0px;" >
			<img src="images/pic55.jpg" alt="" id="uploadImg" >
		</form>
		
		<img id="uploadEdImage" src="#" />

	</body>
</html>