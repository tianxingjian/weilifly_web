package com.weili.action.front;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.weili.constants.IConstants;
import com.weili.service.NavigationBarService;
import com.opensymphony.xwork2.ActionSupport;

public class FrontNavigationBarAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static Log log = LogFactory.getLog(FrontNavigationBarAction.class);
	private NavigationBarService navigationBarService;
	
	public String navigationBar() throws Exception {
		//导航列表
		List<Map<String,Object>> navigationBarListAll = new ArrayList<Map<String,Object>>();
		//所有菜单导航项
		//List<Map<String,Object>> navigationBar = navigationBarService.queryNavigationBarListAll(IConstants.ENABEL_ON);
		//一级导航列表
		List<Map<String,Object>> navigationBarFirst = navigationBarService.queryNavigationBarFirstList(IConstants.PARENT_BAR,IConstants.ENABEL_ON);//一级	
		//二级导航列表
		List<Map<String,Object>> navigationBarSecond = null;
		//循环遍历检索
		//遍历一级导航
		for(Map<String,Object> map:navigationBarFirst){
			navigationBarListAll.add(map);//加入一级菜单项
			long id = Long.parseLong(map.get("id").toString());
			//检索二级导航
			navigationBarSecond = navigationBarService.queryNavigationBarSencondList(id, IConstants.ENABEL_ON);
			if(null!=navigationBarSecond&&navigationBarSecond.size()>0){
				navigationBarListAll.addAll(navigationBarSecond);
			}
		}
		
		//转json
		String navigationBarJson=JSONArray.fromObject(navigationBarListAll).toString(); 
		log.info(navigationBarJson);
		
		HttpServletResponse response = ServletActionContext.getResponse();  
		response.reset(); 
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter writer = response.getWriter(); 
		writer.print(navigationBarJson);
		writer.flush(); 
		writer.close(); 
		return null;
		//request().setAttribute("navigationBarJson", navigationBarList);	
	}
	
	
	public NavigationBarService getNavigationBarService() {
		return navigationBarService;
	}

	public void setNavigationBarService(NavigationBarService navigationBarService) {
		this.navigationBarService = navigationBarService;
	}
	
}
