<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>管理首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
	<meta http-equiv="description" content="This is my page"/>
	<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />

  </head>
  <frameset frameborder="0" rows="40,*" cols="*" border="0" framespacing="0">
    <frame name="top" src="top.do"  scrolling="no"/>
    <frameset cols="158,*" rows="*" border="0" framespacing="0"> 
        <frame name="left" src="menu.do" scrolling="auto"   target="main"/>
        <frame name="main" src="main.do"/>
    </frameset>
    <noframes> 
        <body>
        <p>此网页使用了框架，但您的浏览器不支持框架。</p>
        </body>
    </noframes>
</frameset>
</html>
