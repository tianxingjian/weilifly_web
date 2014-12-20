package com.weili.action.admin;

import java.sql.SQLException;
import java.util.Map;
import com.shove.Convert;
import com.shove.data.DataException;
import com.shove.web.action.BasePageAction;
import com.weili.service.SeoPageService;

public class SeoPageAction extends BasePageAction<Map<String, Object>> {
	
    private	SeoPageService seoPageService;
	
    
    /**
   	 * 添加SEO初始化
   	 * @return
   	 */
   	public String addSeoPageInit(){
   		return SUCCESS;
   	}
   	/**
   	 * 添加SEO
   	 * @return
   	 * @throws SQLException
   	 * @throws DataException 
   	 */
   	public String addSeoPage() throws SQLException, DataException{		
   		String pageUrl = paramMap.get("pageUrl");
   		String seoTitle = paramMap.get("seoTitle");
   		String seoKeyWord = paramMap.get("seoKeyWord");
   		String seoDescription = paramMap.get("seoDescription");
   		
   		Long result=seoPageService.addSeoPage(pageUrl,-1,seoTitle,seoKeyWord,seoDescription);
   		if(result<0){
   			this.addFieldError("errorMessage","添加失败");
   			return INPUT;
   		}
   		return SUCCESS;
   	}
    /**
     * 修改seo初始化
     * @return
     * @throws Exception
     */
	public String updateSeoPageInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=seoPageService.querySeoPageById(id);
		return SUCCESS;
	}
	
	public String updateSeoPage() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String seoTitle=paramMap.get("seoTitle");
		String seoKeyWord=paramMap.get("seoKeyWord");
		String seoDescription=paramMap.get("seoDescription");
		Long result=seoPageService.updateSeoPage(id, seoTitle, seoKeyWord, seoDescription);
		if(result<0){
			this.addFieldError("errorMessage","修改失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 列表显示初始化
	 * @return
	 */
	public  String querySeoPageInit() {
		return SUCCESS;
	}
	
	
	/**
	 * 列表
	 * @return
	 * @throws Exception 
	 */
	public String querySeoPageList() throws Exception {
		String pageUrl=request("pageUrl");		
		seoPageService.querySeoPagePageList(pageUrl,pageBean);
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}
	
	
	
	/**
	 * 删除SEO
	 * 
	 * @return
	 * @throws Exception
	 */
	public String deleteSeoPage() throws Exception {
		String id = request("id");
		Long result = seoPageService.deleteSeoPage(id);
		if (result < 0) {
			this.addFieldError("errorMessage", "删除失败");
			return INPUT;
		}
		return SUCCESS;
	}

	public void setSeoPageService(SeoPageService seoPageService) {
		this.seoPageService = seoPageService;
	}
	
}
