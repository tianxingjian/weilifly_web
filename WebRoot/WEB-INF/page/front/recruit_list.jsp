<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<div class="zp-img"><img src="${imgMap.imgUrl }" /></div>
<div class="zp-list-box">
	<div class="zp-c-wrap">
		<ul class="zp-list" id="jb-list">
			<s:if test="pageBean.page==null || pageBean.page.size==0">
				<tr align="center" class="gvItem">
					<td colspan="8">
						暂无数据
					</td>
				</tr>
			</s:if>
			<s:else>
				<s:iterator value="pageBean.page" var="bean" status="st">
					 <li>
                        <div class="title clearfix">
                            <h3>${bean.name }</h3>
                            <span class="close"><em></em></span> </div>
                        <div class="txt-box"> <em class="arrows"></em>
                            <div class="txt">
                                ${bean.content }
                            </div>
                            <!--txt结束--> 
                        </div>
                    </li>
				</s:iterator>
			</s:else>
		</ul>
		<shove:page url="queryRecruitInit.do" curPage="${pageBean.pageNum}"
			showPageCount="10" pageSize="${pageBean.pageSize }"
			theme="jsNumberThree" totalCount="${pageBean.totalNum}">
		</shove:page>
	</div>
	
	
	<div class="zp-c-wrap" style="display: none">
		<ul class="zp-list">
			<!--校园招聘--->
			<s:if test="pageBean.page==null || pageBean.page.size==0">
				<tr align="center" class="gvItem">
					<td colspan="8">
						暂无数据
					</td>
				</tr>
			</s:if>
			<s:else>
				<s:iterator value="pageBean.page" var="bean" status="st">
					 <li>
                        <div class="title clearfix">
                            <h3>${bean.name }</h3>
                            <span class="close"><em></em></span> </div>
                        <div class="txt-box"> <em class="arrows"></em>
                            <div class="txt">
                                ${bean.content }
                            </div>
                            <!--txt结束--> 
                        </div>
                    </li>
				</s:iterator>
			</s:else>
		</ul>
		<!-- <div class="page-box"> -->
			<shove:page url="queryRecruitInit.do" curPage="${pageBean.pageNum}"
				showPageCount="10" pageSize="${pageBean.pageSize }" theme="jsNumberThree"
				totalCount="${pageBean.totalNum}">
			</shove:page>
		<!-- </div> -->
	</div>

	
</div>
