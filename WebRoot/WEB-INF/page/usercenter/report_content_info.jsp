<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<div class="zp-nav-1">
	<s:iterator value="#request.reportCategoryList" var="beans" status="st">
		<s:if test="#request.caId==#beans.id">
			<span class="cur"> <a
				href="javascript:checkItem('','','${beans.id}',1)">${beans.name}</a>
			</span>
		</s:if>
		<s:else>
			<span> <a href="javascript:checkItem('','','${beans.id}',1)">${beans.name}</a>
			</span>
		</s:else>

	</s:iterator>
</div>
<div class="m-zjbg-box">
	<table class="m-zjbg" border="1" style="display: block;">
		<tr>
			<th width="379">
				标题
			</th>
			<th width="120">
				日期
			</th>
			<th width="120">
				作者
			</th>
			<th width="188">
				下载
			</th>
		</tr>
		<s:iterator value="pageBean.page" var="bean" status="st">
			<tr>
				<td class="title">
					${bean.title}
				</td>
				<td>
					<s:date name="#bean.addTime" format="yyyy-MM-dd" />
				</td>
				<td>
					${bean.author}
				</td>
				<td>
					<a
						href="javascript:checkItem(this,'${bean.id}','${bean.categoryId}',3);"><span
						class="btn">查看详细</span> </a><a
						href="downloadFiles.do?fileName=re.txt&id=${id}"><span
						class="btn1">下载</span> </a>
				</td>
			</tr>
		</s:iterator>
		
		<tr>
		<td colspan="4" class="page-row">
			<shove:page 
					curPage="${pageBean.pageNum}" showPageCount="10"
					pageSize="${pageBean.pageSize }" theme="jsNumberThree"
					totalCount="${pageBean.totalNum}">
				</shove:page>
		    <s:hidden  id="page_num" name="pageBean.pageNum"> </s:hidden>		
           <script type="text/javascript" src="script/commom.js"></script>
		</td>
	</tr>
	</table>
		     
</div>

