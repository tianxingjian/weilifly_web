<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>管理首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
	<meta http-equiv="description" content="This is my page"/>
	<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
	<script type="text/javascript">
			$(function(){
				$(".login_code").val("");
				document.getElementById("userName").focus();
				$(window).bind('keyup', function(event){
				   if (event.keyCode=="13"){
				   	validatorCodeIsExpired();
				   }
				});
				
			});
			//初始化
			function switchCode(){
				var timenow = new Date(); 
				$("#codeNum").attr("src","imageCode.do?pageId=adminlogin&d="+timenow);
			}
			//判断验证码是否过期
			function validatorCodeIsExpired(){
				var param = {};
				param["pageId"] = "adminlogin";
				$.post("codeIsExpired.do",param,function(data){
					 if(data == 1){
					 	alert("验证码已过期");
					 	switchCode();
					 	return ;
					 }
					$("#loginForm").submit();
				});
			}
	</script>
</head>
<body style="background-position: top; background-image: url(../images/admin/login_bg.jpg);
    background-repeat: repeat-x;">
    <form id="form1" action="adminLogin.do" method="post">
    <input type="hidden" value="adminlogin" name="pageId" />
        <div style="width: 100%; overflow: hidden;">
            <div class="white14" style="float: left; width: 500px; text-align: left; padding: 8px 0px 0px 20px;">
                <strong>管理后台</strong></div>
            <div class="white12" style="float: right; width: 200px; text-align: right; padding: 8px 20px 0px 0px;">

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
        <div style="width: 386px; margin: 90px 0px 0px 0px; margin-left: auto; margin-right: auto;
            overflow: hidden;">
            <div>
                <img src="../images/logo.png" width="386" height="60" border="0" /></div>
            <div>
                <img src="../images/admin/text_top.jpg" width="386" height="10" border="0" /></div>
            <div style="background-image: url(../images/admin/text_bg.jpg); width: 386px;">
                <div style="margin-left: auto; margin-right: auto; padding: 20px 10px 0px 10px;">
                    <div style="background-image: url(../images/admin/text_bg_jb.jpg);">
                        <table width="280" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="32" colspan="2" class="blue12">
                                    账号：<span style="color: red;"><s:fielderror fieldName="paramMap.userName" /></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                	<s:textfield id="userName" name="paramMap.userName" theme="simple" maxlength="25" cssClass="login_text" cssStyle="width: 280px"></s:textfield>
                            </tr>
                            <tr>
                                <td height="32" colspan="2" class="blue12">
                                    密码：<span style="color: red;"><s:fielderror fieldName="paramMap.password" /></span></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                		<s:password name="paramMap.password" cssClass="login_text" cssStyle="width: 280px" theme="simple" maxlength="20"></s:password>
                            </tr>
                            <tr>
                                <td height="32" colspan="2" class="blue12">
                                    验证码：<span style="color: red;"><s:fielderror fieldName="paramMap.code" /></span></td>
                            </tr>
                            <tr>
                                <td width="210">
                                <s:textfield  name="paramMap.code" cssClass="login_text" theme="simple" cssStyle="width: 150px"/>
                                <td width="70">
                                   <img src="imageCode.do?pageId=adminlogin" title="点击更换验证码" style="cursor: pointer;"
													id="codeNum" width="110" height="20"
													onclick="javascript:switchCode()"></img></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding: 18px 0px 30px 0px;">
                                    <input type="submit" value="确认" id="btnLogin" style="width: 70px;height: 30px"/>
                                        </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div>
                <img src="../images/admin/text_foot.jpg" width="386" height="10" border="0" /></div>
        </div>
    </form>
</body>
</html>

