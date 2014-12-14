<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>在线支持</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />

		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		<script type="text/javascript" language="javascript">
	    	$(function(){
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					debugger;
					param["id"] = $("#id").val();
					param["var"] = editor_details.html();
					$.shovePost("updateConfig.do",param,function(data){
						if(data.flag==1){
						   even.show();
							alert("修改成功！");
							window.location.href = "updateConfigOnLineInit.do";
							return;							
						}
						alert(data.msg);
						even.show();
						
					});
					return false;
				});
			});
			
			var editor_details;
			KindEditor.ready(function(K) {
				editor_details = K.create('textarea[name="paramMap.var"]', {
					cssPath : '../kindeditor/plugins/code/prettify.css',
					uploadJson : 'kindEditorUpload.do',
					fileManagerJson : 'kindEditorManager.do',
					allowFileManager : true,
					formatUploadUrl : false
				 });
				});
		</script>
	</head>

	<body>
		<s:hidden name="paramMap.id" id="id" />
		<div id="right"
			style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
			<div style="padding: 15px 10px 0px 10px;">
				<div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100" height="28" align="center" bgcolor="#8594A9"
								class="white12">
								<a href="updateConfigOnLineInit.do">在线支持管理</a>
							</td>
							<td width="2" colspan="3">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<div style="border-top: #C00 2px solid;">
				</div>
				<div style="width: auto; background-color: #FFF; padding: 10px;">
					<table width="100%" border="0" cellspacing="1" cellpadding="3">
						<tr>
							<td style="height: 25px;" align="right" class="blue12">
								名称：
							</td>
							<td align="left" class="f66">
								<s:label name="paramMap.name" theme="simple"></s:label>
							</td>
						</tr>
						<tr>
							<td style="width: 100px; height: 25px;" align="right"
								class="blue12">
								内容：
							</td>
							<td align="left" class="f66">
								<textarea id="content" rows="20" name="paramMap.var"
									class="textareash" style="width: 700px; padding: 5px;">
										<s:property value="paramMap.var" />
									</textarea>
							</td>
						</tr>
						<tr>
							<td height="25">
							</td>
							<td align="left" class="f66" style="color: Red;">
								<s:fielderror fieldName="paramMap.allError" />
							</td>
						</tr>
						<tr>
							<td height="36" align="right" class="blue12">
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td height="36" align="right" class="blue12">
								&nbsp;
							</td>
							<td>
								<button id="btn_save"
									style="background-image: url('../images/admin/btn_queding.jpg'); width: 70px; border: 0; height: 26px"></button>
								&nbsp;
								<button type="reset"
									style="background-image: url('../images/admin/btn_chongtian.jpg'); width: 70px; height: 26px; border: 0px"></button>
								&nbsp; &nbsp;
								<span style="color: red;"> <s:fielderror
										fieldName="actionMsg" theme="simple"></s:fielderror> </span>
							</td>
						</tr>
					</table>
					<br />
				</div>
			</div>
		</div>
	</body>
</html>
