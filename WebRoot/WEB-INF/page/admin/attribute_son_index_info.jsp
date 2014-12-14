<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<div>
	<table id="gvNews" style="width: 100%; color: #333333;" cellspacing="1"
		cellpadding="3" bgcolor="#dee7ef" border="0">
		<tbody>
			<tr class=gvHeader>
				<th scope="col">
					序号
				</th>
				<th scope="col">
					答案
				</th>
				<th scope="col">
					关联问题
				</th>
				<th scope="col">
					获得类型
				</th>
				<th scope="col">
					操作
				</th>
			</tr>
			<s:if test="pageBean.page==null || pageBean.page.size==0">
				<tr align="center" class="gvItem">
					<td colspan="6">
						暂无数据
					</td>
				</tr>
			</s:if>
			<s:else>

				<s:iterator value="pageBean.page" var="bean" status="st">
					<tr class="gvItem">
						<td>
							${st.count}
						</td>
						<td align="center">
							${bean.name}
						</td>
						<td align="center">
							<s:if test="#bean.qid==-1">结束问题</s:if>
							<s:elseif test="#bean.qid>0">到-->${bean.questionIndex}</s:elseif>
						</td>
						<td align="center">
							${bean.typeName==null?'--':bean.typeName}
						</td>
						<td>
							<a
								href="updateQuestionInit.do?id=${bean.id }&parentId=${bean.parentId }"
								target="main"> 编辑</a>
							<a id="gvNews_ctl02_lbDelete" style="cursor: pointer;"
								href="javascript:del(${bean.id },${bean.parentId })">删除</a>

						</td>
					</tr>
				</s:iterator>
			</s:else>
		</tbody>
	</table>
</div>
<shove:page curPage="${pageBean.pageNum}" showPageCount="10"
	pageSize="${pageBean.pageSize }" theme="jsNumber"
	totalCount="${pageBean.totalNum}"></shove:page>
