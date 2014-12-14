<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
		<script type="text/javascript" src="script/easing.js"></script>
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<div class="content" style="background: #fff;">
			<div class="main-content clearfix" style="border: none;">
				<jsp:include page="/include/help.jsp"></jsp:include>
				<div class="right-raea x">
					<div class="h3">
						${paramMap.title }
					</div>
					<dl class="lxfs">
						${paramMap.content }
					</dl>
				</div>
				<!--右侧导航结束--->
			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域content 结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<script type="text/javascript" src="script/commom.js"></script>
	</body>
</html>
