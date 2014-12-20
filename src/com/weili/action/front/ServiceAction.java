package com.weili.action.front;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.shove.Convert;
import com.shove.data.DataException;
import com.weili.constants.IConstants;
import com.weili.service.ConfigService;
import com.weili.service.QuestionService;

public class ServiceAction extends BaseFrontAction{
	
	private QuestionService questionService;
	private Map<String, String> paramPreMap;
	private Map<String, String> paramAferMap;
//	private ConfigService configService; // 配置表
//	public void setConfigService(ConfigService configService) {
//		this.configService = configService;
//	}



	/**
	 * 在线支持
	 * @return
	 * @throws Exception 
	 */
	public String queryOnline() throws Exception{
		paramMap=getConfigService().queryConfigById(IConstants.CONFIG_ID_ONLINE);	
		Map<String,String> seoMap = getSeoMap("queryOnline.do");//seo
		request("seoMap",seoMap);
		return SUCCESS;
	}
	
	
	
	/**
	 * 服务政策
	 * @return
	 * @throws Exception 
	 */
	public String queryServicePolicy() throws Exception {
		paramMap=getConfigService().queryConfigById(IConstants.CONFIG_ID_SERVICE_POLICY);	
		Map<String,String> seoMap = getSeoMap("queryServicePolicy.do");//seo
		request("seoMap",seoMap);
		return SUCCESS;
	}
	
	
	
	/**
	 * 服务在线客服2咨询
	 * @return
	 * @throws SQLException
	 * @throws DataException
	 */
	public Map<String, String> getParamPreMap() throws Exception {
		if(paramPreMap==null){
			try {
				paramPreMap = getConfigService().queryConfigById(IConstants.CONFIG_ID_PRESALES_CONSULTING);
			} catch (Exception e) {				
				e.printStackTrace();
				throw e;
			}
		}
		return paramPreMap;
	}


	/**
	 * 服务在线客服1咨询
	 * @return
	 * @throws SQLException
	 * @throws DataException
	 */
	public Map<String, String> getParamAferMap() throws Exception {
		if(paramAferMap==null){
			try {
				paramAferMap=getConfigService().queryConfigById(IConstants.CONFIG_ID_AFTERSALES_CONSULTING);	
			} catch (Exception e) {				
				e.printStackTrace();
				throw e;
			}
		}
		return paramAferMap;
	}
	
	
			
	
	/**
	 * 常见问题初始化
	 * @return
	 * @throws Exception 
	 */
	public String queryQuestionListInit() throws Exception {
		int pageNum = Convert.strToInt(request("curPage"), 1);
		request("pageNum",pageNum);
		Map<String,String> seoMap = getSeoMap("queryQuestionListInit.do");//seo
		request("seoMap",seoMap);
		return SUCCESS;
	}
	
	/**
	 * 常见问题
	 * @return
	 * @throws Exception 
	 */
	public String queryQuestionList() throws Exception {
		pageBean.setPageSize(10);
		String name=request("name");
		questionService.queryQuestionPage(pageBean,name);
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}

	/**
	 * 前台儿童类应用隐私协议
	 * 
	 * @return
	 * @throws Exception
	 */
	public String privacy() throws Exception {
		// type = 8代表儿童类应用隐私协议
		paramMap = getConfigService().queryContentMap(8);
		return SUCCESS;
	}

	public void setQuestionService(QuestionService questionService) {
		this.questionService = questionService;
	}



	public void setParamPreMap(Map<String, String> paramPreMap) {
		this.paramPreMap = paramPreMap;
	}



	public void setParamAferMap(Map<String, String> paramAferMap) {
		this.paramAferMap = paramAferMap;
	}



	
		
}
