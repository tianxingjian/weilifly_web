<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
	<div>
		<table id="help" style="width: 100%; color: #333333;"
			cellspacing="1" cellpadding="3" bgcolor="#dee7ef" border="0">
			<tbody>
				<tr class=gvHeader>
					<th style="width: 35px;"  scope="col">
						选中
					</th>
					<th scope="col">
						标题
					</th>
					<th scope="col">
						是否显示
					</th>
					<th scope="col">
						是否推荐
					</th>
					<th scope="col">
						是否首页推荐
					</th>
					<!--<th scope="col">
						排序
					</th>-->
					<th scope="col">
						添加时间
					</th>
					<th scope="col">
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
								<input id="gvNews_ctl02_cbID" class="objId" type="checkbox"
									value="${bean.id }" name="cb_ids" />
							</td>
							<td align="center">
								${bean.title}
							</td>
							<td align="center">
								<s:if test="#bean.status==1">是</s:if>
								<s:elseif test="#bean.status==2">否</s:elseif>
							</td>
							<td align="center">
								<s:if test="#bean.isRecommended==1">是</s:if>
								<s:elseif test="#bean.isRecommended==2">否</s:elseif>
							</td>
							<td align="center">
								<s:if test="#bean.isIndex==1">是</s:if>
								<s:elseif test="#bean.isIndex==2">否</s:elseif>
							</td>
							<!--<td align="center">
								${bean.sortIndex}
							</td>-->
							<td align="center">
								<s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" />
							</td>
							<td>
								<a href="updateDisplayInit.do?id=${bean.id }" target="main">
								修改
								</a>
								&nbsp;&nbsp;
								<a href="javascript:del(${bean.id })" target="main">
								删除
								</a>
							</td>
						</tr>
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
					<input id="chkAll" onclick="checkAll(this); " type="checkbox" value="checkbox" name="chkAll" />
					全选 &nbsp;&nbsp;&nbsp;&nbsp;
					<input id="btnDel" onclick="dels();" type="button"
						value="删除选中记录" name="btnDel" />
				</td>
			</tr>
		</tbody>
	</table>
	<shove:page curPage="${pageBean.pageNum}" showPageCount="10" pageSize="${pageBean.pageSize }" theme="jsNumber" totalCount="${pageBean.totalNum}"></shove:page>
