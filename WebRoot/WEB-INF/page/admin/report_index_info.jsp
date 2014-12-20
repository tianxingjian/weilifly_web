<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<div>
	<table id="gvNews" style="width: 100%; color: #333333;" cellspacing="1"
		cellpadding="3" bgcolor="#dee7ef" border="0">
		<tbody>
			<tr class=gvHeader>
				<th style="width: 35px;" scope="col">
					选中
				</th>
				<th scope="col">
					标题
				</th>
				<th scope="col">
					分类
				</th>
				<th scope="col">
					作者
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
					<td colspan="8">
						暂无数据
					</td>
				</tr>
			</s:if>
			<s:else>

				<s:iterator value="pageBean.page" var="bean" status="st">
					<tr class="gvItem">
						<td>
							<input id="gvNews_ctl02_cbID" class="adminId" type="checkbox"
								value="${bean.id }" name="gvNews$ctl02$cbID" />
						</td>
						<td align="center">
							${title}
						</td>
						<td>
							${name }
						</td>
						<td>
							${author }
						</td>
						<td>
							<s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td>
							${bean.sortIndex }
						</td>
						<td>
							${status==1?'是':'否' }
						</td>
						<td>
							<a
								href="updateReportInit.do?id=${bean.id }&pageNow=${pageBean.pageNum}"
								target="main"> 编辑</a>
							<a id="gvNews_ctl02_lbDelete" style="cursor: pointer;"
								onclick="deleteReportById(${bean.id },${pageBean.pageNum})">删除</a>
						</td>
					</tr>
				</s:iterator>
			</s:else>
			<tr align="center">
				<td colspan="7">
					<div style="font-size: 13px;">
						<shove:page curPage="${pageBean.pageNum}" showPageCount="10"
							pageSize="${pageBean.pageSize }" theme="jsNumber"
							totalCount="${pageBean.totalNum}"></shove:page>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<table style="border-collapse: collapse; border-color: #cccccc"
	cellspacing="1" cellpadding="3" width="100%" align="center" border="1">
	<tbody>
		<tr>
			<td class="blue12" style="padding-left: 8px" align="left">
				<input id="chkAll" onclick="checkAll(this); " type="checkbox"
					value="checkbox" name="chkAll" />
				全选 &nbsp;&nbsp;&nbsp;&nbsp;
				<input id="btnDel" onclick="deleteReport();}}" type="button"
					value="删除选中记录" name="btnDel" />
			</td>
		</tr>
	</tbody>
</table>
