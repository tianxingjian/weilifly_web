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
						姓名/公司名
					</th>
					<th scope="col">
						手机号
					</th>
					<th scope="col">
						地址
					</th>
					<th scope="col">
						需求类型
					</th>
					<th scope="col">
						需求描述
					</th>
					<th scope="col">
						备注
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
								<input id="gvNews_ctl02_cbID" class="objId" type="checkbox"
									value="${bean.id }" name="cb_ids" />
							</td>
							<td align="center">
								${bean.cName}
							</td>
							<td align="center">
								${bean.cTelephone}
							</td>
							<td align="center">
								${bean.address}
							</td>
							<td align="center">
								${bean.needStatus}
							</td>
							<td align="center">
								${bean.needContent}
							</td>
							<td align="center">
								${bean.remark}
							</td>
							<td>
								<a href="addRemarkInit.do?id=${bean.id }" target="main">
									备注
								</a>&nbsp;&nbsp;
								<%--<a href="#" target="main"><!-- updateDemoInit.do?id=${bean.id } -->
									修改
								</a>
								&nbsp;&nbsp;
								--%><a href="javascript:del(${bean.id })" target="main">
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
