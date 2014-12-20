<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.Date"%>
<%@page import="com.shove.web.util.ServletUtils"%>
<%@page import="com.weili.constants.IConstants" %>
<%@ page import="com.shove.web.util.DesSecurityUtil" %>
<%@ page import="com.weili.entity.User" %>
<%@ page import="com.weili.entity.Admin" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib prefix="shove" uri="/shove-tags" %>
 <%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String path = request.getContextPath();
	String temp=request.getServerPort()==80?"":":"+request.getServerPort();
	String basePath = request.getScheme() + "://" + request.getServerName() + temp + path + "/";
	if(application.getAttribute(basePath)==null){
		application.setAttribute("basePath",basePath);
	}
    String remoteAddr = ServletUtils.getIpAddress(request);
	String url = request.getServletPath();
  	org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory.getLog(url);
	log.info(request.getServerName()+"---"+remoteAddr +"==>" + url);
	String pageId = new Date().getTime() + "_" + Math.random();
 	DesSecurityUtil des = new DesSecurityUtil();
%>
