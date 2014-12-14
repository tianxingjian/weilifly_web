<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${seoMap.seoTitle}</title>
<meta name="keywords" content="${seoMap.seoKeyWord}"/>
<meta name="description" content="${seoMap.seoDescription}" />
<link href="css/Common.css" type="text/css" rel="stylesheet"/>
<link href="css/site.css" type="text/css" rel="stylesheet"/>
<script src="script/jquery-1.11.0.min.js"></script>
<script src="script/easing.js"></script>
</head>
<body>
<jsp:include page="/include/top.jsp"></jsp:include>
<!--头部外围盒子结束 head-box-->
<div class="content">
  <div class="main-content" style="border:0; width:1000px;">
    <div class="left-box">
     <div class="m-s-ban">下载帮助</div>
     <div class="n-s-nav">
       <div class="s-block"></div>
       <ul>
       <s:iterator value="#request.queryDownloadHelpsList" var="bea" status="sta">
       <s:if test="#request.caId==#beans.categoryId" >
       <li><a href="queryDownloadHelpInit.do?id=${bea.id}&categoryId=${bea.categoryId}" >${bea.title}</a></li>
       </s:if>
     <s:else>
     <li <s:if test="#request.helpMap.id==#bea.id" >class="cur"</s:if> ><a href="queryDownloadHelpInit.do?id=${bea.id}">${bea.title}</a></li>
     </s:else>
        </s:iterator>
       </ul>
     </div>
     <div class="txt">${helpMap.content}</div>
     </div>
     <div class="right-box">
     <div class="m-s-ban" style="border:1px solid #e1e1e1;"> <a href="updateProgramIndex.do">more+</a>升级程序</div>
     <s:iterator  value="#request.queryDownloadHelpList"  var="bean"  status="sta">
       <dl class="down-item" align="left">
         <dt><a href="#"><img src="${bean.image }"/></a></dt>
         <dd><a href="#" class="title">${bean.name}</a><a href="javascript:;" class="down-btn"  path="${bean.path}">下载</a></dd>
       </dl>
       </s:iterator>
       <a href="downloadIndex.do" class="big-downbtn"><span>资料下载<em>学习资源免费下载</em></span></a>
        <div class="m-s-ban" style="border:1px solid #e1e1e1;"> <a href="advertiseIndex.do">more+</a>广告片</div>
        <s:iterator value="#request.queryAdvertList" var="beann" status="sta">
        <div class="ad-video">
        <a href="#" class="pic"><img src="${beann.image}"/><span class="play">播放</span></a>
        <a href="#" class="title">${beann.name}</a>
        </div>
        </s:iterator>
     </div>
  </div><!--内容区域main-content 结束--> 
</div>
<!--内容区域content 结束-->
<jsp:include page="/include/footer.jsp"></jsp:include>
<!--底部结束-->
<script src="script/commom.js"></script>
<script>
$(function(){
    $(".nav li:eq(2)").addClass("cur");
    $.sideLi(".nav",".sliding-block");
    $.sideLi(".n-s-nav",".s-block");
    
    $(".down-btn").click(function(){
		window.location.href = "downloadProgram.do?filePath="+$(this).attr("path");
	});
})


</script>
</body>
</html>
