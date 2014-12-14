<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>首页经典视频</title>
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
		
		<script type="text/javascript" language="javascript">
			KindEditor.ready(function(K) {

				//单个上传 dir：上传类型	---start
				var uploadbutton = K.uploadbutton({
					button : K('#uploadButton'),
					fieldName : 'imgFile',
					url : '../myFileUpload.do?p=<%=des.encrypt("2,1,7,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
					afterUpload : function(data) {
						if (data.error === 0) {
							K('#path').val(data.url);
						} else {
							alert(data.message);
						}
					},
					afterError : function(str) {
						alert('自定义提示信息: ' + str);
					}
				});
			
				uploadbutton.fileBox.change(function(e) {
					uploadbutton.submit();
				});
				//单个文件上传				---end
				
				//图片上传弹出框			---start
				var editor = K.editor({
					uploadJson : '../myFileUpload.do?p=<%=des.encrypt("0,1,4,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
					fileManagerJson : '../myKindEditorManager.do?p=<%=des.encrypt("0,1,4,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
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
				
			});
			
	    	$(function(){
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					param["title"] = $("#title").val();
					param["image"] = $("#image").val();
					param["path"] = $("#path").val();
					param["id"] = $("#id").val();
					$.shovePost("updateConfigVideo.do",param,function(data){
							if(data.msg == 1){
							 	alert("保存成功");
								window.location.href="updateConfigVideoInit.do";
								return;
							}
							alert(data.msg);
							even.show();
						});
						return false;
					});
			});
		</script>
		
	</head>
	<body>
		<form id="addUser" name="addUser" action="updateApp.do" method="post">
			<s:hidden name="paramMap.id" id="id"></s:hidden>
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#CC0000"
									class="white12">
									<a href="updateConfigVideoInit.do">首页经典视频</a>
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
									简介：
								</td>
								<td align="left" class="f66">
									<s:textarea id="title" name="paramMap.title" rows="5"  style="width: 380px; padding:5px;"
										cssClass="textareash" theme="simple"></s:textarea>
									<span class="require-field">*<s:fielderror fieldName="paramMap.title"></s:fielderror></span>
								</td>
							</tr>
							
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									上传视频：
								</td>
								<td align="left" class="f66">
									<input class="in_text_2" id="path" name="paramMap.var" value="${paramMap.var}"
										type="text" style="width: 350px; height: 20px;" />
									<input style="display: none;" id="uploadButton" value="浏览"
										type="button" />
									<input name="paramMap.size" id="size" type="hidden"/>
									<span class="require-field">*<s:fielderror
											fieldName="paramMap.path"></s:fielderror>
									</span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12" width="70px">
									<input id="image1" value="上传图片" type="button"/>
								</td>
								<td align="left" class="f66">
									<input type="hidden" id="image" name="paramMap.image" value="${paramMap.image}"/>
									 <span class="require-field">(最佳分辨率 319x278px)</span>
									 
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
								</td>
								<td align="left" class="f66">
									<img id="singImg" src='<s:if test="#request.paramMap.image!=null&&#request.paramMap.image!=''">../${paramMap.image }</s:if><s:else>../images/NoImg.GIF</s:else>' style="height: 100px;" />
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
