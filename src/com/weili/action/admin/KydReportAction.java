package com.weili.action.admin;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.KydReportService;

public class KydReportAction extends BasePageAction {

	public static Log log = LogFactory.getLog(KydReportAction.class);
	
	private KydReportService kydReportService;
	
	/**
	 * 查询微力科技报道
	 * @return
	 */
	public String queryKydReportInit(){
		return SUCCESS;
	}
	
	public String queryKydReportInfo() throws Exception{
		String title = request("title");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		
		String fieldList = "*";
		String order = "order by addTime desc";
		String table = "t_kyd_report";
		
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
		
		kydReportService.queryKydReportPage(pageBean, fieldList, condition, order, table);
		return SUCCESS;
	}
	
	/**
	 * 添加微力科技报道
	 * @return
	 */
	public String addKydReportInit(){
		return SUCCESS;
	}
	
	public String addKydReport() throws Exception{
		String title = request("title");
		String source = request("source");
		String content = request("content");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String path = request("path");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String addTime = request("addTime");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(kydReportService.addKydReport(title, source, null, image,path, content, status, sortIndex, seoTitle, seoKeywords, seoDescription,addTime));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改微力科技报道
	 * @return
	 * @throws Exception 
	 */
	public String updateKydReportInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = kydReportService.queryKydReportById(id);
		return SUCCESS;
	}
	
	public String updateKydReport() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String title = request("title");
		String source = request("source");
		String content = request("content");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String path = request("path");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String addTime = request("addTime");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(kydReportService.updateKydReport(id, title, source, null,image, path, content, status, sortIndex, seoTitle, seoKeywords, seoDescription,addTime));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteKydReport() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = kydReportService.deleteKydReport(ids);
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

	public void setKydReportService(KydReportService kydReportService) {
		this.kydReportService = kydReportService;
	}

}
