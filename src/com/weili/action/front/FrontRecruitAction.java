package com.weili.action.front;

import java.util.List;
import java.util.Map;
import com.shove.Convert;
import com.weili.service.RecruitService;
import com.weili.service.RecruitTypeService;

public class FrontRecruitAction extends FrontInfoContentAction {

	private RecruitService recruitService;
	private RecruitTypeService recruitTypeService;  //类型
	
	private List<Map<String, Object>> recruitTypeList;
	
	
	public List<Map<String, Object>> getRecruitTypeList() throws Exception {
		if(recruitTypeList==null){
			StringBuffer condition = new StringBuffer();
			try {
				recruitTypeList = recruitTypeService.queryRecruitTypeAll("*", condition.toString(),"sortIndex asc");
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return recruitTypeList;
	}

	
	
	
	public String queryRecruitInit() throws Exception {
		//HttpServletRequest request=ServletActionContext.getRequest();
      //  String a=request.getParameter("a");
       // request("a",a);
		Map<String,String> seoMap = getSeoMap("queryRecruitInit.do");//seo
		request("seoMap",seoMap);
		return SUCCESS;
	}
	
	
	/**
	 * 人才招聘
	 * @return
	 * @throws Exception
	 */
	public String queryRecruit() throws Exception {
		int type=Convert.strToInt(request("type"), -1);
		StringBuffer condition=new StringBuffer();
		if(type>0){
			condition.append(" and type="+type);
		}
		pageBean.setPageSize(10);
		recruitService.queryRecruitPage(pageBean, "*", condition, "ORDER BY addTime DESC", "t_recruit");
		long id=Convert.strToLong(request("type"), -1);
		Map<String, String> imgMap=recruitTypeService.queryRecruitTypeById(id);
		request("imgMap",imgMap);
		return SUCCESS;
	}


	
	
	/**
	 * 人才招聘
	 * @return
	 * @throws Exception
	 */
	public String queryRecruit2() throws Exception {
		int type=Convert.strToInt(request("type"), -1);
		paramMap=recruitService.queryRecruitByType(type);
		long id=Convert.strToLong(request("type"), -1);
		Map<String, String> imgMap=recruitTypeService.queryRecruitTypeById(id);
		request("imgMap",imgMap);
		return SUCCESS;
	}
		

	
	
	
	public void setRecruitService(RecruitService recruitService) {
		this.recruitService = recruitService;
	}


	

	public void setRecruitTypeService(RecruitTypeService recruitTypeService) {
		this.recruitTypeService = recruitTypeService;
	}


}
