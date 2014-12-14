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
		<div class="content">
			<div class="main-content">
				<div class="head2">
					<span>搜索结果</span>
				</div>
				<!--内页头部导航结束--->
				<div class="qa-box">
					<ul class="ss-jg">
					   <s:if test="pageBean.page!=null&&pageBean.page.size()>0">
					   <s:iterator value="pageBean.page" var="bean" status="st">
							<li>
								<a href="${bean.url}">${bean.title}</a>
							</li>
						</s:iterator>
					   </s:if><s:else>
					        <li>
								没有搜索到包含“<font ><%=java.net.URLDecoder.decode(request.getAttribute("paramMap.keyWord")+"","utf-8")%></font>”相关数据
							</li>
					   </s:else>
						
					</ul>
					<div class="page">
						<shove:page url="querySearch.do"
							curPage="${pageBean.pageNum}" showPageCount="10"
							pageSize="${pageBean.pageSize }" theme="numberFour"
							totalCount="${pageBean.totalNum}">
							<s:param name="paramMap.keyWord"><%=java.net.URLEncoder.encode(request.getAttribute("paramMap.keyWord")+"","utf-8")%></s:param>
						</shove:page>
					</div>
				</div>
				<!--qa-box结束  -->
			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域content 结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<script type="text/javascript" src="script/commom.js"></script>
	</body>
</html>
