<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>设计素材管理</title>
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
		    	param["pageBean.pageNum"]=1;
		    	initListInfo(param);
			    $("#search").click(function(){
			    	param["pageBean.pageNum"] = 1;
			    	initListInfo(param);
			    });
		   })
		   
		function initCallBack(data){
		 	$("#dataInfo").html(data);
		 	
	 		$(".bt_select").click(function(){
				var even = $(this);
				even.hide();
				design = [];
				design["id"] = even.attr("id");
				design["title"] = even.attr("title");
				window.parent.joxCallBack(design);
			});
   		}
   		
   		function initListInfo(praData) {
		    praData["title"] = $("#title").val();
		    praData["categoryId"]=$("#categoryId").val();
		    praData["status"] = $("#status").val();
	   		$.shovePost("queryDesign2.do",praData,initCallBack);
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
								<a href="queryDesignInit2.do">设计素材列表</a>
							</td>
							<td width="2" colspan="3">
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
									标题：
									<input id="title" name="paramMap.title" />
									&nbsp;&nbsp;分类：
									<s:select name="paramMap.categoryId" id="categoryId"
										theme="simple" list="categoryList" listKey="id"
										listValue="name" headerKey="-1" headerValue="-请选择-">
									</s:select>
									&nbsp;&nbsp; 是否显示:
									<s:select name="status" id="status" theme="simple"
										list="#{-1:'-请选择-',1:'是',2:'否'}" value="-1">
									</s:select>
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
