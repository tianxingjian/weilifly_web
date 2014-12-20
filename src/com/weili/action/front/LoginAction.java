package com.weili.action.front;

import java.sql.SQLException;
import java.util.Map;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.shove.data.DataException;
import com.shove.web.util.ServletUtils;
import com.weili.action.front.BaseFrontAction;
import com.weili.entity.User;
import com.weili.service.UserService;

public class LoginAction extends BaseFrontAction {
	private UserService userService;
	public static Log log = LogFactory.getLog(LoginAction.class);
	
	
	public  String loginInit() throws Exception {
		Map<String,String> seoMap = getSeoMap("loginInit.do");//seo
		request("seoMap",seoMap);
		return SUCCESS;
	}
	
	/**
	 * 登录
	 * @return
	 * @throws Exception 
	 */
	public String userLogin() throws Exception {
		String username= StringEscapeUtils.escapeHtml(paramMap.get("username"));
		String password= StringEscapeUtils.escapeHtml(paramMap.get("password"));
		
		if(StringUtils.isBlank(username)){
			this.addFieldError("paramMap.username","请输入用户名");
			return INPUT;
		}
		if(StringUtils.isBlank(password)){
			this.addFieldError("paramMap.password","请输入密码");
			return INPUT;
		}
		
		username=username.trim();
		password=password.trim();
		
		User user = null;
		try {
			user = userService.userLogin(username, password, ServletUtils.getRemortIp());
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		} catch (DataException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		if (user == null) {
			this.addFieldError("paramMap.username", "用户名或密码错误");
			return INPUT;
		}
		if (user.getIsDisable() != 1) {
			this.addFieldError("paramMap.password", "你的帐号被停用请联系站点管理员");
			return INPUT;
		}
		return SUCCESS;		
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	
}
