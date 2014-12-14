<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>批量添加资料 </title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<script type="text/javascript">
			KindEditor.ready(function(K) {
			
				//单个上传 dir：上传类型	---start
				var uploadbutton = K.uploadbutton({
					button : K('#uploadButton'),
					fieldName : 'imgFile',
					url : '../myFileUpload.do?p=<%=des.encrypt("3,1,7,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
					afterUpload : function(data) {
						if (data.error === 0) {
							K('#path').val(data.url);
							$("#size").val(Number(data.fileSize/(1024*1024)).toFixed(2)+"M");
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
				
			});
			
			$(function(){
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					var _array = [];
					$(".attributeId").each(function(){
						var attributeId = $(this).val();
						_array.push(attributeId);
					});
					var productIds = [];
					$("input[name=productIds]:checked").each(function(){
						productIds.push($(this).val() );
					});
					param["paramMap.number"] = $("#number").val();
					param["paramMap.name"] = $("#name").val();
					param["paramMap.productIds"] = productIds.join(",");
					param["paramMap.paramMap.seoTitle"] = $("#seoTitle").val();
					param["paramMap.seoKeywords"] = $("#seoKeywords").val();
					param["paramMap.seoDescription"] = $("#seoDescription").val();
					param["paramMap.path"] = $("#path").val();
					param["paramMap.size"] = $("#size").val();
					param["paramMap.attributeIds"] = _array.join(",");
					param["paramMap.status"] = $("input[name=paramMap.status]:checked").val();
					$.shovePost("importProductBatch.do",param,function(data){
						if(data.flag==1||data.flag=="1"){
						    alert(data.msg);
							window.location.href = "queryMaterialsInit.do";
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
		<form id="addUser" name="addUser" action="addParameter.do" method="post">
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryMaterialsInit.do">资料列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									<a href="importProductBatchInit.do">批量添加资料</a>
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
									条形码：
								</td>
								<td align="left" class="f66">
									<s:textfield id="number" name="paramMap.number"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.number"></s:fielderror></span>
								</td>
							</tr>
							<!--  <tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									名称：
								</td>
								<td align="left" class="f66">
									<s:textfield id="name" name="paramMap.name"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.name"></s:fielderror></span>
								</td>
							</tr>-->
							
							<!--<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									所属产品：
								</td>
								<td align="left" class="f66">
									<s:iterator value="productList" var="bean">
										<input type="checkbox" name="productIds" value="${bean.id }" />${bean.name }&nbsp;&nbsp;
									</s:iterator>
									<s:select id="productId" theme="simple" name="paramMap.productId"
											list="productList" listKey="id" listValue="name" headerKey="-1" headerValue="-请选择-">
									</s:select>
									<span class="require-field">*<s:fielderror fieldName="paramMap.productId"></s:fielderror></span>
								</td>
							</tr>-->
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
									上传资料：
								</td>
								<td align="left" class="f66">
									<input class="in_text_2" id="path"  name="paramMap.path"
										type="text" style="width: 350px; height: 20px;" />
									<input style="display: none;" id="uploadButton" value="浏览"
										type="button" />
									<!--<input name="paramMap.size" id="size" type="hidden"/>-->
									<span class="require-field">*请用execl文件上传<s:fielderror
											fieldName="paramMap.path"></s:fielderror>
									</span>
								</td>
							</tr>
							<!--<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									大小：
								</td>
								<td align="left" class="f66">
									<s:textfield id="size" 
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror
											fieldName="paramMap.path"></s:fielderror>
									</span>
								</td>
							</tr>-->
							<s:iterator value="attributeList.{?#this.parentId<0}" var="bean" status="st">
								<tr>
									<td style="width: 100px; height: 25px;" align="right"
										class="blue12">
										${bean.name}：
									</td>
									<td align="left" class="f66">
										<select name="attributeId" class="attributeId" >
											<option value="-1">
												--请选择--
											</option>
											<s:iterator value="attributeList.{?#this.parentId>0&&#this.parentId==#bean.id}" var="beans" status="sts">
												<option value="${beans.id}">
													${beans.name}
												</option>
											</s:iterator>
										</select>
									</td>
								</tr>
							</s:iterator>
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
