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
			function productTab(pcId){
				window.location.href = "updateProgramIndex.do?a="+pcId;
			}
		</script>
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content" style="border: 0; width: 1000px;">
				<div class="left-box left-box-1">
					<div class="m-s-ban1">
						升级程序
					</div>
					<div class="n-s-nav n-s-nav-1">
						<div class="s-block"></div>
						<ul>
							<s:iterator value="#request.categoryList" var="bean" status="st">
								<li <s:if test="#request.categoryId==#bean.id">class="cur"</s:if> name="li" >
									<a href="javascript:productTab(${bean.id});" class="pcp" >${bean.name}</a>
								</li>
							</s:iterator>
						</ul>
					</div>
					<div class="Update-wrap">
						<div class="Update-box">
							<ul>
							<s:iterator value="pageBean.page" var="bean" status="st">
								<li style="padding-bottom: 30px;">
									<a href="javascript:;" class="pic"><img src="${bean.image}" />
									</a>
									<div class="tit" title="${bean.name}">
										<a href="javascript:;"><shove:sub value="#bean.name" size="13" suffix=""/> </a>
									</div>
									<div class="time">
										<s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" />
									</div>
									<a href="javascript:;" path="${bean.path}" class="down-btn">下载</a>
								</li>
							</s:iterator>
							</ul>
						</div>
								<shove:page url="updateProgramIndex.do" curPage="${pageBean.pageNum}" showPageCount="5" pageSize="${pageBean.pageSize }" theme="numberFour" totalCount="${pageBean.totalNum}">
									<s:param name="a" >${request.categoryId}</s:param>
								</shove:page>
					</div>
					
				</div>
				<!---左侧列表结束--->
				<div class="right-box">
					<div class="m-s-ban" style="border: 1px solid #e1e1e1;">
						<a href="queryDownloadHelpInit.do">more+</a>下载帮助
					</div>

					<s:iterator value="#request.downloadHelpList" var="bean" status="st">
						<div class="down-item-list">
							<!-- <dt>
								<a href="queryDownloadHelpInit.do?id=${bean.id}"><img src="${bean.image }" alt="${bean.title}" style="width:57px;height:57px;" /></a>
							</dt>
							<dd>
								适用机型：
								<span title="${bean.fit}">${bean.fit}</span>
							</dd> -->
							<a href="queryDownloadHelpInit.do?id=${bean.id}"><img src="${bean.image }" alt="${bean.title}" style="width:264px;height:73px;" /></a>
						</div>
					</s:iterator>

					<div class="m-s-ban m-s-ban-1">
						<a href="advertiseIndex.do">more+</a>广告片
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
			
			<!--内容区域main-content 结束-->
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
