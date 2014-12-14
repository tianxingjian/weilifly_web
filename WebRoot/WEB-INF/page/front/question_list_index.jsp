<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>${seoMap.seoTitle }</title>
		<meta name="keywords" content="${seoMap.seoKeywords }" />
		<meta name="description" content="${seoMap.seoDescription }" />
		<link rel="stylesheet" href="css/Common.css" type="text/css"></link>
		<link href="css/site.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="script/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
		<script type="text/javascript">
	    $(function(){
	    		param["pageBean.pageNum"]="${pageNum}";
		    	initListInfo(param);	
		    	$("#search").click(function(){
		    		param["pageBean.pageNum"] = 1;
		    		initListInfo(param);
		    	});
		    	$(".nav li:eq(4)").attr("class","cur");	   
		    })
	    //加载留言信息
	   function initListInfo(praData) {
	   		var qustion=$("#qustion").val();
	   		if(qustion=="请输入关键字"){
	   			qustion="";
	   		}
	   		praData["name"]=qustion;
	   		$.shovePost("queryQuestionList.do",praData,initCallBack);
   		}
   		
   		function initCallBack(data){
		 	$("#dataInfo").html(data);
   		}
   		
   		//分页
   		function pageInfo(pageId){
   			param["pageBean.pageNum"] = pageId;
   			initListInfo(param);
   		}
		</script>
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<div class="content">
			<div class="main-content">
				<div class="head2">
					<div class="s-block1"></div>
					<ul class="second-nav">
						<s:iterator value="serviceTypeList" var="bean" status="st">
							<li <s:if test="#bean.id==4">class="on cur"</s:if>>
								<a href="${bean.linkPath }">${bean.title }</a>
							</li>
						</s:iterator>
					</ul>
					<s:iterator value="serviceTypeList" var="beans" status="st">
						<s:if test="#beans.id==4">
							<span>${beans.title }</span>
						</s:if>
					</s:iterator>	
				</div>
				<!--内页头部导航结束--->
				<div class="qa-box">
					<div class="a-search clearfix">
						<div class="wp">
							<em>问题搜索：</em>
							<input type="text" value="请输入关键字" id="qustion" />
							<span class="search_btn" id="search">&nbsp;</span>
						</div>
					</div>
					<span id="dataInfo"> </span>
				</div>
			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域content 结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<script type="text/javascript" src="script/commom.js"></script>
		<script type="text/javascript" src="script/easing.js"></script>
		<script type="text/javascript">
		  $(function(){
		  		$(".nav li:eq(4)").attr("class","cur");
			    $.sideLi(".nav",".sliding-block");
		  		$.sideLi(".second-nav",".s-block1");
		  })
		</script>
	</body>
</html>
