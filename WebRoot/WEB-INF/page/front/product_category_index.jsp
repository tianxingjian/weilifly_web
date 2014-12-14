<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${seoMap.seoTitle }</title>
		<meta name="keywords" content="${seoMap.seoKeyWord}"/>
		<meta name="description" content="${seoMap.seoDescription}" />
		<link href="css/Common.css" type="text/css" rel="stylesheet"/>
		<link href="css/site.css" type="text/css" rel="stylesheet"/>
		<script src="script/jquery-1.11.0.min.js"></script>
		<script src="script/easing.js"></script>
		<script src="script/jquery.slider.js"></script>
	    
		<script>
		var param = {};
  		$(function(){
          $("#cp-syn-box").Slider({
           	preid:"cp-pre",
			nextid:"cp-next",
            moveparent:".cp-syn",
            movechildren:"li",
            v:4
          }); 
          
		  initListInfo(param);
		  
		  $("li[name=category]").click(function(){
		  	$("li[name=category]").removeClass("cur");
		  	$(this).addClass("cur");
		    param["id"] = $(this).attr("category");
			initListInfo(param);
		  });
	    })
	    
	    function initListInfo(praData) {
	   		$.post("queryCategoryInfo.do",praData,initCallBack);
   		}
   		
   		function initCallBack(data){
		 	$("#dataInfo").html(data);
   		}
	  
</script>
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content main-content-1">
			 <div class="cp-syn-box" id="cp-syn-box">
				<ul class="cp-syn">
					<s:iterator value="#request.categoryList" var="bean" status="st">
						<li <s:if test="#st.index==0">class="cur"</s:if> name="category" category="${bean.id}">
							<img src="${bean.image }" />
							<div>
								${bean.name }
							</div>
							<em class="x"></em>
						</li>
					</s:iterator>
				</ul>
			 <div class="cp-pre s" id="cp-pre"></div>
		     <div class="cp-next s" id="cp-next"></div>
		    </div>
		    <div id="dataInfo">
				
		    </div>
			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
			<script src="script/commom.js"></script>
	</body>
</html>
