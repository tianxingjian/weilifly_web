<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>管理首页</title>
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
	    		init();
				//提交表单
				$("#btn_save").click(function(){
					$(this).hide();
					$("#addWebDistribute").submit();
					return false;
				});
				
				$("#province").change(function(){
					var provinceId = $("#province").val();
					citySelectInit(provinceId, 2);
					$("#area").html("<option value='-1'>--请选择--</option>");
				});
				
				$("#city").change(function(){
					var cityId = $("#city").val();
					areaSelectInit(cityId, 3);
				});
				
				
			});
			
						
				//级联城市
			function citySelectInit(parentId, regionType){
				var _array = [];
				_array.push("<option value='-1'>--请选择--</option>");
				if(parentId<=0){
					$("#city").html(_array.join(""));
					return;
				}
				var param = {};
				param["regionType"] = regionType;
				param["parentId"] = parentId;
				$.post("ajaxqueryRegion.do",param,function(data){
					for(var i = 0; i < data.length; i ++){
						_array.push("<option value='"+data[i].id+"'>"+data[i].regionName+"</option>");
					}
					$("#city").html(_array.join(""));
					var cityId ='${paramMap.cityId}';
					$("#city").val(cityId);
				});
			}
			//级联地区
			function areaSelectInit(parentId, regionType){
				var _array = [];
				_array.push("<option value='-1'>--请选择--</option>");
				if(parentId<=0){
					$("#area").html(_array.join(""));
					return;
				}
				var param = {};
				param["parentId"] = parentId;
				param["regionType"] = regionType;
				$.post("ajaxqueryRegion.do",param,function(data){
					for(var i = 0; i < data.length; i ++){
						_array.push("<option value='"+data[i].id+"'>"+data[i].regionName+"</option>");
					}
					$("#area").html(_array.join(""));
					var areaId ='${paramMap.areaId}';
					$("#area").val(areaId);
				});
			}
			
			
			
			function init(){
				var parentId ='${paramMap.provinceId}';
				$("#province").val(parentId);
				if(parentId != null && parentId !=''){
					citySelectInit(parentId,2);
				}
				var cityId ='${paramMap.cityId}';
				if(cityId != null && cityId !=''){
					areaSelectInit(cityId,3);
				}				
			}
			
		</script>
	</head>

	<body>
		<form id="addWebDistribute" action="addWebDistribute.do" method="post">
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryWebDistributeInit.do">网点分布列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									<a href="addWebDistributeInit.do">添加网点分布</a>
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
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									排序：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.sortIndex" theme="simple"
										cssClass="in_text_2" cssStyle="width: 250px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.sortIndex" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									类型：
								</td>
								<td align="left" class="f66">
									<s:select name="paramMap.type" id="type" theme="simple"
										list="webDistributeTypeList" listKey="id" listValue="title" headerKey="-1" headerValue="-请选择-">
									</s:select>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.type" /> </span>
								</td>

							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									销售店铺：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.storeName" theme="simple"
										cssClass="in_text_2" cssStyle="width: 350px; height:23px;"></s:textfield>
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.storeName" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									服务电话：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.phone" theme="simple"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.phone" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									地址：
								</td>
								<td align="left" class="f66">
									<s:select id="province" name="paramMap.provinceId" 
										list="provinceList" listKey="id"
										listValue="regionName" headerKey="-1" headerValue="--请选择--" />
									<s:select id="city" name="paramMap.cityId" 
										list="#{-1:'--请选择--'}"
										/>
									<s:select id="area" name="paramMap.areaId"
										list="#{-1:'--请选择--'}" />
									<span class="require-field"><s:fielderror fieldName="paramMap.areaId"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									详细地址：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.address" theme="simple"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.address" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									经度：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.longitude" theme="simple"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.longitude" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									纬度：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.latitude" theme="simple"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.latitude" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.status" id="status" theme="simple"
										list="#{1:'是',2:'否'}" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.status" /> </span>
								</td>

							</tr>
							<tr>
								<td height="25">
								</td>
								<td align="left" class="f66" style="color: Red;">
									<s:fielderror fieldName="paramMap.allError" />
								</td>
							</tr>
							<tr>
								<td height="36" align="right" class="blue12">
									&nbsp;
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td height="36" align="right" class="blue12">
									&nbsp;
								</td>
								<td>
									<button id="btn_save"
										style="background-image: url('../images/admin/btn_queding.jpg'); width: 70px; border: 0; height: 26px"></button>
									&nbsp;
									<button type="reset"
										style="background-image: url('../images/admin/btn_chongtian.jpg'); width: 70px; height: 26px; border: 0px"></button>
									&nbsp; &nbsp;
									<span style="color: red;"> <s:fielderror
											fieldName="actionMsg" theme="simple"></s:fielderror> </span>
								</td>
							</tr>
						</table>
						<br />
					</div>
				</div>
			</div>
		</form>
	</body>
</html>
