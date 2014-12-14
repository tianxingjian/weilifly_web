<%@page import="com.sun.org.apache.xml.internal.serialize.Printer"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/taglib.jsp"%>
		<link rel="shortcut icon"  href="/images/favicon.ico"  />
		<link type="text/css" href="css/style.css" rel="stylesheet"/>
		<link type="text/css" href="css/base.css" rel="stylesheet" />
		<link type="text/css" href="css/framework.css" rel="stylesheet"/>
		<link rel="stylesheet" href="css/noscript.css" media="screen,all" id="noscript" />
<div class="suspend-box">
   <div class="jt" id="jt"></div>
   <ul class="sus-ul">
      <s:if test="helMap.shopStatus==1">
      <li style="background:url(${helMap.shopImg}) #fff;" ><a href="${helMap.shopUrl}" target="_blank">${helMap.shopTitle}</a></li>
     </s:if>
     <s:if test="helMap.serviceStatus==1">
      <li style="background:url(${helMap.serviceImg}) #fff;"><a href="${helMap.serviceUrl }" target="_blank">${helMap.serviceTitle}</a></li>
      </s:if>
   </ul>
</div>
<div class="back-top" title="返回顶部"></div>
<div class="head-box">
	<div class="head">
				<a href="index.do" class="logo">微力科技，为企业插上微翅膀，让生意更轻松</a>
				<div id="mainmenu">
					<div class="sliding-block"></div>
					<ul id="menu">
						<!-- <li class="selected dropdown"><a href="index.do">首页</a>
							<ul>
								<li><a href="#">方法论</a>
								</li>
								<li><a href="#">最连续沙龙</a>
								</li>
								<li><a href="#">必读书籍</a>
								</li>
							</ul>
						</li>
						<li>微力研究院
							<ul>
								<li><a href="#">方法论</a>
								</li>
								<li><a href="#">最连续沙龙</a>
								</li>
								<li><a href="#">必读书籍</a>
								</li>
							</ul>
						</li>
						<li>O2O兵器库
							<ul>
								<li><a href="#">O2O型网站</a>
								</li>
								<li><a href="#">O2O型商城</a>
								</li>
								<li><a href="#">手机APP</a>
								</li>
								<li><a href="#">腾讯系列</a>
								</li>
								<li><a href="#">阿里系列</a>
								</li>
								<li><a href="#">百度系列</a>
								</li>
							</ul>
						</li>
						<li><a href="#">标杆案例</a>
							<ul>
								<li><a href="#"> 专业市场</a>
								</li>
								<li><a href="#"> 传统商户</a>
								</li>
							</ul>
						</li>
						<li>下载专区
							<ul>
								<li><a href="#">精品课件</a>
								</li>
								<li><a href="#">精品视频</a>
								</li>
								<li><a href="#">行业报告</a>
								</li>
								<li><a href="#">案例下载</a>
								</li>
							</ul>
						</li>
						<li><a href="#">微力论坛</a>
						</li> -->
					</ul>
				</div>
			</div>
</div>
<!--头部外围盒子结束 head-box-->