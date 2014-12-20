<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta id="viewport" name="viewport" content="width=320;inital-scale=1.0;maximum-scale=1.0;user-scalable=yes;" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="black" name="apple-mobile-web-app-status-bar-style" />
<title>朵唯手机（支付订单-支付成功）</title>
<script type="text/javascript" src="script/jquery-1.8.0.min.js"></script>
 <link rel="stylesheet" href="css/style1.css" />	
 <link rel="stylesheet" href="css/jquery.mobile-1.3.2.min.css" />	
 <script src="script/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		$("#toIndex").click(function(){
			alert('{\"flag\":\"3\"}');
		});
		$("#toOrderDetails").click(function(){
			var oid = '${request.orderId}';
			alert('{\"flag\":\"2\",\"url\":\"www/user/order_detail.html\",\"method\":\"initData\",\"param\":\"userId,'+oid+'\"}');
		});
	});
</script>
</head>
<body>
<div data-role="page" id="page">
<div data-role="content" class="ui-content-2">
	 <div class="ui-Alert pay_a" style="background:none;height:126px">
			<p class="ok_c"><i class="ok_ioc"></i>恭喜您，支付订单成功！</p>
			<div class="ok_btn">
			   <div class="de l"><a href="javascript:;" id="toIndex" class="jxgm_btn">继续购买</a></div>
			   <div class="de r"><a href="javascript:;" id="toOrderDetails" class="fqgm_btn">查看订单详情</a></div>
			</div>					
	  </div>
</div>
<!--右侧划出菜单-->
</div>
</body>
</html>
