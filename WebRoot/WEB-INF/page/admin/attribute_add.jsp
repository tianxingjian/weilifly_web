<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		<script type="text/javascript" language="javascript">
	    	$(function(){
	    		$("#parentId").val("${request.parentId }");
				//提交表单
				$("#btn_save").click(function(){
					$(this).hide();
					var productIds = [];
					$("input[name=productIds]:checked").each(function(){
						productIds.push($(this).val() );
					});
					$("#productIds").val(productIds.join(","));
					$("#addAdmin").submit();
					return false;
				});
				
			});
		</script>

	</head>
	<body>
		<form id="addAdmin" action="addAttribute.do" method="post">
			<s:hidden id="parentId" name="paramMap.parentId" />
			<s:hidden id="productIds" name="paramMap.productIds" />
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryAttributeInit.do">模块管理</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<s:if test="#request.parentId==-1">
									<td width="100" align="center" bgcolor="#CC0000"
										class="white12">
										添加模块
									</td>
									<td>
										&nbsp;
									</td>
								</s:if>
								<s:else>
									<td width="100" align="center" bgcolor="#8594A9"
										class="white12">
										<a href="queryAttributeSonInit.do?parentId=${request.parentId }">属性管理</a>
									</td>
									<td width="2">
										&nbsp;
									</td>
									<td width="100" align="center" bgcolor="#CC0000"
										class="white12">
										添加属性
									</td>
									<td>
										&nbsp;
									</td>
								</s:else>
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
									<s:if test="#request.parentId==-1">
										模块：
									</s:if>
									<s:else>
										属性：
									</s:else>
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.name" id="name"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.name" /> </span>
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
							<s:if test="#request.parentId==4">
								<tr>
									<td style="width: 100px; height: 25px;" align="right"
										class="blue12">
										关联产品：
									</td>
									<td align="left" class="f66">
										<s:iterator value="productList" var="bean">
											<input type="checkbox" name="productIds" value="${bean.id }" />${bean.name }&nbsp;&nbsp;
										</s:iterator>
										<!--<s:select id="productId" theme="simple" name="paramMap.productId"
												list="productList" listKey="id" listValue="name" headerKey="-1" headerValue="-请选择-">
										</s:select>-->
										<span class="require-field">*<s:fielderror fieldName="paramMap.productIds"></s:fielderror></span>
									</td>
								</tr>
							</s:if>
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
