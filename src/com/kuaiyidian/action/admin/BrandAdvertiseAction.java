package com.kuaiyidian.action.admin;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.kuaiyidian.service.BrandAdvertiseService;
import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;

public class BrandAdvertiseAction extends BasePageAction {

	public static Log log = LogFactory.getLog(BrandAdvertiseAction.class);
	
	private BrandAdvertiseService brandAdvertiseService;
	
	/**
	 * 查询品牌广告
	 * @return
	 */
	public String queryBrandAdvertiseInit(){
		return SUCCESS;
	}
	
	public String queryBrandAdvertiseInfo() throws Exception{
		String title = request("title");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		
		String fieldList = "*";
		String order = "order by addTime desc";
		String table = "t_brand_advertise";
		
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
		
		brandAdvertiseService.queryBrandAdvertisePage(pageBean, fieldList, condition, order, table);
		return SUCCESS;
	}
	
	/**
	 * 添加品牌广告
	 * @return
	 */
	public String addBrandAdvertiseInit(){
		return SUCCESS;
	}
	
	public String addBrandAdvertise() throws Exception{
		String title = request("title");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String path = request("path");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(brandAdvertiseService.addBrandAdvertise(title, null, image,path, status, sortIndex, seoTitle, seoKeywords, seoDescription));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改品牌广告
	 * @return
	 * @throws Exception 
	 */
	public String updateBrandAdvertiseInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = brandAdvertiseService.queryBrandAdvertiseById(id);
		return SUCCESS;
	}
	
	public String updateBrandAdvertise() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String title = request("title");
		String image = request("image");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String path = request("path");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(brandAdvertiseService.updateBrandAdvertise(id, title, null,image, path, status, sortIndex, seoTitle, seoKeywords, seoDescription));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteBrandAdvertise() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = brandAdvertiseService.deleteBrandAdvertise(ids);
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

	public void setBrandAdvertiseService(BrandAdvertiseService brandAdvertiseService) {
		this.brandAdvertiseService = brandAdvertiseService;
	}
	
}
