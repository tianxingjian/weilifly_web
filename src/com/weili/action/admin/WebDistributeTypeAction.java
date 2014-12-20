package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.WebDistributeTypeService;

public class WebDistributeTypeAction extends  BasePageAction<Map<String, Object>>  {

	private WebDistributeTypeService webDistributeTypeService;
	
	/**
	 * 添加网点分布类型初始化
	 * @return
	 */
	public String addWebDistributeTypeInit() {
		return SUCCESS;
	}
	
	
	public String addWebDistributeType() throws Exception {
		String title=paramMap.get("title");
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		Long result=webDistributeTypeService.addWebDistributeType(title, sortIndex, status);
		if(result<0){
			this.addFieldError("errorMessage","添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 修改网点分布类型初始化
	 * @return
	 * @throws Exception
	 */
	public String updateWebDistributeTypeInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=webDistributeTypeService.queryWebDistributeTypeById(id);
		return SUCCESS;
	}
	
	
	public String updateWebDistributeType() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String title=paramMap.get("title");
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		Long result=webDistributeTypeService.updateWebDistributeType(id, title, sortIndex, status);
		if(result<0){
			this.addFieldError("errorMessage","修改失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 网点分布类型列表初始化
	 * @return
	 */
	public String queryWebDistributeTypeInit() {
		return SUCCESS;
	}
	
	
	public String queryWebDistributeType() throws Exception {
		StringBuffer condition=new StringBuffer();
		condition.append(" 1=1");
		List<Map<String,Object>> list = webDistributeTypeService.queryWebDistributeTypeAll("*", condition.toString(), "id desc");
		request().setAttribute("list",list);
		return SUCCESS;		
	}
	
	
	/**
	 * 删除服务类型
	 * @return
	 * @throws Exception 
	 */
	public String deleteWebDistributeType() throws Exception {
		String ids=request("id");
		Long result=webDistributeTypeService.deleteWebDistributeType(ids);
		if(result<0){
			this.addFieldError("errorMessage","删除失败");
			return INPUT;
		}
		return SUCCESS;
	}


	public void setWebDistributeTypeService(
			WebDistributeTypeService webDistributeTypeService) {
		this.webDistributeTypeService = webDistributeTypeService;
	}
	
	
}
