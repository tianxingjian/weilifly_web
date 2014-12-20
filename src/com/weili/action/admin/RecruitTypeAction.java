package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.RecruitTypeService;

public class RecruitTypeAction extends BasePageAction<Map<String, Object>> {

private RecruitTypeService recruitTypeService;
	
	/**
	 * 添加人才招聘类型初始化
	 * @return
	 */
	public String addRecruitTypeInit() {
		return SUCCESS;
	}
	
	
	public String addRecruitType() throws Exception {
		String title=paramMap.get("title");
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		String imgUrl=paramMap.get("imgUrl");
		Long result=recruitTypeService.addRecruitType(title, sortIndex, status,imgUrl);
		if(result<0){
			this.addFieldError("errorMessage","添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 修改人才招聘类型初始化
	 * @return
	 * @throws Exception
	 */
	public String updateRecruitTypeInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=recruitTypeService.queryRecruitTypeById(id);
		return SUCCESS;
	}
	
	
	public String updateRecruitType() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String title=paramMap.get("title");
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		String imgUrl=paramMap.get("imgUrl");
		
		JSONObject obj = new JSONObject();

		obj.putAll(recruitTypeService.updateRecruitType(id, title, sortIndex, status,imgUrl));

		JSONUtils.printObject(obj);
		
		return null;
	}
	
	
	/**
	 * 人才招聘类型列表初始化
	 * @return
	 */
	public String queryRecruitTypeInit() {
		return SUCCESS;
	}
	
	
	public String queryRecruitType() throws Exception {
		StringBuffer condition=new StringBuffer();
		condition.append(" 1=1");
		List<Map<String,Object>> list = recruitTypeService.queryRecruitTypeAll("*", condition.toString(), "id desc");
		request().setAttribute("list",list);
		return SUCCESS;		
	}
	
	
	/**
	 * 删除人才招聘类型
	 * @return
	 * @throws Exception 
	 */
	public String deleteRecruitType() throws Exception {
		String ids=request("id");
		Long result=recruitTypeService.deleteRecruitType(ids);
		if(result<0){
			this.addFieldError("errorMessage","删除失败");
			return INPUT;
		}
		return SUCCESS;
	}


	public void setRecruitTypeService(RecruitTypeService recruitTypeService) {
		this.recruitTypeService = recruitTypeService;
	}
	
	
}
