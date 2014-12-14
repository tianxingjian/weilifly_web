<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<script src="script/commom.js"></script>

<dl class="handle">
	<dt>
		<span onclick="checkAll(this); ">全选</span>
	</dt>
	<dd>
		<a href="javascript:downloadMaterials();">批量下载</a>共找到
		<span>${request.count }</span>条资源
	</dd>
</dl>
<table class="dd-list">
	<s:if test="pageBean.page==null || pageBean.page.size==0">
		<tr align="center" class="gvItem">
			<td colspan="4">
				暂无数据
			</td>
		</tr>
	</s:if>
	<s:else>
		<s:iterator value="pageBean.page" var="bean" status="st">
		<tr>
			<td width='56'>
				<span class="check" materialsId="${bean.id }">&nbsp;</span>
			</td>
			<td class="g-pic" width='180'>
				<img src="${paramMap.image}" />
			</td>
			<td class="other" width='397'>
				<div class="tit">
					<a href="#">${bean.name}</a>
				</div>
				<s:iterator value="#bean.parentList.{?#this.materialsId==#bean.id}" var="aBean">
					<span class="fl">${aBean.parentName}：
					<s:iterator value="#bean.childList.{?#this.parentId==#aBean.apId&&#this.materialsId==#bean.id}" var="aBeans">
						${aBeans.childName}
					</s:iterator>
					</span>
				</s:iterator>
				
				<div>
					<!--大小：${bean.size}  -->
				</div> 
				<a href="downloadMaterials.do?id=${bean.id}" class="down-btn">下载</a>
			</td>
			<td width='84'>
				<s:date name="#bean.addTime" format="yyyy-MM-dd" />
			</td>
		</tr>
		</s:iterator>
	</s:else>
</table>
<div class="page-box">
		<shove:page curPage="${pageBean.pageNum}" showPageCount="10"
			pageSize="${pageBean.pageSize }" theme="jsNumberThree"
			totalCount="${pageBean.totalNum}"></shove:page>
</div>
