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
		<link type="text/css" rel="stylesheet" href="../common/Skins/GreyBlue/jbox.css"/>
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="../common/jquery.jBox-2.3.min.js"></script>
		<script type="text/javascript" src="../common/i18n/jquery.jBox-zh-CN.js"></script>
		
		<script type="text/javascript">
		KindEditor.ready(function(K) {
			//图片上传弹出框			---start
			var editor = K.editor({
				uploadJson : '../myFileUpload.do?p=<%=des.encrypt("0,1,4,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
				fileManagerJson : '../myKindEditorManager.do?p=<%=des.encrypt("0,1,4,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
				imageSizeLimit : "2MB",
				allowFileManager : true,
				imageUploadLimit : 20,
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
				var even = $(this);
				even.hide();
				param["id"] = $("#id").val();
				param["image"] = $("#image").val();
				param["productId"] = $("#productId").val();
				param["title"]=$("#title").val();
				$.shovePost("updateProductConfig.do",param,function(data){
					if(data.msg==1){
						window.location.href = "queryProductConfig.do";
						return;
						
					}
					alert(data.msg);
					even.show();
					
				});
				return false;
			});
		
			$("#bt_product").click(function(){
				$.jBox.open("iframe:queryProductRadioInit.do", "选择产品", 800, 520, { buttons: { '关闭': true} });
			});
			
		});
		
		function joxCallBack(productInfo){
			$.jBox.close(true);
			
			$("#productInfo").html(productInfo["name"]);
			$("#productId").val(productInfo["id"]);
			$("#productName").val(productInfo["name"]);
			
		}
		
		</script>
		
	</head>
	<body>
		<form id="updateProductConfig" name="updateProductConfig" action="updateProductConfig.do" method="post">
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="130" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryProductConfig.do">首页产品推荐</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改推荐
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
						<s:hidden name="paramMap.id" id="id"></s:hidden>
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr id="tr_product">
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									<input type="button" id="bt_product" value="关联产品..." />
								</td>
								<td align="left" class="f66">
									<s:hidden id="productId" name="paramMap.productId" />
									<s:hidden id="productName" name="paramMap.productName" />
									<span id="productInfo">
										<s:if test="#request.paramMap.productId!=null&&#request.paramMap.productId!=''&&#request.paramMap.productId>0" >${paramMap.productName}</s:if>
										<s:else>请点击关联产品。</s:else>
									</span>
									<span class="require-field">*<s:fielderror fieldName="paramMap.productInfo"></s:fielderror></span>
								</td>
							</tr>
							
								<tr>
									<td style="height: 25px;" align="right" class="blue12" width="70px">
										<input id="image1" value="产品图片" type="button"/>
									</td>
									<td align="left" class="f66">
										<s:hidden id="image" name="paramMap.productConfigImage"/>
										 <span class="require-field">*(最佳分辨率350x460px)
										 <s:fielderror fieldName="paramMap.productConfigImage"></s:fielderror></span>
									</td>
								</tr>
								<tr>
									<td style="height: 25px;" align="right" class="blue12">
									</td>
									<td align="left" class="f66">
										<img id="singImg" src="../${paramMap.productConfigImage }"
										style="width: 100px;" />
									</td>
								</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									简介：
								</td>
								<td align="left" class="f66">
									<s:textarea id="title" name="paramMap.title"
										rows="10" style="width: 570px; padding:5px;"
										cssClass="textareash" theme="simple"></s:textarea>
								</td>
							</tr>
							<tr>
								<td height="36" align="right" class="blue12">
									<s:hidden name="action"></s:hidden>
									&nbsp;
								</td>
								<td>
									<button id="btn_save" type="button"
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
