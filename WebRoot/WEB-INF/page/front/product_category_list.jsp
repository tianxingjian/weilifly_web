<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<div class="tab-con">
<div class="cp-info-txt" style="display: block;background:url(${paramMap.backImage }) no-repeat;">
	<div class="left">
		<h3>
			${paramMap.name }
		</h3>
		<!--<img src="${paramMap.backImage }" />-->
	</div>
	<div class="right">
	<div style="height:320px;overflow: hidden;" >
		<shove:sub value="paramMap.introduction" size="420" suffix="..."/>
		</div>
		<a href="productDetail.do?id=${paramMap.id }" class="ck">查看详情</a>
	</div>
</div>
</div>
<ul class="cpdb-ul" >
 <li><a href="queryWebDistributeListInit.do" class="s1">售点分布</a></li>
 <li><a href="#" class="s2">电话咨询<span>400-678-0315</span></a></li>
 <li><a href="#" class="s3" style="line-height: 20px;padding: 19px 0 0 117px;">在线咨询<span>${paramNumOneServiceMap.name }</span></a></li>
 <li><a href="${paramMap.url}" class="s4" target="_blank">产品综合讨论区</a></li>
</ul>

