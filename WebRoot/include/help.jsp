<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/taglib.jsp"%>
<div class="left-raea">
	<div class="h3">
		帮助中心
	</div>
	<div class="left-nav ">
		<ul class="nav-item">
			<s:iterator value="infoLists" var="bean" status="st">
				<s:if test="#bean.id==1||#bean.id==5||#bean.id==6">
					<s:if test="#bean.id==#request.a">
						<li class="li">
							<a href="javascript:void(0)" class="check">${bean.name }</a>
					</s:if>
					<s:elseif test="#request.a=='3a'&&#bean.id==5">
						<li class="li">
							<a href="javascript:void(0)" class="check">${bean.name }</a>
					</s:elseif>
					<s:else>
						<li class="li">
							<a href="javascript:void(0)" class="check">${bean.name }</a>
					</s:else>
					<ul class="s2-nav-item" style="display:block;">
						<s:iterator value="lists.{?#this.infoId==#bean.id}" var="beans"
							status="st">
							<s:if test="#bean.id==paramMap.infoId&&#beans.id==paramMap.id">
								<li class="cur">
									<a  href="queryInfoContent.do?id=${beans.id }&a=${beans.infoId }" >${beans.title }</a>
								</li>
							</s:if>
							<s:elseif test="#bean.id==5&&#beans.title=='å®æ¹åå'">
								<li>
									<a href="${beans.linkPath }" target="_blank">${beans.title}</a>
								</li>
							</s:elseif>
							<s:else>
								<li>
									<a href="queryInfoContent.do?id=${beans.id }&a=${beans.infoId }">${beans.title }</a>
								</li>
							</s:else>
						</s:iterator>
						<s:if test="#bean.id==5">
							<s:if test="#request.a=='3a'">
						     <li class="cur">
							</s:if>
							<s:else>
								<li>
							</s:else>
							<a href="mapInit.do?a=3a">帮助中心</a>
							</li>
						</s:if>
					</ul>
					</li>
				</s:if>
			</s:iterator>
		</ul>
	</div>
</div>
<!--å·¦ä¾§å¯¼èªç»æ--->
