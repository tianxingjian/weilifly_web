<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<html>
	<head>
		<title>管理首页</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
$(function(){
              $("#uploads").click(function(){
                                  TajaxFileUpload();
                });
              });
function TajaxFileUpload()
{
alert($("#uploadImg").val());
        //准备提交处理
        //开始提交
        jQuery.ajax
        ({
         type: "POST",
         url:"uploadFiles.do",
         data:{imgFile:$("#uploadImg").val()},
         success:function (data, status)
         {
         alert("上传成功！");
         }
         });
}
</script>
	</head>
	<body>
	<form action="uploadFiles.do" method="post" enctype="multipart/form-data">
		<s:file id="uploadImg" name="imgFile"/><br/>
	    <input type="submit" id="uploadsa" value="上传" />
    </form>
	</body>
</html>
