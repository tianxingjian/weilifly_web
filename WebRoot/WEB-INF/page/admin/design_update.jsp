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
					var even = $(this);
					even.hide();
					param["paramMap.id"] = $("#id").val();
					param["paramMap.sortIndex"]=$("#sortIndex").val();
					param["paramMap.title"] = $("#title").val();
					param["paramMap.categoryId"] = $("#categoryId").val();
					param["paramMap.author"]=$("#author").val();
					param["paramMap.status"]=$("input[name=paramMap.status]:checked").val();
					$.shovePost("updateDesign.do",param,function(data){
						if(data.returnId==1){
						   even.show();
							alert("修改成功！");
							window.location.href = "queryDesignInit.do";
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
		<s:form id="updateDesign" action="updateDesign.do" method="post">
			<s:hidden name="paramMap.id" id="id" />
			<s:hidden name="paramMap.pageNow" />
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryDesignInit.do">设计素材列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改设计素材
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
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									标题：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.title" theme="simple" id="title"
										cssClass="in_text_2" cssStyle="width: 350px; height:23px;"></s:textfield>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.title" /> </span>
								</td>
							</tr>

							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									分类：
								</td>
								<td align="left" class="f66">
									<s:select name="paramMap.categoryId" id="categoryId"
										theme="simple" list="categoryList" listKey="id"
										listValue="name" headerKey="-1" headerValue="-请选择-">
									</s:select>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.categoryId" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									作者：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.author" theme="simple" id="author"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.author" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.status" id="status" theme="simple"
										list="#{1:'是',2:'否'}" />
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
