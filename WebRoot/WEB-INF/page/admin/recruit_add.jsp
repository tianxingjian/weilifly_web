<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>管理首页</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet"
			type="text/css" />

		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>

		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>

		<script type="text/javascript">
			$(function(){
				//提交表单
				$("#btn_save").click(function(){
					$(this).hide();
					$("#content_hidden").val(editor_details.html());
					$("#addRecruit").submit();
					return false;
				});				
				
			});	
			
			
			var editor_details;
			KindEditor.ready(function(K) {
				editor_details = K.create('textarea[name="content"]', {
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
		<form id="addRecruit" action="addRecruit.do" method="post">
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryRecruitInit.do">人才招聘列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									<a href="addRecruitInit.do">添加人才招聘</a>
								</td>
								<td>
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
									排序：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.sort" theme="simple"
										cssClass="in_text_2" cssStyle="width: 250px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.sort" /> </span>
								</td>
							</tr>

							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									标题：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.name" theme="simple"
										cssClass="in_text_2" cssStyle="width: 350px; height:23px;"></s:textfield>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.name" /> </span>
								</td>
							</tr>

							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									类型：
								</td>
								<td align="left" class="f66">
									<s:select name="paramMap.type" id="type" theme="simple"
										list="recruitTypeList" listKey="id" listValue="title" headerKey="-1" headerValue="-请选择-">
									</s:select>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.type" /> </span>
								</td>
							</tr>


							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									内容：
								</td>
								<td align="left" class="f66">
									<textarea id="content" rows="20" name="content"
										class="textareash" style="width: 700px; padding: 5px;">
									</textarea>
									<s:hidden  id="content_hidden" name="paramMap.content" ></s:hidden>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.content" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.status" id="status" theme="simple"
										list="#{1:'是',2:'否'}" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.status" /> </span>
								</td>
							</tr>

							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									seoTitle：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.seoTitle" theme="simple"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.seoTitle" /> </span>
								</td>
							</tr>

							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									seoKeyWords：
								</td>
								<td align="left" class="f66">
									<s:textarea name="paramMap.seoKeywords" theme="simple"
										cssStyle="width: 450px; height:150px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.seoKeywords" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									seoDescription：
								</td>
								<td align="left" class="f66">
									<s:textarea name="paramMap.seoDescription" theme="simple"
										cssStyle="width: 450px; height:150px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.seoDescription" /> </span>
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
		</form>
	</body>
</html>
