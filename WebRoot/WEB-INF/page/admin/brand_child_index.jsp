<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<html>
	<head>
		<title>等级折扣设置</title>
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
		<script type="text/javascript">
			function del(id){
		 		if(!window.confirm("确认删除?")){
		 			return;
		 		}
	 			delObjs(id);
		 	}
		 	
		 	function delObjs(ids){
   				$.shovePost("deleteBrand.do",{id:ids},function(data){
   					if(data.msg==1){
   						alert("删除成功！");
   						window.location.href = window.location.href;
   						return;
   					}
   					
   					alert(data.msg);
   					
   				});
   				
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
							<td width="100" height="28" align="center"  bgcolor="#8594A9"
								class="white12">
								<a href="queryBrandInit.do">品牌列表</a>
							</td>
							<td width="2">
								&nbsp;
							</td>
							<td width="100" align="center" bgcolor="#CC0000" class="white12">
								查看二级
							</td>
							<td width="2">
								&nbsp;
							</td>
							<td width="100" height="28" align="center"  bgcolor="#8594A9"
								class="white12">
								<a href="addBrandInit.do?parentId=${request.parentId}">添加二级</a>
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
				</div>


				<div
					style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; width: 100%; padding-top: 5px; background-color: #fff;">


					<span id="divList">
						<div>
							<table id="help" style="width: 100%; color: #333333;"
								cellspacing="1" cellpadding="3" bgcolor="#dee7ef" border="0">
								<tbody>
									<tr class=gvHeader>
										<th style="width: 35px;" scope="col">
											序号
										</th>
										<th scope="col">
											名称
										</th>
										<th scope="col">
											是否显示
										</th>
										<th scope="col">
											排序
										</th>
										<th scope="col">
											操作
										</th>
									</tr>
									<s:if test="#request.list==null || #request.list.size==0">
										<tr align="center" class="gvItem">
											<td colspan="4">
												暂无数据
											</td>
										</tr>
									</s:if>
									<s:else>
										<s:iterator value="#request.list" var="bean" status="st">
											<tr class="gvItem">
												<td>
													${st.count}
												</td>
												<td align="center">
													${bean.name}
												</td>
												<td align="center">
													<s:if test="#bean.status==1">是</s:if>
													<s:elseif test="#bean.status==2">否</s:elseif>
												</td>
												<td align="center">
													${bean.sortIndex}
												</td>
												<td>
													<a href="updateBrandInit.do?id=${bean.id }" target="main">
														编辑 </a> 
													<s:if test="#bean.id!=6&&#bean.id!=7&&#bean.id!=8&&#bean.id!=9">
														<a href="javascript:del(${bean.id })" target="main">
														删除
														</a>
													</s:if>
												</td>
											</tr>
										</s:iterator>
									</s:else>
								</tbody>
							</table>
						</div> </span>
				</div>
			</div>
	</body>
</html>
