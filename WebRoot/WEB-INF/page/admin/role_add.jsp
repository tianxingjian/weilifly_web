<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>添加角色</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<script type="text/javascript" src="../common/dialog/popup.js"></script>
		<script type="text/javascript">
			$(function(){
				$(".top").click(function(){
					var id = $(this).val();
					$(".top_"+id).attr("checked",$(this).attr("checked"));
				});
				$(".parent").click(function(){
					var id = $(this).val();
					$(".parent_"+id).attr("checked",$(this).attr("checked"));
					if(this.checked){
						var topId = $(this).attr("parentId");
						$("#top_"+topId).attr("checked",this.checked);
					}
				});
				$(".bottom").click(function(){
					var parentId = $(this).attr("parentId");
					if(this.checked){
						$("#parent_"+parentId).attr("checked",this.checked);
						var topId = $("#parent_"+parentId).attr("parentId");
						$("#top_"+topId).attr("checked",this.checked);
					}
				});
				$("#btn_save").click(function(){
					var stIdArray = [];
					$("input[name='rightsId']:checked").each(function(){
						stIdArray.push($(this).val());
					});
					if(stIdArray.length == 0){
		 				alert("请选择角色权限!");
		 				return ;
	 				}
	 				param["ids"] = stIdArray.join(",");
	 				param["roleName"] = $("#roleName").val();
	 				param["description"] = $("#description").val();
	 				$.shovePost("addRole.do",param,function(data){
	 					if(data.msg==1){
	 						alert("添加成功！");
	 						window.location.href = 'queryRoleList.do';
	 						return ;
	 					}
	 					alert(data.msg);
	 				})
				});
				
			});
			
			
		</script>
	</head>
	<body>
	<input type="hidden" id="categoryIds" value="${request.categoryIds }" />
	<input type="hidden" id="auditionCandidatesId" value="${request.id }" />
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryRoleList.do">角色管理</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="130" align="center" bgcolor="#CC0000" class="white12">
									添加角色权限
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
						</table>
					</div>
					<div style="border-top: #C00 2px solid;">
					</div>
					<div style="width: auto; background-color: #FFF; padding: 10px;">
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
							<s:set name="max" >0</s:set>
								<tr>
									<td style="height: 25px;padding-left: 10px;" align="right" class="blue12" width="70px;">
										角色名称：
									</td>
									<td align="left" class="f66">
										<input type="text" value="${name }" id="roleName"  />
									</td>
								</tr>
								<tr>
									<td style="height: 25px;padding-left: 10px;" align="right" class="blue12" width="70px;">
										描述：
									</td>
									<td align="left" class="f66">
										<textarea type="text" value="${description }" id="description" cols="40" rows="4" ></textarea>
									</td>
								</tr>
								<tr>
									<td style="height: 25px;padding-left: 10px;" align="right" class="blue12" width="100px;">
										角色权限：
									</td>
									<td class="f66">
						<s:iterator value="rightsList.{?#this.id<0}" var="bean">
						<input class="top" name="rightsId" id="top_${bean.id}" type="checkbox" value="${bean.id}" />${bean.summary }<br/>
							<s:iterator value="rightsList.{?#this.parentId==#bean.id}" var="sBean">
								&nbsp;&nbsp;&nbsp;<input class="top_${bean.id} parent" name="rightsId" id="parent_${sBean.id }" parentId="${sBean.parentId }" type="checkbox" value="${sBean.id}" />${sBean.summary }<s:iterator value="rightsList.{?#this.parentId==#sBean.id}" var="sbBean">&nbsp;&nbsp;&nbsp;<input class="top_${bean.id} bottom parent_${sBean.id}" name="rightsId" parentId="${sbBean.parentId }"  type="checkbox" value="${sbBean.id}" />${sbBean.summary }</s:iterator><br/>
							</s:iterator>
							<br/>
		             </s:iterator>
									</td>
								</tr>
								<s:set name="max" >${sta.count }</s:set>
							
							<tr>
								<td></td>
								<td colspan="2" align="left" style="padding-left: 30px;">
									<button id="btn_save"
										style="background-image: url('../images/admin/btn_queding.jpg'); width: 70px; border: 0; height: 26px"></button>
									&nbsp;
								</td>
							</tr>
						</table>
						<br />
					</div>
				</div>
			</div>
	</body>
</html>
