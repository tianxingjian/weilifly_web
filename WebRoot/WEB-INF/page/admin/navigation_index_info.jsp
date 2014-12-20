<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
	<div>
		<table id="gvNews" style="width: 100%; color: #333333;"
			cellspacing="1" cellpadding="3" bgcolor="#dee7ef" border="0">
			<tbody>
				<tr class=gvHeader>
					<th style="width: 35px;" scope="col">
						选中
					</th>
					<th scope="col">
						菜单项编号
					</th>
					<th scope="col">
						菜单项名称
					</th>
					<th scope="col">
						菜单等级
					</th>
					<th scope="col">
						所属菜单项
					</th>
					<th scope="col">
						页面url
					</th>
					<th style="width: 150px;" scope="col">
						添加时间
					</th>
					<th style="width: 100px;" scope="col">
						排序
					</th>
					<th style="width: 60px;" scope="col">
						是否显示
					</th>
					<th style="width: 70px;" scope="col">
						操作
					</th>
				</tr>
				<s:if test="pageBean.page==null || pageBean.page.size==0">
					<tr align="center" class="gvItem">
						<td colspan="10">暂无数据</td>
					</tr>
				</s:if>
				<s:else>
				
				<s:iterator value="pageBean.page" var="bean" status="st">
					<tr class="gvItem">
						<td>
							<input id="gvNews_ctl02_cbID" class="navigationBarId" type="checkbox"
								value="${bean.id }" name="gvNews$ctl02$cbID" />
						</td>
						<td align="center">
							${id}
						</td>
						<td align="center">
							${name}
						</td>
						<td>
							${orderName}
						</td>
						<td>
							${parentId}
						</td>
						<td>
							${url}
						</td>
						<td>
							<s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td>
							${sortIndex}
						</td>
						<td>
							${enable==1?'是':'否' }
						</td>
							<td>
							<a href="updateNavigationBarInit.do?id=${bean.id }&pageNow=${pageBean.pageNum}"
								target="main">编辑</a>
							<a id="gvNews_ctl02_lbDelete" style="cursor: pointer;"
								onclick="deleteNavigationBarById(${bean.id },${pageBean.pageNum})">删除</a>
					</td></tr>
				</s:iterator>
				</s:else>
			</tbody>
		</table>
	</div>
	<table style="border-collapse: collapse; border-color: #cccccc"
		cellspacing="1" cellpadding="3" width="100%" align="center" border="1">
		<tbody>
			<tr>
				<td class="blue12" style="padding-left: 8px" align="left">
					<input id="chkAll" onclick="checkAll(this);" type="checkbox"
						value="checkbox" name="chkAll" />
					全选 &nbsp;&nbsp;&nbsp;&nbsp;
					<input id="btnDel" onclick="deleteNavigationBars(${pageBean.pageNum})" type="button"
						value="删除选中记录" name="btnDel" />
				</td>
			</tr>
		</tbody>
	</table>
	<shove:page curPage="${pageBean.pageNum}" showPageCount="10" pageSize="${pageBean.pageSize }" theme="jsNumber" totalCount="${pageBean.totalNum}"></shove:page>
