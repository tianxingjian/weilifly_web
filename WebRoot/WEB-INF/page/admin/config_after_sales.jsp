<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
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
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		<script type="text/javascript" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script type="text/javascript">
			KindEditor.ready(function(K) {
			
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
				
			});
			$(function(){
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					debugger;
					param["id"] = $("#id").val();
					param["name"]=$("#qq").val();
					param["var"] = $("#image").val();
					param["title"]=$("#title").val();
					$.shovePost("updateAfterSalesConsulting.do",param,function(data){
						if(data.flag==1){
						   even.show();
							alert("修改成功！")
							window.location.href = "updateAfterSalesConsultingInit.do";
							return;							
						}
						alert(data.msg);
						even.show();
						
					});
					return false;
				});				
				
			});	
				//图片上传
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
								<a href="updateAfterSalesConsultingInit.do">服务在线客服1管理</a>
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
								标题：
							</td>
							<td align="left" class="f66">
								<s:textfield name="paramMap.title" theme="simple" id="title"
									cssClass="in_text_2" cssStyle="width: 350px; height:23px;">
								</s:textfield>
								<span style="color: red;">*<s:fielderror
										fieldName="paramMap.title" /> </span>
							</td>
						</tr>
						<tr>
							<td style="height: 25px;" align="right" class="blue12">
								QQ：
							</td>
							<td align="left" class="f66">
								<s:textfield name="paramMap.name" theme="simple" id="qq"
									cssClass="in_text_2" cssStyle="width: 350px; height:23px;">
								</s:textfield>
								<span style="color: red;">*<s:fielderror
										fieldName="paramMap.name" /> </span>
							</td>
						</tr>
						<tr>

							<td style="width: 100px; height: 25px;" align="right"
								class="blue12">
								图片：
							</td>
							<td align="left" class="f66">
								<!-- 图片 -->
								<s:if test="paramMap.var==null||paramMap.var==''">
									<img id="singImg" src="../images/admin/NoImg.GIF"
										style="width: 150px; height: 150px;" />
								</s:if>
								<s:else>
									<img id="singImg" style="width: 150px; height: 150px"
										src="../${paramMap.var }" />
								</s:else>
								<input id="image1" value="上传" type="button" />
								<span class="require-field"> <s:textfield type="text"
										class="in_text_25" style="width: 150px" disabled="disabled"
										id="image" name="paramMap.var" />(最佳分辨率 87X87px) <s:fielderror
										fieldName="paramMap.var"></s:fielderror> </span>
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
