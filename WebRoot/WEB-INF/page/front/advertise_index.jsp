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
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content" style="border: 0; width: 1000px;overflow:hidden;">
				<div class="left-box left-box-1">
					<div class="m-s-ban1">
						App专区
					</div>
					<ul class="ad-pic-list clearfix">
						<s:iterator value="pageBean.page" var="bean" status="st">
							<li>
								<a href="javascript:;" class="pic"><img src="${bean.image}" />
								</a>
								<div class="tit" title="${bean.title }">
									<a href="javascript:;"><shove:sub value="#bean.name" size="13" suffix=""/> </a>
								</div>
								<div class="bk-btn">
								<a href="downloadAndroidMaterials.do?id=${bean.id}" class="Android">安卓</a>
								<a href="downloadIosMaterials.do?id=${bean.id}" class="ios">IOS</a>
								<span class="wx"><em class="img">
								<img src="${maMap.var}"/>
								</em></span></div>
							</li>
						</s:iterator>
					</ul>
					<div class="page-box">
						<shove:page url="advertiseIndex.do" curPage="${pageBean.pageNum}" showPageCount="5" pageSize="${pageBean.pageSize }" theme="numberFour" totalCount="${pageBean.totalNum}">
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
					<a href="downloadIndex.do" class="big-downbtn  "><span>资料下载<em>学习资源免费下载</em>
					</span>
					</a>
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
		  })
		</script>
	</body>
</html>
