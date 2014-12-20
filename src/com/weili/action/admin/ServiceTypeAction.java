package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.ServiceTypeService;

public class ServiceTypeAction extends BasePageAction<Map<String, Object>> {
	
	private ServiceTypeService serviceTypeService;  
	
	
	/**
	 * 添加服务类型初始化
	 * @return
	 */
	public  String addServiceTypeInit() {
		return SUCCESS;
	}
	
	
	public String addServiceType() throws Exception {
		String title=paramMap.get("title");
		String linkPath=paramMap.get("linkPath");
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		long result=serviceTypeService.addServiceType(title, linkPath, sortIndex, status);
		if(result<0){
			this.addFieldError("errorMessage","添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 修改服务类型
	 * @return
	 * @throws Exception 
	 */
	public String updateServiceTypeInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=serviceTypeService.queryServiceTypeById(id);
		return SUCCESS;
	}
	
	
	public String updateServiceType() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String title=paramMap.get("title");
		String linkPath=paramMap.get("linkPath");
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		long result=serviceTypeService.updateServiceType(id, title, linkPath, sortIndex, status);
		if(result<0){
			this.addFieldError("errorMessage","修改失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 服务类型初始化
	 * @return
	 */
	public String queryServiceTypeInit() {
		return SUCCESS;
	}
	
	
	public String querySericeType() throws Exception {
		StringBuffer condition=new StringBuffer();
		condition.append(" 1=1");
		List<Map<String,Object>> list = serviceTypeService.queryServiceTypeAll("*", condition.toString(), "id desc");
		request().setAttribute("list",list);
		return SUCCESS;		
	}
	
	
	/**
	 * 删除服务类型
	 * @return
	 * @throws Exception 
	 */
	public String deleteSericeType() throws Exception {
		String ids=request("id");
		Long result=serviceTypeService.deleteServiceType(ids);
		if(result<0){
			this.addFieldError("errorMessage","删除失败");
			return INPUT;
		}
		return SUCCESS;
	}


	public void setServiceTypeService(ServiceTypeService serviceTypeService) {
		this.serviceTypeService = serviceTypeService;
	}

	
}
