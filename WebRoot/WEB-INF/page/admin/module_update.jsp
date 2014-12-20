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
					param["paramMap.summary"]=$("#summary").val();
					param["paramMap.action"] = $("#action").val();
					param["paramMap.parentId"] = $("#parentId").val();
					param["paramMap.description"] = $("#description").val();
					param["paramMap.indexs"]=$("#indexs").val();
					param["paramMap.isLog"]=$("input[name=paramMap.isLog]:checked").val();
					param["paramMap.isIntercept"]=$("input[name=paramMap.isIntercept]:checked").val();
					param["paramMap.isQuery"]=$("input[name=paramMap.isQuery]:checked").val();
					$.shovePost("updateModule.do",param,function(data){
						if(data.returnId>0){
						   	even.show();
							alert("修改成功！");
							window.location.href = "queryModuleInit.do";
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
	<s:form id="updateModule" action="updateModule.do" method="post">
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
									<a href="queryModuleInit.do">模块列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改模块
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
									模块编号：
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
								<td style="height: 25px;" align="right" class="blue12">
									排序：
								</td>
								<td align="left" class="f66">
									<s:textfield id="indexs" name="paramMap.indexs" theme="simple"
										cssClass="in_text_2" cssStyle="width: 150px" />
									<span style="color: red;"><s:fielderror
											fieldName="paramMap.indexs" />
									</span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									模块名称：
								</td>
								<td align="left" class="f66">
									<s:textfield id="summary" name="paramMap.summary" theme="simple"
										cssClass="in_text_2" cssStyle="width: 150px" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.summary" />
									</span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									所属模块：
								</td>
								<td align="left" class="f66">
									<s:select id="parentId" list="moduleList" name="paramMap.parentId" listKey="id" listValue="summary" 
										headerKey="-1" headerValue="--无--"></s:select>
									<span style="color: red;">*<s:fielderror fieldName="paramMap.parentId" /></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									模块描述：
								</td>
								<td align="left" class="f66">
									<s:textarea id="description" name="paramMap.description" rows="5"  style="width: 300px; padding:5px;"
										cssClass="textareash" theme="simple"></s:textarea>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.description" />
									</span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									权限分配：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.isIntercept" id="isIntercept" theme="simple"
										list="#{1:'允许',2:'拦截'}"/>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.isIntercept" />
									</span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									是否启用：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.isQuery" id="isQuery" theme="simple"
										list="#{1:'启用',2:'禁用'}"/>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.isQuery" />
									</span>
								</td>

							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									记录日志：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.isLog" id="isLog" theme="simple"
										list="#{1:'记录',2:'忽略'}"/>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.isLog" />
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
