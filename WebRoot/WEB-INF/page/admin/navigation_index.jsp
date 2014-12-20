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
	   //加载Menu信息信息
	   function initListInfo(praData) {
		    param["paramMap.name"] = $("#name").val();//菜单名称
			param["paramMap.orderName"] = $("#orderName").val();//菜单等级
			param["paramMap.enable"] = $("#enable").val();//是否启用
	   		$.shovePost("queryNavigationBarInfo.do",praData,initCallBack);
   		}
   		
   		function initCallBack(data){
		 	$("#dataInfo").html(data);
   		}
   		
   		//分页
   		function pageInfo(pageId){
   			param["pageBean.pageNum"] = pageId;
   			initListInfo(param);
   		}
   		
   		//删除单个
   		function deleteNavigationBarById(navigationBarIds,pageNow){
	 		if(window.confirm("确定要删除吗?")){
	 			window.location.href = "deleteNavigationBar.do?id="+navigationBarIds+"&pageNow="+pageNow;
	 		}
   		}
   		
   		//判断是否有选中项
   		function checked(str){
   			var c = 0;
   			$(".navigationBarId").each( function(i, n){
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
   		function deleteNavigationBars(pageNow){
   			if(!checked("删除")){
   				return;
   			}
	 		if(!window.confirm("确定要删除所有选中记录?")){
	 			return;
	 		}
	 		var navigationBarIds = "";
			$(".navigationBarId").each( function(i, n){
				if(n.checked){
					navigationBarIds += n.value+",";
				}
			});
			navigationBarIds = navigationBarIds.substring(0,navigationBarIds.lastIndexOf(","));
		 	window.location.href = "deleteNavigationBar.do?id="+navigationBarIds+"&pageNow="+pageNow;
   		}

   		//全选
   		function checkAll(e){
	   		if(e.checked){
	   			$(".navigationBarId").attr("checked","checked");
	   		}else{
	   			$(".navigationBarId").removeAttr("checked");
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
								<a href="queryNavigationBarInit.do">Menu列表</a>
							</td>
							<td width="2">
								&nbsp;
							</td>
								<td width="100" align="center" bgcolor="#8594A9" class="white12">
									<a href="addNavigationBarInit.do">添加Menu</a>
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
									按菜单名称查询：
									<input id="name" name="paramMap.name" />&nbsp;&nbsp; 
									菜单级别:
									<s:select name="orderName" id="orderName" theme="simple"
										list="#{'':'-请选择-','一级':'一级','二级':'二级'}" value="">
									</s:select>
									是否显示:
									<s:select name="enable" id="enable" theme="simple"
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