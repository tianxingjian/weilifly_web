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


		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		<script type="text/javascript" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>

		<script type="text/javascript" language="javascript">
		
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
								$("#imgUrl").val(url);
								$("#singImg").attr('src',"../"+url);
								editor.hideDialog();
							}
						});
					});
				});
				
			});
		
	
		
		
	    	$(function(){
	    	   changeCheck();
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					var infoId=$("#infoId").val();
					/*if(infoId==3){
						$("#hid_linkPath").val($("#imgLinkPath").val());
					}
					else{
						$("#hid_linkPath").val($("#txtLinkPath").val());
					}*/
					$("#content_hidden").val(editor_details.html());
					param["id"]=$("#id").val();
				    param["title"] = $("#title").val();
					param["infoId"]=infoId;
					param["sortIndex"] = $("#sortIndex").val();
					param["status"] = $("input[name=paramMap.status]:checked").val();
				    param["linkPath"] = $("#txtLinkPath").val();
					param["imgUrl"]=$("#imgUrl").val();
					param["content"] = $("#content_hidden").val();
					$.shovePost("updateInfoContent.do",param,function(data){
						alert(data.error);
						if(data.returnId>0){
							window.location.href = "queryInfoContentInit.do";
							return;							
						}
						even.show();						
					});
					return false;
				});				
			});
			
			
			function changeCheck(){
				var infoId=$("#infoId").val();
				if(infoId==2||infoId==4){
					$("#trContent").hide();
					$("#trImg").hide();
					$("#txtLinkPath").val("${paramMap.linkPath}");
				}else if(infoId==3){
					$("#trContent").hide();
					$("#trImg").show();
					$("#imgUrl").val("${paramMap.imgUrl}");
					$("#singImg").attr("src","../"+"${paramMap.imgUrl}") ;
					$("#txtLinkPath").val("${paramMap.linkPath}");
				}else{
					$("#trContent").show();
					$("#trImg").hide();
					$("#txtLinkPath").val("${paramMap.linkPath}");
				}
			}
			
			
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
		<s:form id="updateInfoContent" action="updateInfoContent.do"
			method="post">
			<s:hidden name="paramMap.id" id="id"/>
			<s:hidden name="paramMap.pageNow" />
			<s:hidden name="paramMap.linkPath" id="hid_linkPath"></s:hidden>
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryInfoContentInit.do">底部信息类型列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改底部信息类型
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
									<s:textfield name="paramMap.sortIndex" id="sortIndex"
										theme="simple" cssClass="in_text_2"
										cssStyle="width: 250px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.sortIndex" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									标题：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.title" id="title" theme="simple"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.title" /> </span>
								</td>
							</tr>

							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									类型：
								</td>
								<td align="left" class="f66">
									<s:select name="paramMap.infoId" id="infoId" theme="simple"
										onchange="changeCheck()" list="infoList" listKey="id"
										listValue="name" headerKey="-1" headerValue="-请选择-">
									</s:select>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.infoId" /> </span>
								</td>
							</tr>
							<tr id="trContent" style="display: none;">
								<td style="height: 25px;" align="right" class="blue12">
									内容：
								</td>
								<td align="left" class="f66">
									<textarea id="content" rows="20" name="content"
										class="textareash" style="width: 700px; padding: 5px;">
										<s:property value="paramMap.content" />
									</textarea>
									<s:hidden id="content_hidden" name="paramMap.content"></s:hidden>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.content" /> </span>
								</td>
							</tr>
							<tr id="trImg" style="display: none;">
								<td style="height: 25px;" align="right" class="blue12">
									图片：
								</td>
								<td align="left" class="f66">
									<!-- 图片 -->
									<s:if test="paramMap.imgUrl==null||paramMap.imgUrl==''">
										<img id="singImg" src="../images/admin/NoImg.GIF"
											style="width: 150px; height: 150px;" />
									</s:if>
									<s:else>
										<img id="singImg" style="width: 150px; height: 150px" src="../${paramMap.imgUrl }" />
									</s:else>
									<input id="image1" value="上传" type="button" />
									<span class="require-field"> <s:textfield type="text"
											class="in_text_25" style="width: 150px" readOnly="true"
											id="imgUrl" />(最佳分辨率 639X480px) <s:fielderror
											fieldName="paramMap.imgUrl"></s:fielderror> </span>
								</td>
							</tr>
							<tr id="trLink">
								<td style="height: 25px;" align="right" class="blue12">
									链接地址：
								</td>
								<td align="left" class="f66">
									<s:textfield id="txtLinkPath" theme="simple" name="paramMap.linkPath"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.linkPath" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									是否底部显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.status" id="status" theme="simple"
										list="#{1:'是',2:'否'}" value="1" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.status" /> </span>
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
		</s:form>
	</body>
</html>
