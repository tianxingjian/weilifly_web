package com.weili.action.admin;

import java.util.List;
import java.util.Map;
import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.DesignCategoryService;

public class DesignCategoryAction extends BasePageAction<Map<String, Object>> {
	
	private DesignCategoryService designCategoryService;
	
	/**
	 * 添加设计素材分类初始化
	 * @return
	 */
	public String addDesignCategoryOneInit() {
		return SUCCESS;
	}
	
	
	public String addDesignCategoryOne() throws Exception {
		String name=paramMap.get("name");
		int status=Convert.strToInt(paramMap.get("status"), -1) ;
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		Long result=designCategoryService.addDesignCategory(name, status, sortIndex);
		if(result<0){
			this.addFieldError("errorMessage", "添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	
	
	
	/**
	 * 修改设计素材分类初始化
	 * @return
	 * @throws Exception 
	 */
	public  String updateDesignCategoryOneInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=designCategoryService.queryDesignCategoryById(id);
		return SUCCESS;
	}
	
	
	public String updateDesignCategoryOne() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String name=paramMap.get("name");
		int status=Convert.strToInt(paramMap.get("status"), -1) ;
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		Long result=designCategoryService.updateDesignCategory(id, name,status, sortIndex);
		if(result<0){
			this.addFieldError("errorMessage", "修改失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	
	
	/**
	 * 设计素材分类列表初始化
	 * @return
	 */
	public String  queryDesignCategoryOneInit() {
		return SUCCESS;
	}
	
	
	public String queryDesignCategoryOne() throws Exception {
		StringBuffer condition=new StringBuffer();
		condition.append(" 1=1");
		List<Map<String,Object>> list = designCategoryService.queryDesignCategoryAll("*", condition.toString(), "id desc");
		request().setAttribute("list",list);
		return SUCCESS;		
	}
	
		
	
	/***
	 * 删除设计素材分类
	 * @return
	 * @throws Exception 
	 */
	public String deleteDesignCategory() throws Exception {
		String id=request("id");			
		Long result=designCategoryService.deleteDesignCategory(id);
		if(result<0){
			this.addFieldError("errorMessage", "删除失败");
			return INPUT;
		}	
		return SUCCESS;
	}


	public void setDesignCategoryService(DesignCategoryService designCategoryService) {
		this.designCategoryService = designCategoryService;
	}
	
	
}
