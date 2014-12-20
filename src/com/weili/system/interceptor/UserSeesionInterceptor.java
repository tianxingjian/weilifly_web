package com.weili.system.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.weili.constants.IConstants;
import com.weili.entity.User;

/**
 * 用户登录拦截
 * 
 * @author 杨程
 * @Create Jun 3, 2011
 * 
 */
public class UserSeesionInterceptor implements Interceptor {
	public static Log log = LogFactory.getLog(UserSeesionInterceptor.class);
	private static final long serialVersionUID = 1L;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private HttpSession session;
	
	public void destroy() {
	}

	public void init() {
	}

	public String intercept(ActionInvocation invocation) throws Exception {
		request = ServletActionContext.getRequest();
		response = ServletActionContext.getResponse();
		session = request.getSession();
		String retUrl = request.getHeader("Referer");  
		log.info("-------------------"+retUrl);
		log.info(request.getRequestURL());
		if(!IConstants.USER_SESSION_SWITCH){
			 return invocation.invoke();
			 }
			if (isAjaxRequest()) {
				return ajaxIntercept(invocation);
			}
			return _intercept(invocation);
	}

	// 普通请求拦截 没登录返回 noLogin 登录流程继续
	private String _intercept(ActionInvocation invocation) throws Exception {
		log.info("普通请求拦截");
		User user = (User) session.getAttribute(IConstants.SESSION_USER);
		if (null == user) {
			int index=request.getContextPath().length()+1;
			String uri=request.getRequestURI().substring(index);
			log.info("No Login");
			return IConstants.ADMIN_AJAX_LOGIN;
		}
		//log.info("id：" + user.getId() + " name：" + user.getNickName());
		return invocation.invoke();

	}
	
	// ajax请求拦截 没登录返回 NoLogin 登录流程继续
	private String ajaxIntercept(ActionInvocation invocation) throws Exception {
		log.info("ajax拦截");
		User user = (User) session.getAttribute(IConstants.SESSION_USER);
		if (null == user) {
			response.getWriter().print(IConstants.ADMIN_AJAX_LOGIN);
			log.info("No Login");
			return null;
		}
		//log.info("id：" + user.getId() + " name：" + user.getNickName());
		return invocation.invoke();
	}

	private String getRemortIP() {
		if (request.getHeader("x-forwarded-for") == null) {
			return request.getRemoteAddr();
		}
		return request.getHeader("x-forwarded-for");
	}

	private boolean isAjaxRequest() {
		String header = request.getHeader("X-Requested-With");
		if (header != null && "XMLHttpRequest".equals(header)) {
			return true;
		}
		return false;
	}
}
