package com.shove.web.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.shove.vo.HelpMessage;

/**
 * action的基类
 *
 */
public class BaseAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	//页面表单存放数据
	protected Map<String, String> paramMap = new HashMap<String, String>();
	protected HelpMessage helpMessage = new HelpMessage();
	protected HttpServletRequest request(){
		return ServletActionContext.getRequest();
	}
	
	protected String request(String key){
		return request().getParameter(key);
	}
	
	protected void request(String key,Object value){
		request().setAttribute(key, value);
	}
	
	protected HttpSession session(){
		return ServletActionContext.getRequest().getSession();
	}
	
	protected Object session(String key){
		return session().getAttribute(key);
	}
	
	protected void session(String key,Object value){
		session().setAttribute(key, value);
	}
	
	protected ServletContext application(){
		return ServletActionContext.getServletContext();
	}
	
	protected HttpServletResponse response(){
		return ServletActionContext.getResponse();
	}
	
	public Map<String, String> getParamMap() {
		return paramMap;
	}
	
	public void setParamMap(Map<String, String> paramMap) {
		this.paramMap = paramMap;
	}
	
	public HelpMessage getHelpMessage() {
		return helpMessage;
	}
	
	public void setHelpMessage(HelpMessage helpMessage) {
		this.helpMessage = helpMessage;
	}
	
}
