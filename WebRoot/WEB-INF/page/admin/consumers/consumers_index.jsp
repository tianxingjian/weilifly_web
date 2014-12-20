<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<html>
	<head>
		<title>会员管理</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<script type="text/javascript">
			$(function(){
				param["pageBean.pageNum"] = 1;
				initListInfo(param);
				$("#bt_search").click(function(){
					param["pageBean.pageNum"] = 1;
					initListInfo(param);
				});
				
			});
			
			function initListInfo(praData){
			
				praData["cTelephone"] = $("#cTelephone").val();
				praData["cName"] = $("#cName").val();
				praData["address"] = $("#address").val();
				praData["needId"] = $("#needId").val();
				
		 		$.shovePost("queryConsumersInfo.do",praData,initCallBack);
		 	}
		 	
		 	function initCallBack(data){
				$("#dataInfo").html(data);
			}
			
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
		 	
		 	function del(id){
		 		if(!window.confirm("确认删除?")){
		 			return;
		 		}
	 			delObjs(id);
		 	}
		 	
		 	function checkAll(e){
		   		if(e.checked){
		   			$(".objId").attr("checked","checked");
		   		}else{
		   			$(".objId").removeAttr("checked");
		   		}
   			}
   			
   			function delObjs(ids){
   				$.shovePost("deleteConsumers.do",{id:ids},function(data){
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
								<a href="queryConsumersInit.do">潜在用户列表</a>
							</td>
							<td width="2">
								&nbsp;
							</td>
							<%--<td width="100" align="center" bgcolor="#8594A9" class="white12">
								<a href="addDemoInit.do">添加用户</a>
							</td>
							--%>
							<td width="2">
								&nbsp;
							</td>
							<td width="2">
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
					<div
						style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; width: auto; padding-top: 10px; background-color: #fff;">
						<table style="margin-bottom: 8px;" cellspacing="0" cellpadding="0"
							width="100%" border="0">
							<tbody>
								<tr>
									<td class="f66" align="left" width="50%" height="36px">
									
										姓名/公司名：
										<input id="cName" name="paramMap.cName" type="text"/>
										&nbsp;&nbsp;
										
										手机号：
										<input id="cTelephone" name="paramMap.cTelephone" type="text"/>
										&nbsp;&nbsp;
										
										地址：
										<input id="address" name="paramMap.address" type="text"/>
										&nbsp;&nbsp;
										
										需求类型：
											<s:select list="needsTypeList" id="needId" name="paramMap.needId" listKey="id" listValue="needs_name" headerKey="-2" headerValue="--请选择--"></s:select>
											<span style="color: red;">*<s:fielderror
											fieldName="paramMap.needId" />
											</span>
										
											<input id="bt_search" type="button" value="搜索"  />
										</td>
								</tr>
							</tbody>
						</table>
						<span id="dataInfo"> </span>
					</div>
				</div>
			</div>
			</div>
	</body>
</html>
