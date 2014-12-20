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
	    	$(function(){
				//提交表单
				$("#btn_save").click(function(){
					$(this).hide();
					$("#addModule").submit();
					return false;
				});	
			});
		</script>
  </head>
  
  <body>
    <form id="addModule" action="addModule.do" method="post">
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
									<a href="addModuleInit.do">添加模块</a>
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
									模块排序：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.indexs" theme="simple"
										cssClass="in_text_2" cssStyle="width: 200px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.indexs" /> </span>
								</td>
							</tr>
								<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									模块名称：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.summary" theme="simple"
										cssClass="in_text_2" cssStyle="width: 200px; height:23px;"></s:textfield>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.summary" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									所属模块：
								</td>
								<td align="left" class="f66">
									<s:select id="parentId" list="moduleList" name="paramMap.parentId" listKey="id" listValue="summary" 
										headerKey="" headerValue="--无--"></s:select>
									<span style="color: red;">*<s:fielderror fieldName="paramMap.parentId" /></span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
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
										list="#{1:'允许',2:'拦截'}" value="1"/>
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
										list="#{1:'启用',2:'禁用'}" value="1"/>
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
										list="#{1:'记录',2:'忽略'}" value="1"/>
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
