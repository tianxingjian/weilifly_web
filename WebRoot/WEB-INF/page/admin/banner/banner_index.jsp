<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>Banner管理</title>
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
		    praData["title"] = $("#title").val();
		    praData["type"]=$("#type").val();
		    praData["status"] = $("#status").val();
	   		$.shovePost("queryBanner.do",praData,initCallBack);
   		}
   		
   		/*删除单个
   		function deleteBannerById(adminIds,pageNow){
	 		if(window.confirm("确定要删除吗?")){
	 			window.location.href = "deleteBanner.do?id="+adminIds+"&pageNow="+pageNow;
	 		}
   		}*/
   		
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
   		function deleteBanner(pageNow){
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
		 	window.location.href = "deleteBanner.do?id="+Ids+"&pageNow="+pageNow;
   		}

   		//全选
   		function checkAll(e){
	   		if(e.checked){
	   			$(".adminId").attr("checked","checked");
	   		}else{
	   			$(".adminId").removeAttr("checked");
	   		}
   		}
   		
   		//单个删除
   		function del(id){
	 		if(!window.confirm("确认删除?")){
	 			return;
	 		}
 			delObjs(id);
	 	}
   		//批量删除
   		function dels(){
	 		if(!window.confirm("确认删除?")){
	 			return;
	 		}
	 		var stIdArray = [];
 			$("input[name='cb_ids']:checked").each(function(){
 				stIdArray.push($(this).val());
 			});
 			if(stIdArray.length == 0){
 				alert("请先选择您要删除的内容！");
 				return ;
 			}
 			var ids = stIdArray.join(",");
 			delObjs(ids);
	 	}
   		
   		function delObjs(ids){
				$.shovePost("deleteBanner.do",{id:ids},function(data){
					if(data.msg==1){
						alert("删除成功！");
						window.location.href = window.location.href;
						return;
					}
					
					alert(data.msg);
					
				});
				
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
								<a href="queryBannerInit.do">Banner列表</a>
							</td>
							<td width="2">
								&nbsp;
							</td>
							<td width="100" align="center" bgcolor="#8594A9" class="white12">
								<a href="addBannerInit.do">添加Banner</a>
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
									标题：
									<input id="title" name="paramMap.title" />
									&nbsp;&nbsp;类型：
									<s:select name="type" id="type" theme="simple"
										list="#{-1:'-请选择-',1:'PC-首页',2:'APP-首页'}" value="-1">
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
