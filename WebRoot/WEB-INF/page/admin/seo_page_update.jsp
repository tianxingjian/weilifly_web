<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>SEO设置</title>
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
				//提交表单
				$("#btn_save").click(function(){
					$(this).hide();
					$("#updateSeoPage").submit();
					return false;
				});
			});
		</script>
  </head>
  
  <body>
    <s:form id="updateSeoPage" action="updateSeoPage.do" method="post">
			<s:hidden name="paramMap.id" />
			<s:hidden name="paramMap.pageNow" />
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="querySeoPageInit.do">SEO列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改SEO
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
									页面URL：
								</td>
								<td align="left" class="f66">
									<s:label name="paramMap.pageUrl" theme="simple"></s:label>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									Title：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.seoTitle" theme="simple"
										cssClass="in_text_2" cssStyle="width: 320px; height:23px;" />
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									KeyWord：
								</td>
								<td align="left" class="f66">
									<s:textarea id="seoKeyWord" name="paramMap.seoKeyWord" rows="5"  style="width: 400px; padding:5px;"
										cssClass="textareash" theme="simple"></s:textarea>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									Description：
								</td>
								<td align="left" class="f66">
									<s:textarea id="seoDescription" name="paramMap.seoDescription" rows="10"  style="width: 470px; padding:5px;"
										cssClass="textareash" theme="simple"></s:textarea>
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
					</div>
				</div>
			</div>
		</s:form>
  </body>
</html>
