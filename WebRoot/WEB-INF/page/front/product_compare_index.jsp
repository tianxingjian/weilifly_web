<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${seoMap.seoTitle }</title>
		<meta name="keywords" content="${seoMap.seoKeyWord}" />
		<meta name="description" content="${seoMap.seoDescription}" />
		<link href="css/Common.css" type="text/css" rel="stylesheet" />
		<link href="css/site.css" type="text/css" rel="stylesheet" />
		<script src="script/jquery-1.11.0.min.js">
</script>
		<script src="script/easing.js">
</script>
		<script src="script/commom.js">
</script>
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content main-content-1">
				<div class="head2">
					<a href="productDetail.do?id=${paramMap.id }" class="znjj-btn">返回${paramMap.name
						}详细</a>
					<span>${paramMap.name }</span>
				</div>
				<!--内页头部导航结束--->
				<ul class="cp-dp clearfix">
					<s:iterator value="pageBean.page" var="bean" status="st">
						<li>
							<div class="list1">
								<h3>
									${bean.name }
								</h3>
								<img src="${bean.image }" />
							</div>
							<s:iterator value="#request.parameterList" var="pBean"
								status="pst">
								<div style="word-wrap: break-word; word-break: break-all;">
									<s:iterator
										value="#request.productParameterList.{?#this.productId==#bean.id&&#this.parameterId==#pBean.id}"
										var="beans" status="sts">
										<div <s:if test="#pst.index%2==0">class="list2"</s:if>
											<s:else>class="list2-1"</s:else>>
											<table>
												<tr>
													<th width="85">
														${pBean.name }
													</th>
												</tr>
											</table>
											<div>
												${beans.content }
											</div>
										</div>
									</s:iterator>
								</div>
							</s:iterator>
						</li>
					</s:iterator>

				</ul>
				<div class="page-box">
					<shove:page url="productCompare.do" curPage="${pageBean.pageNum}"
						showPageCount="5" pageSize="${pageBean.pageSize }"
						theme="numberFour" totalCount="${pageBean.totalNum}">
						<s:param name="id">${paramMap.id}</s:param>
					</shove:page>
				</div>
				<ul class="cpdb-ul">
					<li>
						<a href="queryWebDistributeListInit.do" class="s1">售点分布</a>
					</li>
					<li>
						<a href="#" class="s2">电话咨询<span>400-678-0315</span> </a>
					</li>
					<li>
						<a href="#" class="s3"
							style="line-height: 20px; padding: 19px 0 0 117px;">在线咨询<span>${paramNumOneServiceMap.name
								}</span> </a>
					</li>
					<li>
						<a href="${paramMap.url}" class="s4" target="_blank">产品综合讨论区</a>
					</li>
				</ul>



			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
	</body>
</html>
