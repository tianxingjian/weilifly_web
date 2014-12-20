package com.weili.action.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.weili.service.NavigationBarService;
import com.shove.Convert;
import com.shove.data.DataException;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;

public class NavigationBarAction extends BasePageAction{
	
	
	private static final long serialVersionUID = 1L;

	public static Log log = LogFactory.getLog(NavigationBarAction.class);
	private NavigationBarService navigationBarService;
	private List<Map<String, Object>> orderList;
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
	public String queryNavigationBarInit(){
		return SUCCESS;
	}
	
	/**
	 * 查询菜单项
	 * @return
	 * @throws SQLException
	 * @throws DataException
	 */
	public String queryNavigationBarInfo() throws SQLException, DataException{
		String name  = paramMap.get("name");
		Integer enable = Convert.strToInt(paramMap.get("enable"),-1);
		String orderName = paramMap.get("orderName");
		pageBean.setPageSize(10);
		navigationBarService.queryNavigationBarPage(name, enable,orderName, pageBean);
		return SUCCESS;
	}
	
	/**
	 * 添加Menu初始化
	 * @return
	 */
	public String addNavigationBarInit(){
		paramMap.put("enable", 1+"");
		return SUCCESS;
	}
	
	/**
	 * 添加Menu
	 * @return
	 * @throws SQLException
	 * @throws DataException 
	 */
	public String addNavigationBar() throws SQLException, DataException{		
		String name = paramMap.get("name");
		String orderName = paramMap.get("orderName");
		long parentId = Convert.strToLong(paramMap.get("parentId"),-1);
		int enable = Convert.strToInt(paramMap.get("enable"), -1);
		String url = paramMap.get("url");
		int type=1;//暂定字段
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		String mark = null;
		Long result=navigationBarService.addNavigationBar(name,orderName,parentId,enable,url,type,sortIndex,mark);
		if(result<0){
			this.addFieldError("errorMessage","添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	/**
	 * 修改菜单项初始化
	 * @return
	 * @throws DataException 
	 * @throws SQLException 
	 */
	public String updateNavigationBarInit() throws SQLException, DataException{
		Long id = Long.parseLong(request("id"));
		paramMap = navigationBarService.queryNavigationBarById(id);
		log.info(paramMap.toString());
		int pageNow = Convert.strToInt(request("pageNow"), 1);
		paramMap.put("pageNow", pageNow+"");
		log.info(paramMap.toString());
		return SUCCESS;
	}
	
	/**
	 * 修改菜单项
	 * @return
	 * @throws SQLException 
	 */
	public String updateNavigationBar() throws Exception{
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String name = paramMap.get("name");
		String orderName = paramMap.get("orderName");
		Long parentId = Convert.strToLong(paramMap.get("parentId"), -1);
		int enable = Convert.strToInt(paramMap.get("enable"), -1);
		String url = paramMap.get("url");
		int type=1;//暂定字段
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		String mark = null;//暂定字段
		
		JSONObject obj = new JSONObject();
		obj.putAll(navigationBarService.updateNavigationBar(id, name,orderName,parentId, enable, url,type,sortIndex,mark));		
		JSONUtils.printObject(obj);
		
		return null;
	}

	/**
	 * 删除菜单项 -- id
	 * @return
	 * @throws DataException
	 * @throws SQLException
	 */
	public String deleteNavigationBar() throws DataException, SQLException{
		String navigationBarIds = request("id");
		
		String[] navigationBarids = navigationBarIds.split(",");
		int length= navigationBarids.length;
		if(length<=0){
			return SUCCESS;
		}
		long[] ids = new long[length];
		for (int i = 0; i < navigationBarids.length; i++) {
			ids[i] = Convert.strToLong(navigationBarids[i], -1);
			if(ids[i]==-1){
				return SUCCESS;
			}
		}
		try {
			navigationBarService.deleteNavigationBar(navigationBarIds);
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		
		int pageNow = Convert.strToInt(request("pageNow"), 1);
		this.pageNow = pageNow+"";
		return SUCCESS;
	}
	
	public void setNavigationBarService(NavigationBarService navigationBarService) {
		this.navigationBarService = navigationBarService;
	}

	public List<Map<String, Object>> getOrderList() throws SQLException, DataException {
		if(orderList!=null){
			return orderList;
		}
		orderList = navigationBarService.queryOrderList();
		return orderList;
	}
	
}