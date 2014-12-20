package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.RecruitService;
import com.weili.service.RecruitTypeService;


public class RecruitAction extends BasePageAction<Map<String, Object>> {
	
	
	private RecruitService recruitService;   //人才招聘
	private RecruitTypeService recruitTypeService;  //人才招聘类型
	
	private List<Map<String, Object>> recruitTypeList;  //人才招聘类型列表
	
	
	
	public List<Map<String, Object>> getRecruitTypeList() throws Exception {
		if (recruitTypeList==null) {
			StringBuffer condition=new StringBuffer();
			try {
				recruitTypeList=recruitTypeService.queryRecruitTypeAll("*", condition.toString(), "id asc");
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return recruitTypeList;
	}
	
	
	
	
	/**
	 * 添加人才招聘初始化
	 * @return
	 */
	public String addRecruitInit() {
		return SUCCESS;
	}
	
	public String addRecruit() throws Exception {
		String name=paramMap.get("name");
		int type=Convert.strToInt(paramMap.get("type"), -1);
		String content=paramMap.get("content");
		int sort=Convert.strToInt(paramMap.get("sort"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		String seoTitle=paramMap.get("seoTitle");
		String seoKeywords=paramMap.get("seoKeywords");
		String seoDescription=paramMap.get("seoDescription");
		
		Long result=recruitService.addRecruit(name, type, content, sort, status, seoTitle, seoKeywords, seoDescription);
		if(result<0){
			this.addFieldError("errorMessage","添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 修改人才招聘初始化
	 * @return
	 * @throws Exception
	 */
	public String updateRecruitInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=recruitService.queryRecruitById(id);
		return SUCCESS;
	}
	
	
	public  String  updateRecruit() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String name=paramMap.get("name");
		int type=Convert.strToInt(paramMap.get("type"), -1);
		String content=paramMap.get("content");
		int sort=Convert.strToInt(paramMap.get("sort"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		String seoTitle=paramMap.get("seoTitle");
		String seoKeywords=paramMap.get("seoKeywords");
		String seoDescription=paramMap.get("seoDescription");
		
		Long result=recruitService.updateRecruit(id, name, type, content, sort, status, seoTitle, seoKeywords, seoDescription);
		if(result<0){
			this.addFieldError("errorMessage","修改失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 人才招聘列表初始化
	 * @return
	 */
	public String queryRecruitInit() {
		return SUCCESS;
	}
	
	
	
	public String queryRecruit() throws Exception {
		String name=request("name");
		int type=Convert.strToInt(request("type"), -1);
		int status=Convert.strToInt(request("status"), -1);
		StringBuffer condition=new StringBuffer();
		if(StringUtils.isNotBlank(name)){
			condition.append(" AND name LIKE CONCAT('%','"+name+"','%')");
		}
		if(type>0){
			condition.append(" AND type="+type);
		}
		if(status>0){
			condition.append(" AND status="+status);
		}
		
		recruitService.queryRecruitPage(pageBean, "*", condition, " ORDER BY addTime DESC", "v_t_recruit_type");
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}
	
	
	
	/**
	 * 删除人才招聘
	 * @return
	 * @throws Exception 
	 */
	public  String deleteRecruit() throws Exception {
		String ids=request("id");
		Long result=recruitService.deleteRecruit(ids);
		if(result<0){
			this.addFieldError("errorMessage","删除失败");
			return INPUT;
		}
		return SUCCESS;
	}

	public void setRecruitService(RecruitService recruitService) {
		this.recruitService = recruitService;
	}

	

	public void setRecruitTypeService(RecruitTypeService recruitTypeService) {
		this.recruitTypeService = recruitTypeService;
	}
	
	
}
