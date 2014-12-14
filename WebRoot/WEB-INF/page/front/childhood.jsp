<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>儿童类应用隐私协议</title>
		<meta name="keywords" content="${paramMap.seoKeywords }" />
		<meta name="description" content="${paramMap.seoDescription }" />
		<link rel="stylesheet" href="css/Common.css" type="text/css"></link>
		<link href="css/site.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="script/easing.js"></script>
		<script type="text/javascript" src="script/commom.js"></script>
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<div class="content" style="min-height: 378px">
			<div class="main-content clearfix" style="min-height: 378px;">
				<!-- <div class="head2">
					<div class="s-block1"></div>
					<ul class="second-nav">
					</ul>
					<span>儿童类应用隐私协议</span>
				</div> -->
				<!--内页头部导航结束--->
				<div class="nr-txt">
					${paramMap.var }
				</div>
			</div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</body>
</html>
