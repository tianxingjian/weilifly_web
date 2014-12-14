<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>会员管理-添加会员</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		<script type="text/javascript" src="../common/jquery.jBox-2.3.min.js"></script>
		<script type="text/javascript" src="../common/i18n/jquery.jBox-zh-CN.js"></script>
		
		<script type="text/javascript">
			var editor_details;
			KindEditor.ready(function(K) {
				editor_details = K.create('textarea[id="introduction"]', {
					cssPath : '../kindeditor/plugins/code/prettify.css',
					uploadJson : 'kindEditorUpload.do',
					fileManagerJson : 'kindEditorManager.do',
					allowFileManager : true,
					formatUploadUrl : false
				});
				
				
				//图片上传弹出框			---start
				var editor = K.editor({
					uploadJson : '../myFileUpload.do?p=<%=des.encrypt("0,1,4,1,"
							+ ((Admin) session
									.getAttribute(IConstants.SESSION_ADMIN))
									.getId())%>',
					fileManagerJson : '../myKindEditorManager.do?p=<%=des.encrypt("0,1,4,1,"
							+ ((Admin) session
									.getAttribute(IConstants.SESSION_ADMIN))
									.getId())%>',
					imageSizeLimit : "2MB",
					allowFileManager : true,
					imageUploadLimit : 5,
					formatUploadUrl : false 
				});
				
				K('#image1').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : false,
							clickFn : function(url, title, width, height, border, align) {
								$("#image").val(url);
								$("#singImg").attr('src',"../"+url);
								editor.hideDialog();
							}
						});
					});
				});
				
				
				prettyPrint();
			});
			
			$(function(){
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					param["title"] = $("#title").val();
					param["sortIndex"] = $("#sortIndex").val();
					param["content"] = editor_details.html();
					param["fit"] = $("#fit").val();
					param["seoTitle"] = $("#seoTitle").val();
					param["seoKeywords"] = $("#seoKeywords").val();
					param["seoDescription"] = $("#seoDescription").val();
					param["status"] = $("input[name=paramMap.status]:checked").val();
					param["image"]=$("#image").val();
					$.shovePost("addDownloadHelp.do",param,function(data){
						alert(data.error);
						if(data.returnId>0){
							window.location.href = "queryDownloadHelpInit.do";
							return;
							
						}
						even.show();
						
					});
					return false;
				});
			});
		</script>
	</head>
	<body>
		<form id="addDemo" name="addDemo" action="addDemo.do" method="post">
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryDownloadHelpInit.do">下载帮助列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									<a href="addDownloadHelpInit.do">添加下载帮助</a>
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
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									标题：
								</td>
								<td align="left" class="f66">
									<s:textfield id="title" name="paramMap.title"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.title"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									排序：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.sortIndex" id="sortIndex"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.sortIndex"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									适用机型：
								</td>
								<td align="left" class="f66">
									<s:textfield id="fit" name="paramMap.fit"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.fit"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.status" id="status" theme="simple" value="1"
										list="#{1:'是',2:'否'}"/>
									<span class="require-field">*<s:fielderror fieldName="paramMap.status"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									网页标题：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.seoTitle" id="seoTitle"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.seoTitle"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									网页关键字：
								</td>
								<td align="left" class="f66">
									<s:textfield id="seoKeywords" name="paramMap.seoKeywords"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.seoKeywords"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									网页描述：
								</td>
								<td align="left" class="f66">
									<s:textarea id="seoDescription" name="paramMap.seoDescription" rows="10"  style="width: 470px; padding:5px;"
										cssClass="textareash" theme="simple"></s:textarea>
									<span class="require-field">*<s:fielderror fieldName="paramMap.seoDescription"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									内容：
								</td>
								<td align="left" class="f66">
									<textarea id="introduction" rows="20" class="textareash" style="width: 700px; padding:5px;"></textarea>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
								</td>
								<td align="left" class="f66">
									<span style="color: red;">*内容里面的图片宽度请控制在1000PX内</span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									图片：
								</td>
								<td align="left" class="f66">
									<!-- 图片 -->
									<s:if test="paramMap.image==null||paramMap.image==''">
										<img id="singImg" src="../images/admin/NoImg.GIF"
											style="width: 150px; height: 150px;" />
									</s:if>
									<s:else>
										<img id="singImg" style="width: 150px; height: 150px" />
									</s:else>
									<input id="image1" value="上传" type="button" />
									<span class="require-field"> <s:textfield type="text"
											class="in_text_25" style="width: 150px" readonly="true"
											id="image" />(最佳分辨率 470X470px) <s:fielderror
											fieldName="paramMap.image"></s:fielderror> </span>
								</td>
							</tr>
							<tr>
								<td height="36" align="right" class="blue12">
									<s:hidden name="action"></s:hidden>
									&nbsp;
								</td>
								<td>
									<button id="btn_save"
										style="background-image: url('../images/admin/btn_queding.jpg'); width: 70px; border: 0; height: 26px"></button>
									&nbsp;
									<button type="reset"
										style="background-image: url('../images/admin/btn_chongtian.jpg'); width: 70px; height: 26px; border: 0px"></button>
									&nbsp; &nbsp;
									<span class="require-field"><s:fielderror fieldName="actionMsg" theme="simple"></s:fielderror></span>
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
