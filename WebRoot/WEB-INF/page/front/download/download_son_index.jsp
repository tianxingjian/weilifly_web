<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${seoMap.seoTitle}</title>
		<meta name="keywords" content="${seoMap.seoKeyWord}"/>
		<meta name="description" content="${seoMap.seoDescription}" />
		<link href="css/Common.css" type="text/css" rel="stylesheet"/>
		<link href="css/site.css" type="text/css" rel="stylesheet"/>
		<script src="script/jquery-1.11.0.min.js"></script>
		<script src="script/easing.js"></script>
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
		<script type="text/javascript">
			//function productTab(pcId){
			//	window.location.href = "preDownloadIndex.do?a="+pcId;
			//}
			$(function(){
				//$('#pic-list-s').Slider();
				$(".path").click(function(){
					window.location.href = "downloadData.do?filePath="+$(this).attr("path")+"&id="+$("#dId").val();
				});
				
				$("li[name=li]").click(function(){
					$("li[name=li]").removeClass("cur");
					$(this).addClass("cur");
				});
				   $("#pic-list-s").Slider(); 
			});
		</script>
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content1">
			<div class="main-content1" style="border: 0; width: 1000px;">
				<!-- 《精品课件》开始 -->
					<div class="m-s-ban m-s-ban-1">
						《精品课件》
					</div>
					<ul class="down-list">
						<s:iterator value="pageBean.page" var="bean" status="st"><!-- #request.coursewareList -->
							<li>
							<s:hidden name="#bean.id" id="dId"></s:hidden>
								<a href="javascript:;" class="tit">${bean.name}</a>
								<div class="other">
									<span><s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" /></span><a href="javascript:;" class="path" path="${bean.path}">下载</a>
								</div>
							</li>
						</s:iterator>
					</ul>
					<!-- 《精品课件》结束 -->
					
				</div>
			</div>
				<%--
				<!---左侧列表结束--->
				<div class="right-box">
					<div class="m-s-ban m-s-ban-1">
						<a href="advertiseIndex.do">more+</a>案例下载
					</div>
					<s:iterator value="#request.advertiseList" var="bean" status="st">
						<div class="ad-video">
							<a href="#" class="pic"><img src="${bean.image}" /><span
								class="play">播放</span>
							</a>
							<a href="#" class="title">${bean.name}</a>
						</div>
					</s:iterator>

				</div>
			</div>
			
			--%>
		<!--内容区域main-content 结束-->
		
		<div class="page-box">
		<shove:page curPage="${pageBean.pageNum}" showPageCount="10"
			pageSize="${pageBean.pageSize }" theme="jsNumberThree"
			totalCount="${pageBean.totalNum}"></shove:page>
		</div>
		
		<!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<script src="script/commom.js"></script>
		<!--底部结束-->
		<script type="text/javascript">
			$(".down-btn").click(function(){
					window.location.href = "downloadProgram.do?filePath="+$(this).attr("path");
				});
		</script>
		 <script type="text/javascript">
		  $(function(){
		  		$.sideLi(".n-s-nav-1",".s-block");
		  })
		</script>
	</body>
</html>
