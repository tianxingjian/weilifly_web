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
	<link rel="shortcut icon"  href="/images/favicon.ico"  />
</head>
<body style="background-position: top; background-image: url(../images/admin/login_bg.jpg);
    background-repeat: repeat-x;">
    <div style="width: 100%; overflow: hidden;">
        <div class="white14" style="float: left; width: 500px; text-align: left; height: 31px;
            padding: 8px 0px 0px 20px; overflow: hidden;">
            <strong>微力科技网站后台</strong></div>
        <div class="white12" style="float: right; width: 180px; text-align: right; padding: 8px 20px 0px 0px;
            overflow: hidden;">
			<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
            <script type="text/javascript">
            today=new Date();
            function initArray(){
            this.length=initArray.arguments.length
            for(var i=0;i<this.length;i++)
            this[i+1]=initArray.arguments[i]  }
            
            var d=new initArray(
            "星期日",
            "星期一",
            "星期二",
            "星期三",
            "星期四",
            "星期五",
            "星期六");
            var year = today.getFullYear();
            /*var userAgent = navigator.userAgent.toLowerCase();
            var chrome =/chrome/.test(userAgent);
            if($.browser.mozilla || chrome){
			   year = year + 1900;
			  }*/
            document.write("",
            year,"年",
            today.getMonth()+1,"月",
            today.getDate(),"日   ",
            d[today.getDay()+1],"");
            document.write("&nbsp;");
            /*
            var d = new Date();
            var vHour = d.getHours();
            var vMin = d.getMinutes();
            var vSec = d.getSeconds();
            document.write(vSec<10 ?  "0"+ vSec : vSec )
            document.write("&nbsp;");*/
            </script>

        </div>
    </div>
</body>
</html>
