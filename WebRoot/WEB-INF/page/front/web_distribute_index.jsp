<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${seoMap.seoTitle }</title>
		<meta name="keywords" content="${seoMap.seoKeywords }" />
		<meta name="description" content="${seoMap.seoDescription }" />
		<link rel="stylesheet" href="css/Common.css" type="text/css"></link>
		<link href="css/site.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
		<script type="text/javascript" src="script/jquery.json-2.2.js"></script>
		<script type="text/javascript" src="script/easing.js"></script>
		<script type="text/javascript" src="script/json2.js"></script>
		<script type="text/javascript">
		  $(function(){
		  		$(".nav li:eq(4)").attr("class","cur");
		  		$.sideLi(".nav",".sliding-block");
		  		$.sideLi(".second-nav",".s-block1");
		  		$.sideLi(".n-s-nav-1",".s-block","click");
		  });
		</script>
		<script type="text/javascript">
	      $(function(){
	      		$(".nav li:eq(4)").attr("class","cur");	   
	      		init();
	    		param["pageBean.pageNum"]="${pageNum}";
	    		param["type"]=1;
	    		$("#hid_type").val("1");
	    		param["provinceId"]="${provinceId}";
	   		    param["cityId"]="${cityId}";
	   		    param["areaId"]= $("#area").val();
		    	initListInfo(param);
		    	mapInitInfo(param);
		    	$("#province").change(function(){
					var provinceId = $("#province").val();
					citySelectInit(provinceId, 2);
					$("#city").html("<option value='-1'>--请选择--</option>");
					$("#area").html("<option value='-1'>--请选择--</option>");
					xclick($("#hid_type").val());
				});
				
				$("#city").change(function(){
					var cityId = $("#city").val();
					areaSelectInit(cityId, 3);
					xclick($("#hid_type").val());
				});
				
				
				$("#area").change(function(){
					xclick($("#hid_type").val());	
				})
				
				 $("#search").click(function(){
					xclick($("#hid_type").val());
		    	});						   
		    })		
		    
	    //加载留言信息
	   function initListInfo(praData) {
	   		var kw=$("#keyword").val();
	   		if(kw=="请输入关键字"){
	   			kw="";
	   		}
	   		praData["keyword"]=kw; 		
	   		$.shovePost("queryWebDistributeList.do",praData,initCallBack);
   		}
   		
   		function initCallBack(data){
		 	$("#dataInfo").html(data);		 	
   		}
   		   		
   		
   		//分页
   		function pageInfo(pageId){
   			param["pageBean.pageNum"] = pageId;
   			initListInfo(param);
   		}
   		
   		
   			//销售网点(网点分布类型)
   		function xclick(type){
   			param["pageBean.pageNum"]="${pageNum}";
   			param["type"]=type;
   			$("#hid_type").val(type);
   			param["provinceId"]=$("#province").val();
	   		param["cityId"]=$("#city").val();
	   		param["areaId"]=$("#area").val();
	   		var kw=$("#keyword").val();
	   		if(kw=="请输入关键字"){
	   			kw="";
	   		}
	   		param["keyword"]=kw; 	
   		    $.shovePost("queryWebDistributeList.do",param,initCallBack);
   		    mapClick();
   		}
   		 
   						
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
					var cityId ='${cityId}';
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
				var parentId ='${provinceId}';
				$("#province").val(parentId);
				if(parentId != null && parentId !=''){
					citySelectInit(parentId,2);
				}
				var cityId ='${cityId}';
				areaSelectInit(cityId,3);
				//if(cityId != null && cityId !=''){
					//areaSelectInit(cityId,3);
				//}				
			}
			
			function mapInitInfo(param){
				$.shovePost("queryWebDistributeAll.do",param,function(data){
	                $("#maps").html(data);
	   			});
			}
			
			//地图
			function mapClick(){
				param["type"]=$("#hid_type").val();
				param["provinceId"]=$("#province").val();
	   			param["cityId"]=$("#city").val();   		
	   			param["areaId"]=$("#area").val();
	   			$.shovePost("queryWebDistributeAll.do",param,function(data){
	                $("#maps").html(data);
	   			});
			}  
					
		</script>	
		
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<s:hidden name="paramMap.type" id="hid_type" ></s:hidden>
		<div class="content">
			<div class="main-content main-content-1">
				<div class="head2">
					<div class="s-block1"></div>
					<ul class="second-nav">
						<s:iterator value="serviceTypeList" var="bean" status="st">
							<li <s:if test="#bean.id==2">class="on cur"</s:if>>
								<a href="${bean.linkPath }">${bean.title }</a>
							</li>
						</s:iterator>
					</ul>
					<s:iterator value="serviceTypeList" var="beans" status="st">
						<s:if test="#beans.id==2">
							<span>${beans.title }</span>
						</s:if>
					</s:iterator>
				</div>
				<!--内页头部导航结束--->

				<div class="n-s-nav n-s-nav-1" id="ns">
					<div class="s-block"></div>
					<ul>
						<s:iterator value="webDistributeTypeList" var="beanT" status="st">
							<li <s:if test="#st.index==0">class="on cur"</s:if>>
								<a href="javascript:void(0)" onclick="xclick(${beanT.id })">${beanT.title}</a>
							</li>
						</s:iterator>
					</ul>
				</div>
				<div class="address-box">
					<div class="address">
						<div class="a-search clearfix">
							<input type="text" id="keyword" value="请输入关键字" />
							<span id="search">&nbsp;</span>
						</div>
						<span class="info">查看网点，请您先选择具体 省市区</span>
						<s:select id="province" name="paramMap.provinceId"
							list="provinceList" listKey="id" listValue="regionName"
							headerKey="-1" headerValue="--请选择--" />
						<s:select id="city" name="paramMap.cityId" list="#{-1:'--请选择--'}" />
						<s:select id="area" name="paramMap.areaId" list="#{-1:'--请选择--'}" />
					</div>
					<div class="map-content">
						<div class="t-map-box">
							<!--<div id="allmap" style="width: 100%; height: 519px;"></div> -->
							 <span id="maps"></span>
						</div>
						<div class="t-map-c">
							<span id="dataInfo"></span>
						</div>
					</div>

				</div>
				<!--网点分布结束-->

			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域content 结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<script type="text/javascript" src="script/commom.js"></script>
		
		<script type="text/javascript"src="http://api.map.baidu.com/api?v=2.0&ak=8227b2e36aa0b645dfd3080b2b748ab7"></script>
	</body>
</html>
