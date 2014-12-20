package com.weili.action.admin;

import java.util.Map;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.UserService;

public class UserAction extends BasePageAction<Map<String, Object>> {

	private UserService userService; // 代理商

	/**
	 * 添加代理商初始化
	 * 
	 * @return
	 */
	public String addUserInit() {
		return SUCCESS;
	}

	public String addUser() throws Exception {
		String username = paramMap.get("username");
		String password = paramMap.get("password");
		String realName = paramMap.get("realName");
		String phone = paramMap.get("phone");
		int isDisable = Convert.strToInt(paramMap.get("isDisable"), -1);
		int sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		Long result = userService.addUser(username, password, realName, phone,
				isDisable, sortIndex);
		if (result < 0) {
			this.addFieldError("erroeMessage", "添加失败");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 修改代理商初始化
	 * 
	 * @return
	 * @throws Exception
	 */
	public String updateUserInit() throws Exception {
		Long id = Convert.strToLong(request("id"), -1);
		paramMap = userService.queryUserById(id);
		return SUCCESS;
	}

	public String updateUser() throws Exception {
		Long id = Convert.strToLong(paramMap.get("id"), -1);
		String password = paramMap.get("password");
		String realName = paramMap.get("realName");
		String phone = paramMap.get("phone");
		int isDisable = Convert.strToInt(paramMap.get("isDisable"), -1);
		int sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		Long result = userService.updateUser(id, password, realName, phone,
				isDisable, sortIndex);
		if (result < 0) {
			this.addFieldError("erroeMessage", "修改失败");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 代理商列表初始化
	 * 
	 * @return
	 */
	public String queryUserInit() {
		return SUCCESS;
	}

	public String queryUserList() throws Exception {
		String username = request("username");
		String realName = request("realName");
		int isDisable = Convert.strToInt(request("isDisable"), -1);
		userService.queryUserPage(username, realName, isDisable, pageBean);
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}

	/**
	 * 删除代理商
	 * 
	 * @return
	 * @throws Exception
	 */
	public String deleteUser() throws Exception {
		String id = request("id");
		Long resut = userService.deleteUser(id);
		if (resut < 0) {
			this.addFieldError("errorMessage", "删除失败");
			return INPUT;
		}
		return SUCCESS;
	}

	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

}
