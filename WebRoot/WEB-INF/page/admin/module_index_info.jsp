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
					<th style="width: 60px;" scope="col">
						模块编号
					</th>
					<th style="width: 150px;" scope="col">
						模块名称
					</th>
					<th style="width: 200px;" scope="col">
						模块行为
					</th>
					<th style="width: 60px;" scope="col">
						所属模块
					</th>
					<th>
						模块描述
					</th>
					<th style="width: 60px;" scope="col">
						排序
					</th>
					<th style="width: 60px;" scope="col">
						权限分配
					</th>
					<th style="width: 60px;" scope="col">
						是否启用
					</th>
					<th style="width: 60px;" scope="col">
						记录日志
					</th>
					<th style="width: 70px;" scope="col">
						操作
					</th>
				</tr>
				<s:if test="pageBean.page==null || pageBean.page.size==0">
					<tr align="center" class="gvItem">
						<td colspan="11">暂无数据</td>
					</tr>
				</s:if>
				<s:else>
				
				<s:iterator value="pageBean.page" var="bean" status="st">
					<tr class="gvItem">
						<td>
							<input id="gvNews_ctl02_cbID" class="moduleId" type="checkbox"
								value="${bean.id }" name="gvNews$ctl02$cbID" />
						</td>
						<td align="center">
							${id}
						</td>
						<td align="center">
							${summary}
						</td>
						<td>
							${action}
						</td>
						<td>
							${parentId}
						</td>
						<td>
							${description}
						</td>
						<td>
							${indexs}
						</td>
						<td>
							${isIntercept==1?'允许':'拦截' }
						</td>
						<td>
							${isQuery==1?'启用':'禁用' }
						</td>
						<td>
							${isLog==1?'记录':'忽略' }
						</td>
							<td>
							<a href="updateModuleInit.do?id=${bean.id }&pageNow=${pageBean.pageNum}"
								target="main">编辑</a>
							<a id="gvNews_ctl02_lbDelete" style="cursor: pointer;"
								onclick="deleteModuleById(${bean.id },${pageBean.pageNum})">删除</a>
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
					<input id="btnDel" onclick="deleteModules(${pageBean.pageNum})" type="button"
						value="删除选中记录" name="btnDel" />
				</td>
			</tr>
		</tbody>
	</table>
	<shove:page curPage="${pageBean.pageNum}" showPageCount="10" pageSize="${pageBean.pageSize }" theme="jsNumber" totalCount="${pageBean.totalNum}"></shove:page>
