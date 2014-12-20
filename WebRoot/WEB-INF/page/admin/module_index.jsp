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
	   //加载模块信息
	   function initListInfo(praData) {
		    param["paramMap.summary"] = $("#summary").val();//模块名称
			param["paramMap.isIntercept"] = $("#isIntercept").val();//权限分配 1：是  2：否
	   		$.shovePost("queryModuleInfo.do",praData,initCallBack);
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
   		function deleteModuleById(moduleIds,pageNow){
	 		if(window.confirm("确定要删除吗?")){
	 			window.location.href = "deleteModule.do?id="+moduleIds+"&pageNow="+pageNow;
	 		}
   		}
   		
   		//判断是否有选中项
   		function checked(str){
   			var c = 0;
   			$(".moduleId").each( function(i, n){
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
   		function deleteModules(pageNow){
   			if(!checked("删除")){
   				return;
   			}
	 		if(!window.confirm("确定要删除所有选中记录?")){
	 			return;
	 		}
	 		var moduleIds = "";
			$(".moduleId").each( function(i, n){
				if(n.checked){
					moduleIds += n.value+",";
				}
			});
			moduleIds = moduleIds.substring(0,moduleIds.lastIndexOf(","));
		 	window.location.href = "deleteModule.do?id="+moduleIds+"&pageNow="+pageNow;
   		}

   		//全选
   		function checkAll(e){
	   		if(e.checked){
	   			$(".moduleId").attr("checked","checked");
	   		}else{
	   			$(".moduleId").removeAttr("checked");
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
								<a href="queryModuleInit.do">模块列表</a>
							</td>
							<td width="2">
								&nbsp;
							</td>
								<td width="100" align="center" bgcolor="#8594A9" class="white12">
									<a href="addModuleInit.do">添加模块</a>
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
									按模块名称查询：
									<input id="summary" name="paramMap.summary" />&nbsp;&nbsp; 
									权限分配:
									<s:select name="isIntercept" id="isIntercept" theme="simple"
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