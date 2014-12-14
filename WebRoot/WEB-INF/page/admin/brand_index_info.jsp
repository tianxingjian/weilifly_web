<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
	<div>
		<table id="help" style="width: 100%; color: #333333;"
			cellspacing="1" cellpadding="3" bgcolor="#dee7ef" border="0">
			<tbody>
				<tr class=gvHeader>
					<th style="width: 35px;"  scope="col">
						序号
					</th>
					<th scope="col">
						名称
					</th>
					<th scope="col">
						是否显示
					</th>
					<th scope="col">
						排序
					</th>
					<th scope="col">
						操作
					</th>
				</tr>
				<s:if test="pageBean.page==null || pageBean.page.size==0">
					<tr align="center" class="gvItem">
						<td colspan="4">暂无数据</td>
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
								<s:if test="#bean.status==1">是</s:if>
								<s:elseif test="#bean.status==2">否</s:elseif>
							</td>
							<td align="center">
								${bean.sortIndex}
							</td>
							<td>
								<a href="updateBrandInit.do?id=${bean.id }" target="main">
								编辑
								</a>
								&nbsp;&nbsp;
								<s:if test="#bean.isLevel==1">
									<a href="queryBrandList.do?parentId=${bean.id }" target="main">
									查看二级
									</a>
									&nbsp;&nbsp;
								</s:if>
								<s:if test="#bean.id!=1&&#bean.id!=2&&#bean.id!=3&&#bean.id!=4&&#bean.id!=5">
									<a href="javascript:del(${bean.id })" target="main">
									删除
									</a>
								</s:if>
							</td>
						</tr>
					</s:iterator>
				</s:else>
			</tbody>
		</table>
	</div>
	<shove:page curPage="${pageBean.pageNum}" showPageCount="10" pageSize="${pageBean.pageSize }" theme="jsNumber" totalCount="${pageBean.totalNum}"></shove:page>
