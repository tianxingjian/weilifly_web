<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${paramMap.seoTitle}</title>
		<meta name="keywords" content="${paramMap.seoKeywords}" />
		<meta name="description" content="${paramMap.seoDescription}" />
		<link href="/css/Common.css" type="text/css" rel="stylesheet"/>
		<link href="/css/site.css" type="text/css" rel="stylesheet"/><%--
		<script src="script/jquery-1.11.0.min.js"></script>
		--%>
		<script src="script/jquery.min.js"></script>
		<script src="script/easing.js"></script>
		<script src="script/navigation.js"></script>
		
	</head>
	<body>
		<div><jsp:include page="/include/top.jsp"></jsp:include></div>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content">
				<div class="head2">
					<div class="s-block1"></div>
						<span><a style="text-decoration: none" href="queryWeiliDisplayes.do?id=${paramMap.parentId}">${parentMap.name }</a></span>
						&nbsp;&nbsp;&gt;
					<span><a style="text-decoration: none" href="queryWeiliDisplay.do?typeId=${paramMap.id}">${paramMap.name }</a></span>
				</div>
				<div class="nr-txt">
					<div class="pp-zx">
						<h3>
							${displayDetail.title}
						</h3>
						<div class="time">
							<span>时间：${displayDetail.addTime}</span>
							<s:if test="#request.displayDetail.source!=''&&#request.displayDetail.source!=null">
								<span>来源：${displayDetail.source}</span>
							</s:if>
							<span>浏览：${displayDetail.views}</span>
						</div>
					</div>
					<div class="pp-zx-txt">
						${displayDetail.content}
					</div>
					<ul class="new-page">
						<s:if test="#request.nextMap.preId>0">
							<li>
								<div>
									上一篇：
								</div>
								<p style="line-height: 30px;">
									<a href="weiliDisplayDetail.do?id=${nextMap.preId}&typeId=${paramMap.id}">${nextMap.preTitle}</a>
								</p>
							</li>
						</s:if>
						<s:if test="#request.nextMap.nextId>0">
							<li>
								<div>
									下一篇：
								</div>
								<p style="line-height: 30px;">
									<a href="weiliDisplayDetail.do?id=${nextMap.nextId}&typeId=${paramMap.id}">${nextMap.nextTitle}</a>
								</p>
							</li>
						</s:if>
					</ul>

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

		  })
		</script>
	</body>
</html>
