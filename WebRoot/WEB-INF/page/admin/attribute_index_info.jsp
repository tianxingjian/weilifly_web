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
					模块
				</th>
				<th scope="col">
					排序
				</th>
				<th scope="col">
					是否显示
				</th>
				<s:if test="#request.parentId>0"></s:if>
				<s:else>
					<th scope="col">
						属性管理
					</th>
				</s:else>

				<th scope="col">
					操作
				</th>
			</tr>
			<s:if test="pageBean.page==null || pageBean.page.size==0">
				<tr align="center" class="gvItem">
					<td colspan="10">
						暂无数据
					</td>
				</tr>
			</s:if>
			<s:else>

				<s:iterator value="pageBean.page" var="bean" status="st">
					<tr class="gvItem">
						<td>
							${st.count }
						</td>
						<td align="center">
							${bean.name}
						</td>
						<td align="center">
							${bean.sortIndex}
						</td>
						<td align="center">
							<s:if test="#bean.status==1">是</s:if>
							<s:elseif test="#bean.status==2">否</s:elseif>
						</td>
						<s:if test="#request.parentId>0"></s:if>
						<s:else>
							<td>
								<a href="queryAttributeSonInit.do?parentId=${bean.id }"
									target="main" style="color: blue">属性管理</a>
							</td>
						</s:else>
						<td>
							<a
								href="updateAttributeInit.do?id=${bean.id }&parentId=${bean.parentId }"
								target="main"> 编辑</a>
							<s:if test="#bean.id!=4">
								<a id="gvNews_ctl02_lbDelete" style="cursor: pointer;"
									href="javascript:del(${bean.id },${bean.parentId })">删除</a>
							</s:if>
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
