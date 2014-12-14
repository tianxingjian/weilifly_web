<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>${seoMap.seoTitle }</title>
		<meta name="keywords" content="${seoMap.seoKeywords }" />
		<meta name="description" content="${seoMap.seoDescription }" />
		<link rel="stylesheet" href="css/Common.css" type="text/css"></link>
		<link href="css/site.css" type="text/css" rel="stylesheet" />		
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="script/easing.js"></script>
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<div class="content" style="min-height: 378px">
			<div class="main-content clearfix" style="min-height: 378px;">
				<div class="head2">
					<div class="s-block1"></div>
					<ul class="second-nav">
						<s:iterator value="serviceTypeList" var="bean" status="st">
							<li <s:if test="#bean.id==3">class="on cur"</s:if>>
								<a href="${bean.linkPath }">${bean.title }</a>
							</li>
						</s:iterator>
					</ul>
					<s:iterator value="serviceTypeList" var="beans" status="st">
						<s:if test="#beans.id==3">
							<span>${beans.title }</span>
						</s:if>
					</s:iterator>	
				</div>
				<!--内页头部导航结束--->
				<div class="online-left">
					<div class="m1">
						客服服务
					</div>
					<div class="m2">
						<img class="tpic" src="${paramPreMap.var }" alt="${paramPreMap.title }" />
						<img src="${paramAferMap.var }" alt="${paramAferMap.title }" />
					</div>
					<div class="m3">
						<span class="sp1">${paramPreMap.title }</span><span>${paramAferMap.title }</span>
					</div>
					<div class="m4">
						<a href="http://wpa.qq.com/msgrd?v=3&Uin=${paramPreMap.name }&Site=qq&Menu=yes" target="_blank" class="sp1">${paramPreMap.name }</a><a href="http://wpa.qq.com/msgrd?v=3&Uin=${paramAferMap.name }&Site=qq&Menu=yes"  target="_blank" >${paramAferMap.name }</a>
					</div>
				</div>
				<div class="online-right">
					${paramMap.var }
				</div>
			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域content 结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<script type="text/javascript" src="script/commom.js"></script>
		<script type="text/javascript">
		  $(function(){
		  		$.sideLi(".second-nav",".s-block1");
		  })
		</script>
	</body>
</html>
