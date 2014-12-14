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
		<script type="text/javascript" src="script/easing.js"></script>
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#username").focus();
				$("#btnLogin").click(function(){					
					$(this).hide();
					$("#formLogin").submit();
					return false;
				});
				
				
				
			/*	$(window).bind('keyup', function(event){
				   if (event.keyCode=="13"){
				      $("#formLogin").submit();
				   }
				});*/
			})
		</script>
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<div class="content clearfix" style="background: #fff;">
			<form id="formLogin" action="userLogin.do" method="post">
				<div class="main-content clearfix">
					<div class="login-h">
						<p class="p1">
							代理商登录
							<span>/Agent Login</span>
						</p>
						<p class="p2">
							进入代理商系统请先登陆！
						</p>
					</div>
					<div class="login-box">
						<div class="m1">
							<span>用户名：</span>
							<s:textfield id="username" name="paramMap.username"
								theme="simple" maxlength="25" cssStyle="width: 280px"></s:textfield>
							<em style="color: red;"><s:fielderror
									fieldName="paramMap.username" /> </em>
						</div>
						<div class="m2">
							<span>密码：</span>
							<s:password id="password" name="paramMap.password" theme="simple"
								maxlength="25" cssStyle="width: 280px"></s:password>
							<em style="color: red;"><s:fielderror
									fieldName="paramMap.password" /> </em>
						</div>
						<div class="m3">
							<input type="button" id="btnLogin" class="a" value="登录" />
						</div>

					</div>
				</div>
			</form>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域content 结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>

	</body>
</html>
