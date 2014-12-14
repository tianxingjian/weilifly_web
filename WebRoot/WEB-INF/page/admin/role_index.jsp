<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<html>
	<head>
		<title>角色管理</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript">
			function deleteRole(id){
				if(!window.confirm("确定删除?")){
		 			return;
		 		}
				window.location.href='deleteRole.do?id='+id;
			}
		</script>
	</head>
	<body>
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#CC0000"
									class="white12">
									<a href="queryRoleList.do">角色管理</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="130" align="center" bgcolor="#8594A9" class="white12">
									<a href="addRoleInit.do">添加角色权限</a>
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
						</table>
					</div>
					<div style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; width: 100%; padding-top: 10px; background-color: #fff;">
						<div>
							<table id="gvNews" style="width: 100%; color: #333333;"
								cellspacing="1" cellpadding="3" bgcolor="#dee7ef" border="0">
									<tr class=gvHeader>
										<th scope="col" style="width: 70px;">
											序号
										</th>
										<th scope="col" style="width: 150px;">
											角色名称
										</th>
										<th scope="col">
											角色描述
										</th>
										<th style="width: 70px;" scope="col">
											操作
										</th>
									</tr>
										<s:if test="#request.roleList.size > 0">
											<s:iterator value="#request.roleList" var="bean" status="sta">
												<tr class="gvItem">
													<td>
														${sta.count}
													</td>
													<td>
														${name}
													</td>
													<td>
														${description}
													</td>
													<td>
													<s:if test="#bean.id == -1">
													</s:if>
													<s:else>
														<a id="gvNews_ctl05_lbEdit"
															href="updateRoleInit.do?id=${id}">编辑</a>
														<a id="gvNews_ctl05_lbDelete" href="javascript:deleteRole(${bean.id })">删除</a>
													</s:else>
													</td>
												</tr>
											</s:iterator>		
										</s:if>
								<s:else>
									<tr><td class="gvItem" style="text-align: center;background-color: #f7f7f7;" colspan="4">暂无数据</td></tr>
								</s:else>
							 </table>
						</div>
					</div>
				</div>
			</div>

	</body>
</html>
