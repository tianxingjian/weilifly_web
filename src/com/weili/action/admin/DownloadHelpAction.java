package com.weili.action.admin;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.DownloadHelpService;

public class DownloadHelpAction extends BasePageAction {

	public static Log log = LogFactory.getLog(DownloadHelpAction.class);
	
	private DownloadHelpService downloadHelpService;
	
	/**
	 * 查询升级程序
	 * @return
	 */
	public String queryDownloadHelpInit(){
		return SUCCESS;
	}
	
	public String queryDownloadHelpInfo() throws Exception{
		String title = request("title");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		
		String fieldList = "*";
		String order = "order by sortIndex asc";
		String table = "t_download_help";
		
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
		
		downloadHelpService.queryDownloadHelpPage(pageBean, fieldList, condition, order, table);
		return SUCCESS;
	}
	
	/**
	 * 添加升级程序
	 * @return
	 */
	public String addDownloadHelpInit(){
		return SUCCESS;
	}
	
	public String addDownloadHelp() throws Exception{
		String title = request("title");
		String fit = request("fit");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String content = request("content");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String image=request("image");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(downloadHelpService.addDownloadHelp(title, content,fit,sortIndex, status, seoTitle, seoKeywords, seoDescription,image));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改升级程序
	 * @return
	 * @throws Exception 
	 */
	public String updateDownloadHelpInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = downloadHelpService.queryDownloadHelpById(id);
		return SUCCESS;
	}
	
	public String updateDownloadHelp() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String title = request("title");
		String fit = request("fit");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String content = request("content");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String image=request("image");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(downloadHelpService.updateDownloadHelp(id, title, content,fit,sortIndex, status, seoTitle, seoKeywords, seoDescription,image));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteDownloadHelp() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = downloadHelpService.deleteDownloadHelp(ids);
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

	public void setDownloadHelpService(DownloadHelpService downloadHelpService) {
		this.downloadHelpService = downloadHelpService;
	}
	
}
