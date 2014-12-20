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
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		
		<script type="text/javascript" language="javascript">
			$(function(){
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					param["paramMap.id"] = $("#id").val();
					param["paramMap.name"]=$("#name").val();
					param["paramMap.orderName"] = $("#orderName").val();
					param["paramMap.parentId"] = $("#parentId").val();
					param["paramMap.url"] = $("#url").val();
					param["paramMap.sortIndex"]=$("#sortIndex").val();
					param["paramMap.enable"]=$("input[name=paramMap.enable]:checked").val();
					$.shovePost("updateNavigationBar.do",param,function(data){
						if(data.returnId>0){
						   	even.show();
							alert("修改成功！");
							window.location.href = "queryNavigationBarInit.do";
							return;							
						}
						alert(data.error);
						even.show();						
					});
					return false;
				});				
			});
		</script>
	</head>
	<body>
	<s:form id="updateNavigationBar" action="updateNavigationBar.do" method="post">
	<s:hidden name="paramMap.id" id="id"/>
	<s:hidden name="paramMap.pageNow" />
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryNavigationBarInit.do">Menu列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改Menu
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
									菜单项编号：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.id" theme="simple" readonly="true"
										cssClass="in_text_2" cssStyle="width: 150px" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.id" />
									</span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									菜单项名称：
								</td>
								<td align="left" class="f66">
									<s:textfield id="name" name="paramMap.name" theme="simple"
										cssClass="in_text_2" cssStyle="width: 150px" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.name" />
									</span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									菜单等级：
								</td>
								<%-- <td align="left" class="f66">
									<s:textfield id="orderName" name="paramMap.orderName" theme="simple"
										cssClass="in_text_2" cssStyle="width: 150px" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.orderName" />
									</span>
								</td> --%>
								<td align="left" class="f66">
									<s:select name="paramMap.orderName" id="orderName" theme="simple"
										list="#{'':'-请选择-','一级':'一级','二级':'二级'}" >
									</s:select>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.orderName" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									所属菜单项：
								</td>
								<td align="left" class="f66">
									<s:select id="parentId" list="orderList" name="paramMap.parentId" listKey="id" listValue="name" 
										headerKey="-1" headerValue="--无--"></s:select>
									<span style="color: red;">*<s:fielderror fieldName="paramMap.parentId" /></span>
								</td>
								
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									页面url：
								</td>
								<td align="left" class="f66">
									<s:textfield id="url" name="paramMap.url" theme="simple"
										cssClass="in_text_2" cssStyle="width: 150px" />
									<span style="color: red;"><s:fielderror
											fieldName="paramMap.url" />
									</span>
								</td>
								
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									排序：
								</td>
								<td align="left" class="f66">
									<s:textfield id="sortIndex" name="paramMap.sortIndex" theme="simple"
										cssClass="in_text_2" cssStyle="width: 150px" />
									<span style="color: red;"><s:fielderror
											fieldName="paramMap.sortIndex" />
									</span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.enable" id="enable" theme="simple"
										list="#{1:'显示',2:'隐藏'}" value="1"/>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.enable" />
									</span>
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
                                <button id="btn_save" style="background-image: url('../images/admin/btn_queding.jpg');width: 70px;border: 0;height: 26px"  ></button>
                                &nbsp;<button type="reset" style="background-image: url('../images/admin/btn_chongtian.jpg');width: 70px;height: 26px;border: 0px"></button>&nbsp;
                                &nbsp;
                                <span style="color: red;">
                             	  <s:fielderror fieldName="actionMsg" theme="simple"></s:fielderror>
                                </span>
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
