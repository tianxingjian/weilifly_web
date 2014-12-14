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
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		<script type="text/javascript">
			var editor_details;
			var editor_content;
			KindEditor.ready(function(K) {
				editor_details = K.create('textarea[id="details"]', {
					cssPath : '../kindeditor/plugins/code/prettify.css',
					uploadJson : 'kindEditorUpload.do',
					fileManagerJson : 'kindEditorManager.do',
					allowFileManager : true,
					formatUploadUrl : false
				});
				
				prettyPrint();
				
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
				$("#btn_save").click(function(){
					param["id"] = $("#id").val();
					param["name"] = $("#name").val();
					param["categoryId"] = $("#categoryId").val();
					param["status"] = $("input[name=paramMap.status]:checked").val();
					param["url"] = $("#url").val();
					param["wapUrl"] = $("#wapUrl").val();
					param["seoTitle"] = $("#seoTitle").val();
					param["seoKeywords"] = $("#seoKeywords").val();
					param["seoDescription"] = $("#seoDescription").val();
					param["image"] = $("#image").val();
					param["sortIndex"] = $("#sortIndex").val();
					param["isShow"]=$("input[name=paramMap.isShow]:checked").val();
					//param["content"] = $("#content").val();
					param["details"] = editor_details.html();
					$.shovePost("updateProduct.do",param,function(data){
						alert(data.error);
						if(data.returnId>0){
							window.location.href = "queryProductInit.do";
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
		<form id="addDemo" name="addDemo" action="addProduct.do" method="post">
			<s:hidden id="id" name="paramMap.id"></s:hidden>
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryProductInit.do">产品列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改产品
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
									型号：
								</td>
								<td align="left" class="f66">
									<s:textfield id="name" name="paramMap.name"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.name"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									系列：
								</td>
								<td align="left" class="f66">
									<s:select id="categoryId" theme="simple" name="paramMap.categoryId"
											list="categoryList" listKey="id" listValue="name" headerKey="-1" headerValue="-请选择-">
									</s:select>
									<span class="require-field">*<s:fielderror fieldName="paramMap.categoryId"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									排序：
								</td>
								<td align="left" class="f66">
									<s:textfield id="sortIndex" name="paramMap.sortIndex"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.sortIndex"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.status" id="status" theme="simple"
										list="#{1:'是',2:'否'}"/>
									<span class="require-field">*<s:fielderror fieldName="paramMap.status"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									是否显示购买和对比按钮：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.isShow" id="isShow" theme="simple"	list="#{1:'是',2:'否'}" />
									<span class="require-field">*<s:fielderror fieldName="paramMap.isShow"></s:fielderror></span>
								</td>
							</tr>
							
							<!--<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									简介：
								</td>
								<td align="left" class="f66">
									<s:textarea id="content" name="paramMap.content" rows="5"  style="width: 470px; padding:5px;"
										cssClass="textareash" theme="simple"></s:textarea>
									<span class="require-field">*<s:fielderror fieldName="paramMap.seoDescription"></s:fielderror></span>
								</td>
							</tr>-->
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
									购买链接：
								</td>
								<td align="left" class="f66">
									<s:textfield id="url" name="paramMap.url"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.url"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									手机购买链接：
								</td>
								<td align="left" class="f66">
									<s:textfield id="wapUrl" name="paramMap.wapUrl"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.wapUrl"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12" width="70px">
									<input id="image1" value="型号图片" type="button"/>
								</td>
								<td align="left" class="f66">
									<input type="hidden" id="image" name="paramMap.image" value="${paramMap.image}"/>
									 <span class="require-field">(最佳分辨率 248x223px)</span>
									 
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
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									详细介绍：
								</td>
								<td align="left" class="f66">
									<textarea id="details" rows="20" class="textareash" style="width: 700px; padding:5px;">${paramMap.details}</textarea>
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
