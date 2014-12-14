<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>微力科技</title>
		<link rel="stylesheet" type="text/css" href="../css/main.css" charset="utf-8"/>
		<link rel="stylesheet" type="text/css" href="../css/style.css" charset="utf-8"/>
		
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<div class=" artbody">
		  <div class="wp">
		      <div class="list_tit">
		            <h2>消息提示</h2>
		      </div>
		      	<div style="font-size: 18px;padding-top: 100px;padding-bottom: 100px;" align="center" valign="center">
		       	${msg }
	       		</div>
		  </div>
		</div>
		<jsp:include page="/include/footer.jsp"></jsp:include>
	</body>
</html>

