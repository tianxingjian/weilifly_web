<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${seoMap.seoTitle}</title>
		<meta name="keywords" content="${seoMap.seoKeyWord}"/>
		<meta name="description" content="${seoMap.seoDescription}" />
		<link href="css/Common.css" type="text/css" rel="stylesheet" />
		<link href="css/site.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<script src="script/easing.js"></script>
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
		<script src="script/jquery.slider.js"></script>
		<script type="text/javascript">
			$(function(){
		    	param["pageBean.pageNum"]=1;
			    initListInfo(param);
			    
			    $("#search").click(function(){
				    param["pageBean.pageNum"] = 1;
					initListInfo(param);
			    });
			    
			    $("a[name=attribute]").click(function(){
			    	$(this).addClass("cur");
			    	var attributeId = $(this).attr("attributeId");
			    	var attributeName = $(this).html();
			    	var aid = $("div[attributeId="+attributeId+"]").attr("attributeId");
			    	if(aid <= 0||aid == ""||aid == null){
			    		$("#condition").append("<div class='item' attributeId='"+attributeId+"' >"+attributeName+"<span>x</span></div>&nbsp;&nbsp;");
			    	}
			    	param["pageBean.pageNum"]=1;
			    	initListInfo(param);
			    	$(".item span").click(function(){
				    	$(this).parent().remove();
				    	var attId = $(this).parent().attr("attributeId");
				    	$("a[name=attribute][attributeId="+attId+"]").removeClass("cur");
				    	param["pageBean.pageNum"]=1;
			    		initListInfo(param);
				    });
			    });
			    
			    $("a[name=no]").click(function(){
			    	$(".item").remove();
			    	$("a[name=attribute]").removeClass("cur");
			    	initListInfo(param);
			    });
			    
			});
		  	function initListInfo(praData) {
		  		var _array = [];
		  		$(".item").each(function(){
		  			_array.push($(this).attr("attributeId"));
		  		});
		  		var keywords = $("#keywords").val();
		  		if(keywords == '请输入关键字/条形码'){
		  			keywords = '';
		  		}
			    praData["id"] = "${paramMap.id}";
				praData["keywords"] = keywords;
				var attributeIds = _array.join(",");
				if(attributeIds == null||attributeIds == ''){
					praData["attributeIds"] = "${request.attributeIds}";
				}else{
					praData["attributeIds"] = attributeIds;
				}
				
				praData["pattributeIds"] = "${request.attributeIds}";
				
		   		$.shovePost("materialsList.do",praData,initCallBack);
	   		}
	   		
	   		function initCallBack(data){
			 	$("#dataInfo").html(data);
	   		}
	   		
	   		//判断是否有选中项
	   		function checked(str){
	   			var c = 0;
	   			$(".check").each( function(){
					if($(this).hasClass("cur0")){
						c = 1;
					}
				});
				if(c==0){
					alert("请先选中您要"+str+"的资料！");
					return false;
				}
				return true;
	   		}
	   		
	   		//下载多个选中项
	   		function downloadMaterials(){
	   			if(!checked("下载")){
	   				return;
	   			}
		 		var adminIds = "";
				$(".check").each( function(i, n){
					if($(n).hasClass("cur0")){
						adminIds += $(n).attr("materialsId")+",";
					}
				});
				adminIds = adminIds.substring(0,adminIds.lastIndexOf(","));
			 	window.location.href = "downloadMaterials.do?id="+adminIds;
	   		}
   		
	   		//全选
	   		function checkAll(e){
		   		if($(e).attr("class")=="cur1"){
		   			$(".check").removeClass("cur0");
		   		}else{
		   			$(".check").addClass("cur0");
		   		}
	   		}
			
		</script>
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content clearfix" style="border: 0; width: 1000px;">
				<div class="left-box left-box-1">
					<div class="m-s-ban1">
						${paramMap.name}
					</div>
					<div class="inner-search clearfix">
						<span class="s1">搜索:</span>
						<input type="text" value="请输入关键字/条形码" id="keywords" pla/>
						<span class="s2" style="cursor: pointer;" id="search">搜索</span>
						<a href="#" class="hover-a">
							 什么是书本条形码?
							<span class="img"><img src="${imageMap.var}"></img></span>
						</a>
					</div>
					<div class="filtrate-box">
						<s:iterator value="#request.attributeList.{?#this.parentId<0}" var="bean" status="st">
							<dl class="filtrate">
								<dt>
									${bean.name}:
								</dt>
								<dd>
									<div class="item-box">
									<a href="javascript:;" name="no">不限</a>
									<s:iterator value="#request.attributeList.{?#this.parentId>0&&#this.parentId==#bean.id}" var="beans" status="sts">
										<a href="javascript:;" name="attribute" attributeId = "${beans.id}">${beans.name}</a>
									</s:iterator>
									</div>
								</dd>
							</dl>
						</s:iterator>
						<dl class="condition">
							<dt>
								已选条件：
							</dt>
							<dd id="condition" >
							</dd>
						</dl>
					</div>
					<span id="dataInfo"></span>
					
				</div>

				<!---左侧列表结束--->
				<div class="right-box">
					<div class="m-s-ban" style="border: 1px solid #e1e1e1;">
						<a href="queryDownloadHelpInit.do">more+</a>下载帮助
					</div>
					<s:iterator value="#request.downloadHelpList" var="bean" status="st">
						<div class="down-item-list">
							<!-- <dt>
								<a href="queryDownloadHelpInit.do?id=${bean.id}">${bean.title}</a>
							</dt>
							<dd>
								适用机型：
								<span>${bean.fit}</span>
							</dd> -->
							<a href="queryDownloadHelpInit.do?id=${bean.id}"><img src="${bean.image }" alt="${bean.title}" style="width:264px;height:73px;" /></a>
						</div>
					</s:iterator>
					<a href="updateProgramIndex.do" class="big-downbtn big-downbtn-1 "><span>升级程序<em>升级程序资源免费下载</em>
					</span>
					</a>
					<div class="m-s-ban m-s-ban-1">
						<a href="advertiseIndex.do">more+</a>App专区
					</div>
					<s:iterator value="#request.advertiseList" var="bean" status="st">
						<div class="ad-video">
							<a href="#" class="pic"><img src="${bean.image}" /><span
								class="play">播放</span>
							</a>
							<!-- <a href="#" class="title">${bean.name}</a> -->
							 <p><a href="downloadMaterials.do?id=${bean.id}" target="_blank"  class="Android">安卓</a>
							 <a href="downloadIosMaterials.do?id=${bean.id}" target="_blank" class="ios">IOS</a>
							 <span class="wx">
							 <em class="img">
							 <img src="upload/image/admin/2014/20140912/201409121640102979.jpg" />
							 </em></span></p>
						</div>
					</s:iterator>
				</div>
			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
		<script type="text/javascript">
			  $(function(){
		  		$(".nav li:eq(2)").addClass("cur");
		  		$.sideLi(".nav",".sliding-block");
		  })
		</script>
	</body>
</html>
