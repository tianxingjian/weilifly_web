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
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
		<script src="script/jquery.slider.js"></script>
		<script src="script/easing.js"></script> 

		<script type="text/javascript">
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
			function productTab(pcId){
				$("li[name ^= divCategory_]").hide();
				$("li[name=divCategory_"+pcId+"]").show();
			}

		</script>
	</head>
	<body>
		<!-- 动态包含top开始 -->
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!-- 动态包含top结束 -->
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content3 clearfix" style="border: 0; width: 1000px;">
				<div class="left-box left-box-1">
					
					<!-- 下载专区《行业报告》开始 -->
					<div class="m-s-ban m-s-ban-1">
						<a href="preDownloadIndex.do">more+</a>《行业报告》
					</div>
					<ul class="down-list">
						<s:iterator value="#request.coursewareList" var="bean" status="st">
							<li>
							<s:hidden name="#bean.id" id="dId"></s:hidden>
								<a href="javascript:;" class="tit">${bean.name}</a>
								<div class="other">
									<span><s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" /></span><a href="javascript:;" class="path" path="${bean.path}">下载</a>
								</div>
							</li>
						</s:iterator>
					</ul>
					<!-- 下载专区《行业报告》结束 -->
					
					<!-- 下载专区《精品课件》开始 -->
					<div class="m-s-ban m-s-ban-1">
						<a href="preDownloadIndex.do">more+</a>《精品课件》
					</div>
					<ul class="down-list">
						<s:iterator value="#request.coursewareList" var="bean" status="st">
							<li>
							<s:hidden name="#bean.id" id="cId"></s:hidden>
								<a href="javascript:;" class="tit">${bean.name}</a>
								<div class="other">
									<span><s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" /></span><a href="javascript:;" class="path" path="${bean.path}">下载</a>
								</div>
							</li>
						</s:iterator>
					</ul>
					<!-- 下载专区《精品课件》结束 -->
				</div>
				
				<!---左侧列表结束--->
				<div class="right-box">
					<!-- 下载专区《案例下载》开始 -->
					<div class="m-s-ban m-s-ban-1">
						<a href="advertiseIndex.do">more+</a>《案例下载》
					</div>
					<s:iterator value="#request.advertiseList" var="bean" status="st">
						<div class="ad-video">
							<a href="#" class="pic"><img src="${bean.image}" /><span
								class="play">播放</span>
							</a>
							<!--downloadAndroidMaterials.do?id=${bean.id }   downloadIosMaterials.do?id=${bean.id}
							 -->
							<div class="bk-btn"><a target="_blank" href="${bean.androidPath}"  class="Android">安卓</a>
							<a  target="_blank" href="${bean.iosPath}" class="ios">IOS</a>
							<span class="wx"><em class="img">
							<img src="${maMap.var}"/>
							</em></span></div>
							</div>
					</s:iterator>
					<!-- 下载专区《案例下载》结束 -->
			</div>
		</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
	    <script src="script/commom.js"></script>
		<script type="text/javascript">
		  $(function(){
		  		$(".nav li:eq(2)").addClass("cur");
		  		$.sideLi(".nav",".sliding-block");
		  		$.sideLi(".n-s-nav-1",".s-block","click");
		  });
		</script>
	    <script >
$(function(){
    $(".nav li:eq(2)").addClass("cur");
    $.sideLi(".nav",".sliding-block");
    $.sideLi(".n-s-nav",".s-block");
})

</script>



	</body>
</html>
