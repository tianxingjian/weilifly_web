<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${paramMap.seoTitle }</title>
		<meta name="keywords" content="${paramMap.seoKeywords }" />
		<meta name="description" content="${paramMap.seoDescription }" />
		<link href="css/Common.css" type="text/css" rel="stylesheet"/>
		<link href="css/site.css" type="text/css" rel="stylesheet"/>
		<script src="script/jquery-1.11.0.min.js"></script>
		<script src="script/easing.js"></script>
		
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content">
				<div class="head2 bdnone">
					<div class="s-block1"></div>
					<ul class="second-nav">
						<s:iterator value="brandList" var="bean" status="st">
							<li <s:if test="#bean.id==paramMap.id">class="cur"</s:if>>
								<a href="brandDetail.do?id=${bean.id}">${bean.name}</a>
							</li>
						</s:iterator>
					</ul>
					<span>${paramMap.name}</span>
				</div>
				<div class="nr-txt">
					${paramMap.content}
				</div>
			</div>
		</div>
		<!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
		<script src="script/commom.js"></script>
	<script>
    $(function(){
    $.sideLi(".nav",".sliding-block");
    $.sideLi(".second-nav",".s-block1");
})
</script>
	</body>
</html>
