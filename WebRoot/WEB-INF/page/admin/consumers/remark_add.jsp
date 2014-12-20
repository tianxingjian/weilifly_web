<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>潜在客户备注</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		
		<script type="text/javascript">
		$(function(){
			//提交表单
			$("#btn_save").click(function(){
				var even = $(this);
				even.hide();
				param["paramMap.id"] = "${paramMap.id}";
				param["paramMap.c_name"] = "${paramMap.c_name}";
				param["paramMap.c_telephone"] = "${paramMap.c_telephone}";
				param["paramMap.remark"] = $("#remark").val();
				param["paramMap.address"] = $("#address").val();
				$.shovePost("addRemark.do",param,function(data){
					alert(data.error);
					if(data.returnId>0){
						window.location.href = "queryConsumersInit.do";
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
		<form id="addRmark" name="addRmark" action="addRmark.do" method="post">
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
							<td width="100" height="28" align="center" bgcolor="#CC0000"
								class="white12">
								<a href="queryConsumersInit.do">潜在用户列表</a>
							</td>
							<td width="400">
								&nbsp;
							</td>
							<td width="400">
								&nbsp;
							</td>
						</tr>
						</table>
					</div>
					<div style="border-top: #C00 2px solid;">
					</div>
					<div style="width: auto; background-color: #FFF; padding: 10px;">
						<s:hidden name="paramMap.id"/>
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									姓名/公司名：
								</td>
								<td align="left" class="f66">
									<s:textfield id="cName" name="paramMap.c_name"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.cName"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									手机号：
								</td>
								<td align="left" class="f66">
									<s:textfield id="cTelephone" name="paramMap.c_telephone"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.cTelephone"></s:fielderror></span>
								</td>
							</tr>
							<tr >
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									地址：
								</td>
								<td align="left" class="f66">
									<s:textfield id="address" name="paramMap.address"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.address"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									备注：
								</td>
								<td align="left" class="f66">
									<s:textarea id="remark" name="paramMap.remark"
										cols="27" rows="4"  theme="simple"></s:textarea>
									<span class="require-field">*<s:fielderror fieldName="paramMap.remark"></s:fielderror></span>
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
