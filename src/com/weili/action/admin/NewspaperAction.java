package com.weili.action.admin;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.NewspaperService;

public class NewspaperAction extends BasePageAction {

	public static Log log = LogFactory.getLog(NewspaperAction.class);
	
	private NewspaperService newspaperService;
	
	/**
	 * 查询华普报
	 * @return
	 */
	public String queryNewspaperInit(){
		return SUCCESS;
	}
	
	public String queryNewspaperInfo() throws Exception{
		String name = request("name");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		
		String fieldList = "*";
		String order = "order by addTime desc";
		String table = "t_newspaper";
		
		StringBuffer condition = new StringBuffer();
		
		if(StringUtils.isNotBlank(name)){
			condition.append(" and `name` LIKE CONCAT('%','"+name.trim()+"','%')");
		}
		if(status != null&&status > 0){
			condition.append(" and `status` = "+status);
		}
		if(StringUtils.isNotBlank(startDate)){
			condition.append(" and date_format(addTime,'%Y-%m-%d') >= '" + startDate + "'");
		}if(StringUtils.isNotBlank(endDate)){
			condition.append(" and date_format(addTime,'%Y-%m-%d') <= '"+ endDate +"'");
		}
		
		newspaperService.queryNewspaperPage(pageBean, fieldList, condition, order, table);
		return SUCCESS;
	}
	
	/**
	 * 添加华普报
	 * @return
	 */
	public String addNewspaperInit(){
		return SUCCESS;
	}
	
	public String addNewspaper() throws Exception{
		String name = request("name");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String path = request("path");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String addTime = request("addTime");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(newspaperService.addNewspaper(name, image, path, status, sortIndex, seoTitle, seoKeywords, seoDescription,addTime));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改华普报
	 * @return
	 * @throws Exception 
	 */
	public String updateNewspaperInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = newspaperService.queryNewspaperById(id);
		return SUCCESS;
	}
	
	public String updateNewspaper() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String name = request("name");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String path = request("path");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String addTime = request("addTime");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(newspaperService.updateNewspaper(id, name, image, path, status, sortIndex, seoTitle, seoKeywords, seoDescription,addTime));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteNewspaper() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = newspaperService.deleteNewspaper(ids);
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

	public void setNewspaperService(NewspaperService newspaperService) {
		this.newspaperService = newspaperService;
	}

}
