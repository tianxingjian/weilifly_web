package com.weili.action.admin;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.AdvertisementService;

public class AdvertisementAction extends BasePageAction {

	public static Log log = LogFactory.getLog(AdvertisementAction.class);
	
	private AdvertisementService advertisementService;
	
	/**
	 * 查询广告片
	 * @return
	 */
	public String queryAdvertisementInit(){
		return SUCCESS;
	}
	
	public String queryAdvertisementInfo() throws Exception{
		String name = request("name");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		
		String fieldList = "*";
		String order = "order by addTime desc";
		String table = "t_appadv";
		
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
		
		advertisementService.queryAdvertisementerPage(pageBean, fieldList, condition, order, table);
		return SUCCESS;
	}
	
	/**
	 * 添加广告片
	 * @return
	 */
	public String addAdvertisementInit(){
		return SUCCESS;
	}
	
	public String addAdvertisement() throws Exception{
		String name = request("name");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer isRecommended = Convert.strToInt(request("isRecommended"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String androidPath = request("androidPath");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String iosPath = request("iosPath");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(advertisementService.addAdvertisement(name, image, androidPath, isRecommended, sortIndex, status, seoTitle, seoKeywords, seoDescription,iosPath));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改广告片
	 * @return
	 * @throws Exception 
	 */
	public String updateAdvertisementInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = advertisementService.queryAdvertisementById(id);
		return SUCCESS;
	}
	
	public String updateAdvertisement() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String name = request("name");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer isRecommended = Convert.strToInt(request("isRecommended"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String androidPath = request("androidPath");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		String iosPath = request("iosPath");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(advertisementService.updateAdvertisement(id, name, image, androidPath, isRecommended, sortIndex, status, seoTitle, seoKeywords, seoDescription,iosPath));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteAdvertisement() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = advertisementService.deleteAdvertisement(ids);
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

	public void setAdvertisementService(AdvertisementService advertisementService) {
		this.advertisementService = advertisementService;
	}

}
