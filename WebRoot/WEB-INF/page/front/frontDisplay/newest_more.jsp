<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${paramMap.seoTitle }</title>
		<meta name="keywords" content="${paramMap.seoKeywords }" />
		<meta name="description" content="${paramMap.seoDescription }" />
		<link href="css/Common.css" type="text/css" rel="stylesheet" />
		<link href="css/site.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="script/jquery-1.11.0.min.js"></script>
		<script src="script/easing.js"></script>
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content">
				<div class="head2 bdnone">
					<div class="s-block1"></div>
					<span>最新动态</span>&nbsp;&nbsp;
					<s:hidden name="paramMap.id"></s:hidden>
				</div>
				<!--内页头部导航结束--->
				<div class="pp-info-box">
					<div class="pp-info">
						<a href="NewestDetail.do?id=${NewestMap.id }&typeId=${paramMap.id}" class="pic"><img src="${NewestMap.image }" />
						</a>
						<div>
						<s:if test="#request.NewestMap != null">
							<p class="title">
								<a href="NewestDetail.do?id=${NewestMap.id }&typeId=${paramMap.id}">${NewestMap.title }</a><span>${NewestMap.addTime }</span>
								</p>
									<p class="txt">
										<shove:sub value="#request.NewestMap.seoDescription" size="100" suffix="..."/><!--  -->
									</p>
									<a href="NewestDetail.do?id=${NewestMap.id }&typeId=${paramMap.id}" class="ck-btn">查看详情</a>
						</s:if>
						<s:else>
							
						</s:else>
						</div>
					</div>

					<ul class="pp-info-news">
						<s:iterator value="pageBean.page" var="bean" status="st">
							<li>
								<span><s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" /></span><a href="weiliDisplayDetail.do?id=${bean.id }&typeId=${paramMap.id}">${bean.title }</a>
							</li>
						</s:iterator>
					</ul>

						<shove:page url="queryWeiliDisplayes.do" curPage="${pageBean.pageNum}" showPageCount="5" pageSize="${pageBean.pageSize }" theme="numberFour" totalCount="${pageBean.totalNum}">
		                   <s:param name="id" >${paramMap.id}</s:param>
						</shove:page>
				</div>

			</div>
		</div>
		<%--<!-- 发送给我们开始 -->
		<jsp:include page="/include/sendToUs.jsp"></jsp:include>
		<!-- 发送给我们结束-->
		--%><!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
		<script src="script/commom.js"></script>
		<script type="text/javascript">
		  $(function(){
		  		$.sideLi(".second-nav",".s-block1");
		  });
		</script>
	</body>
</html>
