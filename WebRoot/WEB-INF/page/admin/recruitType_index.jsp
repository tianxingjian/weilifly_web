<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
		<title>人才分布类型管理</title>

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
	   		//删除单个
	   		function deleteRecruitTypeById(adminIds){
	   			if(window.confirm("此类型内容也会删除，确定要删除吗?")){
		 			window.location.href = "deleteRecruitType.do?id="+adminIds;
		 		}
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
								<a href="queryRecruitType.do">人才招聘类型列表</a>
							</td>
							<td width="2">
								&nbsp;
							</td>
							<td width="100" align="center" bgcolor="#8594A9" class="white12">
								<a href="addRecruitTypeInit.do">添加人才招聘类型</a>
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<div
					style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; width: auto; padding-top: 10px; background-color: #fff;">
					<table id="gvNews" style="width: 100%; color: #333333;"
						cellspacing="1" cellpadding="3" bgcolor="#dee7ef" border="0">
						<tbody>
							<tr class=gvHeader>
								<th style="width: 35px;" scope="col">
									选中
								</th>
								<th scope="col">
									类型名称
								</th>
								<th scope="col">
									添加时间
								</th>
								<th scope="col">	
									排序
								</th>
								<th scope="col">
									是否显示
								</th>
								<th scope="col">
									操作
								</th>
							</tr>
							<s:if test="#request.list==null || #request.list.size==0">
								<tr align="center" class="gvItem">
									<td colspan="8">
										暂无数据
									</td>
								</tr>
							</s:if>
							<s:else>
								<s:iterator value="#request.list" var="bean" status="st">
									<tr class="gvItem">
										<td>
											<input id="gvNews_ctl02_cbID" class="adminId" type="checkbox"
												value="${bean.id }" name="gvNews$ctl02$cbID" />
										</td>
										<td align="center">
											${title }
										</td>
										<td>
											<s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" />
										</td>
										<td>
											${bean.sortIndex }
										</td>
										<td>
											${status==1?'是':'否' }
										</td>
										<td>
											<a href="updateRecruitTypeInit.do?id=${bean.id }" target="main"> 编辑</a>
											<s:if test="#bean.id!=1&&#bean.id!=2">
												<a id="gvNews_ctl02_lbDelete" style="cursor: pointer;" onclick="deleteRecruitTypeById(${bean.id })">删除</a>
											</s:if>
										</td>
									</tr>
								</s:iterator>
							</s:else>
						</tbody>
					</table>
				</div>
			</div>
		</div>
  </body>
</html>
