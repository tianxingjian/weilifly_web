package com.weili.system.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class ConfigiListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	public void contextInitialized(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();
		//context.setAttribute(name, object)设置到application中
		WebApplicationContext webApplicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		//webApplicationContext.getBean("");可以获取到Spring注入
		
		// TODO 查询所有需要记录日志的数据放入application
		// TODO 查询所有需要拦截权限的数据放入application
		// TODO 查询后台功能模块放入application
		
	}
}
