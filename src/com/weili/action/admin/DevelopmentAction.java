package com.weili.action.admin;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.DevelopmentService;

public class DevelopmentAction extends BasePageAction {

	public static Log log = LogFactory.getLog(DevelopmentAction.class);
	
	private DevelopmentService developmentService;
	
	/**
	 * 查询发展历程
	 * @return
	 */
	public String queryDevelopmentInit(){
		return SUCCESS;
	}
	
	public String queryDevelopmentInfo() throws Exception{
		String title = request("title");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		
		String fieldList = "*";
		String order = "order by sortIndex asc";
		String table = "t_development";
		
		StringBuffer condition = new StringBuffer();
		
		if(StringUtils.isNotBlank(title)){
			condition.append(" and `title` LIKE CONCAT('%','"+title.trim()+"','%')");
		}
		if(status != null&&status > 0){
			condition.append(" and `status` = "+status);
		}
		if(StringUtils.isNotBlank(startDate)){
			condition.append(" and date_format(addTime,'%Y-%m-%d') >= '" + startDate + "'");
		}if(StringUtils.isNotBlank(endDate)){
			condition.append(" and date_format(addTime,'%Y-%m-%d') <= '"+ endDate +"'");
		}
		
		developmentService.queryDevelopmentPage(pageBean, fieldList, condition, order, table);
		return SUCCESS;
	}
	
	/**
	 * 添加发展历程
	 * @return
	 */
	public String addDevelopmentInit(){
		return SUCCESS;
	}
	
	public String addDevelopment() throws Exception{
		String title = request("title");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String content = request("content");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(developmentService.addDevelopment(title, content, status, sortIndex, seoTitle, seoKeywords, seoDescription));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改发展历程
	 * @return
	 * @throws Exception 
	 */
	public String updateDevelopmentInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = developmentService.queryDevelopmentById(id);
		return SUCCESS;
	}
	
	public String updateDevelopment() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String title = request("title");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String content = request("content");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(developmentService.updateDevelopment(id, title, content, status, sortIndex, seoTitle, seoKeywords, seoDescription));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteDevelopment() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = developmentService.deleteDevelopment(ids);
			if(returnId<=0){
				return null;
			}
			
			msg = "1";
			
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			msg = "删除失败！";
			
		}finally{
			obj.put("msg", msg);
			JSONUtils.printObject(obj);
			
		}
		return null;
	}

	public void setDevelopmentService(DevelopmentService developmentService) {
		this.developmentService = developmentService;
	}
	
}
