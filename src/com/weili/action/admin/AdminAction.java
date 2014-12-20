package com.weili.action.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.shove.Convert;
import com.shove.data.DataException;
import com.shove.util.BeanMapUtils;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.ServletUtils;
import com.weili.constants.IConstants;
import com.weili.entity.Admin;
import com.weili.service.AdminService;
import com.weili.service.RoleRightsService;
import com.weili.service.RoleService;

public class AdminAction extends BasePageAction{
	
	
	private static final long serialVersionUID = 1L;

	public static Log log = LogFactory.getLog(AdminAction.class);
	
	private AdminService adminService;
	private RoleService roleService;
	private RoleRightsService roleRightsService;
	private List<Map<String, Object>> roleList;
	
	private String pageNow;

	public String getPageNow() {
		return pageNow;
	}

	public void setPageNow(String pageNow) {
		this.pageNow = pageNow;
	}

	/**
	 * 查询管理员初始化
	 * @return
	 */
	public String queryAdminInit(){
		return SUCCESS;
	}
	
	/**
	 * 查询管理员
	 * @return
	 * @throws SQLException
	 * @throws DataException
	 */
	public String queryAdminInfo() throws SQLException, DataException{
		String userName  = paramMap.get("userName");
		Integer enable = Convert.strToInt(paramMap.get("enable"),-1);
		Long roleId = Convert.strToLong(paramMap.get("roleId"),-2);
		pageBean.setPageSize(20);
		adminService.queryAdminPage(userName, enable,roleId, pageBean);
		return SUCCESS;
	}
	
	/**
	 * 添加管理员初始化
	 * @return
	 */
	public String addAdminInit(){
		paramMap.put("enable", 1+"");
		return SUCCESS;
	}
	
	/**
	 * 添加管理员
	 * @return
	 * @throws SQLException
	 * @throws DataException 
	 */
	public String addAdmin() throws SQLException, DataException{
		String userName = paramMap.get("userName");
		String password = paramMap.get("password");
		Integer enable = Integer.parseInt(paramMap.get("enable"));
		long roleId = Convert.strToLong(paramMap.get("roleId"),-2);
		Long returnId = -1L;
		try {
			returnId = adminService.addAdmin(userName, password, enable,roleId);
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		if(returnId==-2){
			this.addFieldError("paramMap.userName", "用户名重复");
			return INPUT;
		}
		return SUCCESS;
	}
	
	/**
	 * 修改管理员初始化
	 * @return
	 * @throws DataException 
	 * @throws SQLException 
	 */
	public String updateAdminInit() throws SQLException, DataException{
		Long id = Long.parseLong(request("id"));
		paramMap = adminService.queryAdminById(id);
		
		int pageNow = Convert.strToInt(request("pageNow"), 1);
		paramMap.put("pageNow", pageNow+"");
		return SUCCESS;
	}
	
	/**
	 * 修改管理员
	 * @return
	 * @throws SQLException 
	 */
	public String updateAdmin() throws Exception{
		Long id = Long.parseLong(paramMap.get("id"));
		String password = paramMap.get("password");
		Integer enable = Integer.parseInt(paramMap.get("enable"));
		long roleId = Convert.strToLong(paramMap.get("roleId"),-2);
		try {
			adminService.updateAdmin(id, password, enable, null,roleId);
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		
		int pageNow = Convert.strToInt(paramMap.get("pageNow"), 1);
		this.pageNow = pageNow+"";
		return SUCCESS;
	}

	/**
	 * 删除书籍
	 * @return
	 * @throws DataException
	 * @throws SQLException
	 */
	public String deleteAdmin() throws DataException, SQLException{
		String adminIds = request("id");
		
		String[] adminids = adminIds.split(",");
		int length= adminids.length;
		if(length<=0){
			return SUCCESS;
		}
		long[] teacherid = new long[length];
		for (int i = 0; i < adminids.length; i++) {
			teacherid[i] = Convert.strToLong(adminids[i], -1);
			if(teacherid[i]==-1){
				return SUCCESS;
			}
		}
		try {
			adminService.deleteAdmin(adminIds);
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		
		int pageNow = Convert.strToInt(request("pageNow"), 1);
		this.pageNow = pageNow+"";
		return SUCCESS;
	}
	
	/**
	 * 登陆
	 * 
	 * @return
	 * @throws DataException
	 * @throws SQLException 
	 * @throws Exception 
	 * @throws AdminHelpMessageException 
	 */
	public String adminLogin() throws Exception{
		String pageId = request().getParameter("pageId");
		String code = (String) session().getAttribute(pageId + "_checkCode");
		String userName = StringEscapeUtils.escapeHtml(paramMap.get("userName"));
		String password = StringEscapeUtils.escapeHtml(paramMap.get("password"));
		String _code = StringEscapeUtils.escapeHtml(paramMap.get("code"));
		
		if(StringUtils.isBlank(userName)){
			this.addFieldError("paramMap.userName", "请输入用户名");
			return INPUT;
		}
		if(StringUtils.isBlank(password)){
			this.addFieldError("paramMap.password", "请输入密码");
			return INPUT;
		}
		if(StringUtils.isBlank(_code)){
			this.addFieldError("paramMap.code", "请输入验证码");
			return INPUT;
		}
		if (code == null || !_code.equals(code)) {
			this.addFieldError("paramMap.code", "验证码错误！");
			return INPUT;
		}
		
		userName = userName.trim();
		password = password.trim();
		_code = _code.trim();
		
		Admin admin = null;
		try {
			admin = adminService.adminLogin(userName, password, ServletUtils.getRemortIp());
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		} catch (DataException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		if (admin == null) {
			this.addFieldError("paramMap.userName", "用户名或密码错误");
			return INPUT;
		}
		if (admin.getEnable() != 1) {
			this.addFieldError("paramMap.password", "你的帐号被停用请联系站点管理员");
			return INPUT;
		}
		long roleId = admin.getRoleId();
		List<Map<String,Object>> list = roleRightsService.queryAdminRoleRightMenu(roleId);
		session().setAttribute("adminRoleMenuList", list);
		session().setAttribute(IConstants.SESSION_ADMIN, admin);
		return SUCCESS;
	}
	
	/**
	 * 退出登录
	 * @return
	 */
	public String adminLoginOut(){
		session().removeAttribute(IConstants.SESSION_ADMIN);
		return SUCCESS;
	}
	
	/**
	 * 修改密码初始化
	 * @return
	 */
	public String updatePasswordInit(){
		Admin admin = (Admin) session().getAttribute(IConstants.SESSION_ADMIN);
		paramMap = BeanMapUtils.beanToMap(admin);
		paramMap.put("password","");
		paramMap.put("oldPassword","");
		return SUCCESS;
	}
	
	/**
	 * 修改当前用户密码
	 * @return String
	 * @throws SQLException
	 */
	public String updatePassword() throws Exception{
		Admin admin = (Admin) session().getAttribute(IConstants.SESSION_ADMIN);
		String oldPassword =paramMap.get("oldPassword").trim();
		String password = paramMap.get("password").trim();
		oldPassword = com.shove.security.Encrypt.encryptSES(com.shove.security.Encrypt.MD5(oldPassword.trim()),IConstants.MD5_KEY);
		String confirmPassword = paramMap.get("confirmPassword").trim();
		if (!admin.getPassword().equals(oldPassword)) {
			this.addFieldError("paramMap.oldPassword","旧密码输入错误");
			return INPUT;
		}else if (!password.equals(confirmPassword)) {
			this.addFieldError("paraMap.oldPassword","确认密码与新密码不一致");
			return INPUT;
		}else {
			try {
			 adminService.updateAdmin(admin.getId(),password,null,null,null);
			} catch (SQLException e) {
				log.error(e);
				e.printStackTrace();
				throw e;
			}
		}
		return SUCCESS;
	}
	
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}

	public List<Map<String, Object>> getRoleList() throws SQLException, DataException {
		if(roleList!=null){
			return roleList;
		}
		roleList = roleService.queryRoleList();
		return roleList;
	}

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	public void setRoleRightsService(RoleRightsService roleRightsService) {
		this.roleRightsService = roleRightsService;
	}
	
}
