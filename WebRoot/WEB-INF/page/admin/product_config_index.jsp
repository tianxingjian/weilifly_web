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
				$(".td_up").click(function(){
					var p = $(this).parent();
					var gvItem = $(".gvItem");
					var index = gvItem.index(p);
					if(index == 0){
				        alert("已经在最上面");
				        return;
				    }
				    else{
				        gvItem.eq(index-1).before(gvItem.eq(index));
				    }
					
				});
				$(".td_down").click(function(){
					var p = $(this).parent();
					var gvItem = $(".gvItem");
					var count = gvItem.length;
					var index = gvItem.index(p);
					if(index == (count-1)){
				        alert("已经在最下面");
				        return;
				    }
				    else{
				       gvItem.eq(index+1).after(gvItem.eq(index));
				    }
					
				});
			})
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
   				$.shovePost("deleteProductConfig.do",{id:ids},function(data){
   					if(data.msg==1){
   						alert("删除成功！");
   						window.location.href = window.location.href;
   						return;
   					}
   					
   					alert(data.msg);
   					
   				});
   				
   			}
   			
   			function updateSortIndex(){
   				var stIdArray = [];
	 			$("input[name='cb_ids']").each(function(){
	 				stIdArray.push($(this).val());
	 			});
	 			
	 			if(stIdArray.length == 0){
	 				return ;
	 			}
	 			var ids = stIdArray.join(",");
	 			$.shovePost("updateProductConfigSortIndex.do",{id:ids},function(data){
   					if(data.returnId==1){
   						alert("操作成功！");
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
								<a href="queryProductConfig.do">首页产品推荐</a>
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
					<div
						style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; width: auto; padding-top: 10px; background-color: #fff;">
						<div>
							<table id="help" style="width: 100%; color: #333333;"
								cellspacing="1" cellpadding="3" bgcolor="#dee7ef" border="0">
								<tbody>
									<tr class=gvHeader>
										<th scope="col">
											产品型号
										</th>
										<th scope="col">
											产品系列
										</th>
										<th scope="col">
											产品图片
										</th>
										<th scope="col">
											操作
										</th>
									</tr>
										<s:iterator value="#request.list" var="bean" status="st">
											<tr class="gvItem">
												<td align="center">
													${bean.productName}
												</td>
												<td align="center">
													${bean.productCategoryName}
												</td>
												<td align="center">
													<img src="../${bean.productConfigImage}" width="80px"/>
												</td>
												<td>
													<a href="updateProductConfigInit.do?id=${bean.id }" target="main">
													修改
													</a>
												</td>
											</tr>
										</s:iterator>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
	</body>
</html>
