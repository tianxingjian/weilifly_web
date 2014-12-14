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
		<script type="text/javascript" language="javascript">
	    	$(function(){
	    		$("#attributeId").val("${paramMap.attributeId}");
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					param["paramMap.id"] = "${paramMap.id}";
					param["paramMap.attributeId"] = $("#attributeId").val();
					$.shovePost("updateMaterialsAttribute.do",param,function(data){
					if(data.msg==1){
					  	window.location.href="queryMaterialsAttributeList.do?id=${paramMap.materialsId}";
						return ;
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
		<form id="addUser" name="addUser" action="updateParameter.do" method="post">
			<s:hidden name="paramMap.id"></s:hidden>
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryMaterialsAttributeList.do?id=${paramMap.materialsId }">资料属性列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改资料属性
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
									资料名称：
								</td>
								<td align="left" class="f66">
									${paramMap.materialsName }
								</td>
							</tr>
							
							<s:iterator value="#request.attributeList.{?#this.parentId<0}" var="bean" status="st">
								<tr>
									<td style="width: 100px; height: 25px;" align="right"
										class="blue12">
										${bean.name}：
									</td>
									<td align="left" class="f66">
										<select name="attributeId" id="attributeId" >
											<option value="-1">
												--请选择--
											</option>
											<s:iterator value="#request.attributeList.{?#this.parentId>0&&#this.parentId==#bean.id}" var="beans" status="sts">
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
