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
		<script type="text/javascript" language="javascript">
        function showsubmenu(sid) {
           var whichTabStr ="table" + sid;
           var whichElStr ="submenu" + sid;
			var tabObj=$("#"+whichTabStr);
            var elObj=$("#"+whichElStr);
            if(elObj.css("display") == "none") {
				tabObj.css("backgroundImage","url('../images/admin/left_qh_bg_1.jpg')");
				elObj.css("display","");
            }
            else {
				tabObj.css("backgroundImage","");
				elObj.css("display","none");
            }
        }
 			function loginOut(){
 				if(confirm("是否确定要退出？")){
 					window.parent.location="adminLoginOut.do";
 				}
 			}
    </script>

	</head>
	<body
		style="width: 100%; margin: 0px; padding: 0px; background-color: #DEE6EF; background-image: url(../images/admin/left_bg.jpg); background-position: left; background-repeat: repeat-y; padding: 0px 0px 0px 0px;">
		<form id="form1">
			<div id="left"
				style="background-image: url(../images/admin/left_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div
					style="background-image: url(../images/admin/left_top.jpg); width: 152px; height: 90px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="42" valign="bottom" width="35" align="center">
								<img src="../images/admin/icon_tx.gif" width="16" height="22" />
							</td>
							<td height="42" valign="bottom" class="black12">
								欢迎您：${sessionScope.admin.userName }
							</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="f66" height="30" style="padding-left: 8px;"
								width="50%">
								[
								<a target="main" href="updatePasswordInit.do">修改密码</a>]
							</td>
							<td class="f66" height="30" width="50%">
								[
								<a id="lbtnLogout" href="javascript:loginOut();">安全退出</a>]
							</td>
						</tr>
					</table>
				</div>
				<table width="152" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<s:iterator value="#session.adminRoleMenuList.{?#this.rightsId<0}" var="bean" status="sta">
							<table id="table${sta.index}" width="152" border="0" cellspacing="0"
								cellpadding="0">
								<tr style="cursor: pointer;" onclick="showsubmenu(${sta.index})">
									<td width="120" height="24" class="white12"
										style="padding-left: 10px;">
										${bean.summary }
									</td>
									<td width="32" align="left">
										<img src="../images/admin/sj_1.gif" width="9"
											height="5" border="0" />
									</td>
								</tr>
							</table>
							<div id="submenu${sta.index}"
								style="padding: 6px 0px 6px 0px; margin-bottom: 10px; background-image: url(../images/admin/left_qh_bg_2.jpg); display: none;">
								<s:iterator value="#session.adminRoleMenuList.{?#this.parentId==#bean.rightsId}" var="sBean">
								<table width="152" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="24" class="black12"
											style="padding: 0px 0px 0px 15px;">
											<span class="point">·</span>
											<s:if test="#sBean.rightsId==349"><a href="${sBean.action }" target="_blank">${sBean.summary }</a></s:if>
											<s:else><a href="${sBean.action }" target="main">${sBean.summary }</a></s:else>
											
										</td>
									</tr>
								</table>
								</s:iterator>
							</div>
							<table width="152" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td height="20" class="white12">
										<img src="../images/admin/left_line.jpg"
											width="152" height="6" />
									</td>
								</tr>
							</table>
					</s:iterator>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>
