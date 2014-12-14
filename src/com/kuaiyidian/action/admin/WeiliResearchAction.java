package com.kuaiyidian.action.admin;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.kuaiyidian.service.WeiliResearchesService;
import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;

public class WeiliResearchAction extends BasePageAction {

	public static Log log = LogFactory.getLog(WeiliResearchAction.class);
	
	private WeiliResearchesService weiliResearchesService;
	
	/**
	 * 查询品牌资讯
	 * @return
	 */
	public String queryWeiliResearchInit(){
		return SUCCESS;
	}
	
	//后台查询微力研究院文章列表
	public String queryWeiliResearch() throws Exception{
		String title = request("title");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
//		String type = request("type");
		
		String fieldList = "*";
		String order = "order by addTime desc";
		String table = "t_weili_research";
		
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
		
		weiliResearchesService.queryBrandNewsPage(pageBean, fieldList, condition, order, table);
		return SUCCESS;
	}
	
	/**
	 * 添加微力研究院内容
	 * @return
	 * @throws Exception 
	 */
	public String addWeiliResearchInit() throws Exception{
		List<Map<String,String>> sortList = weiliResearchesService.querySort();
		request().setAttribute("sortList", sortList);
		
		return SUCCESS;
	}
	
	public String addWeiliResearch() throws Exception{
		String title = request("title");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		Integer isRecommended = Convert.strToInt(request("isRecommended"), -1);
		Integer isIndex = Convert.strToInt(request("isIndex"), -1);
		String source = request("source");
		String content = request("content");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String addTime = request("addTime");
		Integer type = Convert.strToInt(request("type"), -1); 
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(weiliResearchesService.addWeiliResearch(title, source, null, image, 
				content, status, isRecommended, isIndex, sortIndex, 
				seoTitle, seoKeywords, seoDescription,addTime,type));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改品牌资讯
	 * @return
	 * @throws Exception 
	 */
	public String updateWeiliResearchInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = weiliResearchesService.queryWeiliResearchesById(id);
		return SUCCESS;
	}
	
	public String updateWeiliResearch() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String title = request("title");
		String image = request("image");
		String addTime = request("addTime");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		Integer isRecommended = Convert.strToInt(request("isRecommended"), -1);
		Integer isIndex = Convert.strToInt(request("isIndex"), -1);
		String source = request("source");
		String content = request("content");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(weiliResearchesService.updateWeiliResearch(id, title, source, null, image,  content, status, isRecommended, isIndex, sortIndex, seoTitle, seoKeywords, seoDescription,addTime));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteWeiliResearch() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = weiliResearchesService.deleteWeiliResearch(ids);
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

	public void setWeiliResearchesService(
			WeiliResearchesService weiliResearchesService) {
		this.weiliResearchesService = weiliResearchesService;
	}

	
	
}
