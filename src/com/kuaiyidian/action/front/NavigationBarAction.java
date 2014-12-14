package com.kuaiyidian.action.front;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.kuaiyidian.constants.IConstants;
import com.kuaiyidian.service.NavigationBarService;

public class NavigationBarAction extends BaseFrontAction {
	public static Log log = LogFactory.getLog(NavigationBarAction.class);
	private NavigationBarService navigationBarService;

	
	public String navigationBar() throws Exception {
		List<Map<String,Object>> navigationBarFirstList = navigationBarService.queryNavigationBarList(IConstants.PARENT_BAR, IConstants.STATUS_ON);
		
		log.info(navigationBarFirstList.toString());
		request().setAttribute("navigationBarFirstList", navigationBarFirstList);
	
		return SUCCESS;
	}
	
	
	
	public NavigationBarService getNavigationBarService() {
		return navigationBarService;
	}

	public void setNavigationBarService(NavigationBarService navigationBarService) {
		this.navigationBarService = navigationBarService;
	}
	
	
}
