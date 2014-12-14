<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<html>
	<head>
		<title>产品详情列表</title>
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
			function deleteParameter(id,productId){
				if(window.confirm("确定删除？")){
					window.location.href = "deleteProductDetail.do?ids="+id+"&productId="+productId;
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
								<a href="queryProductDetailList.do?id=${paramMap.id }">产品详情列表</a>
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
				</div>


				<div
					style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; width: 100%; padding-top: 5px; background-color: #fff;">
			
					<div style="padding-bottom: 5px;padding-top: 5px;"><strong>产品名称：${paramMap.name }</strong></div>
					<span id="divList">
						<div>
							<table id="gvNews" style="width: 100%; color: #333333;"
								cellspacing="1" cellpadding="3" bgcolor="#dee7ef" border="0">
								<tbody>
									<tr class=gvHeader>
										<th style="width: 100px;" scope="col">
											序号
										</th>
										<th scope="col">
											模块名称
										</th>
										<th style="width: 80px;" scope="col">
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

												<td align="center" style="width: 100px;">
													${st.count}
												</td>
												<td align="center">
													${bean.name}
												</td>
												<td>
													<a href="updateProductDetailInit.do?id=${bean.id }" target="main">
														编辑 </a>&nbsp;
													<s:if test="#bean.type==2||#bean.type==5||#bean.type==6||#bean.type==7">
													<a href="queryProductDetailList.do?id=${paramMap.id }&parentId=${bean.id}" target="main">
														查看子类</a>
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
