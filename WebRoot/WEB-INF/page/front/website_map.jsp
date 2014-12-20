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
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="script/easing.js"></script>
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<div class="content" style="background: #fff;">
			<div class="main-content clearfix" style="border: none;">
				<jsp:include page="/include/help.jsp"></jsp:include>
				<!--左侧导航结束--->
				<div class="right-raea x">
					<div class="h3">
						网站地图
					</div>
					<dl class="web-map">
						<dt>
							微力研究院
						</dt>
						<dd>
							<s:iterator value="#request.brandList" var="beanB" status="st">
								<a href="brandDetail.do?id=${beanB.id }">${beanB.name }</a>
							</s:iterator>
						</dd>
					</dl>
					<dl class="web-map">
						<dt>
							O2O兵器库
						</dt>
						<dd>
							<s:iterator value="#request.categoryList" var="beanP" status="st">
								<a href="productIndex.do?id=${beanP.id }">${beanP.name }</a>
							</s:iterator>
						</dd>
					</dl>
					<dl class="web-map">
						<dt>
							下载专区
						</dt>
						<dd>
							<a href="downloadIndex.do">资料下载</a>
							<%--
								<a href="queryDownloadHelpInit.do">下载帮助</a>
								<a href="preDownloadIndex.do">升级程序</a>
							--%>
						</dd>
					</dl>
					<dl class="web-map">
						<dt>
							微力论坛
						</dt>
					</dl>
					<%--<dl class="web-map">
						<dt>
							服务
						</dt>
						<dd>
							<a href="queryOnline.do">在线支持</a><a
								href="queryWebDistributeListInit.do">网点分布</a><a
								href="queryQuestionListInit.do">常见问题</a><a
								href="downloadIndex.do">下载方法</a>
							<a href="queryServicePolicy.do">服务政策</a>
						</dd>
					</dl>
					--%>
					<dl class="web-map">
						<dt>
							关于我们
						</dt>
						<dd>
							<s:iterator value="#request.infoContentList2" var="beanA"
								status="st">
								<a href="queryInfoContent.do?id=${beanA.id }&a=${beanA.id }">${beanA.title }</a>
							</s:iterator>
							
							<a href="queryRecruitInit.do?a=2a">人才招聘</a>
						</dd>
					</dl>
					<dl class="web-map">
						<dt>
							版权声明
						</dt>
						<dd>
							<s:iterator value="#request.infoContentList" var="beanI"
								status="st">
								<a href="queryInfoContent.do?id=${beanI.id }&a=${beanI.id }">${beanI.title }</a>
							</s:iterator>
						</dd>
					</dl>
					<dl class="web-map">
						<dt>
							联系我们
						</dt>
						<dd>
							<s:iterator value="#request.infoContentList3" var="beanS"
								status="st">
								<s:if test="#beanS.title=='官方商城'">
									<a href="${beanS.linkPath }" target="_blank">${beanS.title}</a>
								</s:if>
								<s:else>
									<a href="queryInfoContent.do?id=${beanS.id }&a=${beanS.id }">${beanS.title }</a>
								</s:else>
							</s:iterator>
						</dd>
					</dl>
				</div>
				<!--右侧导航结束--->
			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域content 结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<script type="text/javascript" src="script/commom.js"></script>
	</body>
</html>
