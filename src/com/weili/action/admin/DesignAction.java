package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.DesignCategoryService;
import com.weili.service.DesignService;

public class DesignAction  extends BasePageAction<Map<String, Object>>{
	
	private DesignService designService;
	private DesignCategoryService designCategoryService;
	private List<Map<String, Object>> categoryList;
	
	
	// 得到分类
	public List<Map<String, Object>> getCategoryList() throws Exception {
		if (categoryList != null) {
			return categoryList;
		}
		StringBuffer condition = new StringBuffer();
		condition.append(" 1=1 ");
		try {
			categoryList = designCategoryService.queryDesignCategoryAll(
					"id,name", condition.toString(), "id");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return categoryList;
	}



	
	
	public void setCategoryList(List<Map<String, Object>> categoryList) {
		this.categoryList = categoryList;
	}
	
	
	
	
	/***
	 * 添加设计素材
	 * @return
	 */
	public String addDesignInit() {
		return SUCCESS;
	}
	
	
	public String addDesign() throws Exception {
		int categoryId=Convert.strToInt(paramMap.get("categoryId"), -1);
		String title=paramMap.get("title");
		String author=paramMap.get("author");
		int status=Convert.strToInt(paramMap.get("status"), -1);
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		Long result= designService.addDesign(categoryId, title, author, null, status, sortIndex);
		if(result<0){
			this.addFieldError("errorMessage","添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	
	/**
	 * 修改设计素材初始化
	 * @return
	 * @throws Exception
	 */
	public String updateDesignInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=designService.queryDesignById(id);
		return SUCCESS;
	}
	
	
	public String updateDesign() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		int categoryId=Convert.strToInt(paramMap.get("categoryId"), -1);
		String title=paramMap.get("title");
		String author=paramMap.get("author");
		int status=Convert.strToInt(paramMap.get("status"), -1);
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		JSONObject obj = new JSONObject();

		obj.putAll(designService.updateDesign(id, categoryId, title, author, null, status, sortIndex));

		JSONUtils.printObject(obj);
		
		return null;
	}
	
	
	/**
	 * 设计素材列表初始化
	 * @return
	 */
	public String queryDesignInit() {
		return SUCCESS;
	}
	
	
	public String queryDesign() throws Exception {
		String title = request("title");
		int categoryId=Convert.strToInt(request("categoryId"), -1);
		int status = Convert.strToInt(request("status"), -1);
		designService.queryDesignPage(title,categoryId, status, pageBean);
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}
	
	
	
	
	/**
	 * 设计素材列表初始化
	 * @return
	 */
	public String queryDesignInit2() {
		return SUCCESS;
	}
	
	
	/**
	 * 绑定设计素材
	 * @return
	 * @throws Exception
	 */
	public String queryDesign2() throws Exception {
		String title = request("title");
		int categoryId=Convert.strToInt(request("categoryId"), -1);
		int status = Convert.strToInt(request("status"), -1);
		designService.queryDesignPage(title,categoryId, status, pageBean);
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}
	
	
		
	
	
	/**
	 * 删除设计素材初始化
	 * @return
	 * @throws Exception
	 */
	public String deleteDesign() throws Exception {
		String id=request("id");
		Long result=designService.deleteDesign(id);
		if(result<0){
			this.addFieldError("errorMessage","删除失败");
			return INPUT;
		}
		return SUCCESS;
	}


	public void setDesignService(DesignService designService) {
		this.designService = designService;
	}


	public void setDesignCategoryService(DesignCategoryService designCategoryService) {
		this.designCategoryService = designCategoryService;
	}

	
}
