<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>SEO管理</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet"
			type="text/css" />

		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<script type="text/javascript" language="javascript">
		$(function(){
	    	param["pageBean.pageNum"]="${pageNow}";
		    initListInfo(param);
		    $("#search").click(function(){
		    	param["pageBean.pageNum"] = 1;
		    	initListInfo(param);
		    });
		    }
	    )
   		
   		function initCallBack(data){
		 	$("#dataInfo").html(data);
   		}
   		
   		function initListInfo(praData) {
		    praData["pageUrl"] = $("#pageUrl").val();
	   		$.shovePost("querySeoPageList.do",praData,initCallBack);
   		}
   		
   		//删除单个
   		function deleteSeoPageById(adminIds,pageNow){
	 		if(window.confirm("确定要删除吗?")){
	 			window.location.href = "deleteSeoPage.do?id="+adminIds+"&pageNow="+pageNow;
	 		}
   		}
   		
   		//判断是否有选中项
   		function checked(str){
   			var c = 0;
   			$(".adminId").each( function(i, n){
				if(n.checked){
					c = 1;
				}
			});
			if(c==0){
				alert("请先选中您要"+str+"的项！");
				return false;
			}
			return true;
   		}
   		
   		//删除多个选中项
   		function deleteSeoPage(pageNow){
   			if(!checked("删除")){
   				return;
   			}
	 		if(!window.confirm("确定要删除所有选中记录?")){
	 			return;
	 		}
	 		var Ids = "";
			$(".adminId").each( function(i, n){
				if(n.checked){
					Ids += n.value+",";
				}
			});
			Ids = Ids.substring(0,Ids.lastIndexOf(","));
		 	window.location.href = "deleteSeoPage.do?id="+Ids+"&pageNow="+pageNow;
   		}

   		//全选
   		function checkAll(e){
	   		if(e.checked){
	   			$(".adminId").attr("checked","checked");
	   		}else{
	   			$(".adminId").removeAttr("checked");
	   		}
   		}
	    </script>

	</head>

	<body>
		<div id="right"
			style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
			<div style="padding: 15px 10px 0px 10px;">
				<div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100" height="28" align="center" bgcolor="#CC0000"
								class="white12">
								<a href="querySeoPageInit.do">SEO列表</a>
							</td>
							<td width="2">
								&nbsp;
							</td>
								<td width="100" align="center" bgcolor="#8594A9" class="white12">
									<a href="addSeoPageInit.do">添加SEO</a>
								</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<div
					style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; width: auto; padding-top: 10px; background-color: #fff;">
					<table style="margin-bottom: 8px;" cellspacing="0" cellpadding="0"
						width="100%" border="0">
						<tbody>
							<tr>
								<td class="f66" align="left" width="50%" height="36px">
									页面URL：
									<input id="pageUrl" name="paramMap.pageUrl" />
									&nbsp;&nbsp;
									<input id="search" type="button" value="确定" name="search" />
								</td>
							</tr>
						</tbody>
					</table>
					<span id="dataInfo"> </span>
				</div>
			</div>
		</div>
	</body>
</html>
