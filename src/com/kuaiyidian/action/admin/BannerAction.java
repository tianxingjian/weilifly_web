package com.kuaiyidian.action.admin;

import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;

import com.kuaiyidian.service.BannerService;
import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;


public class BannerAction extends BasePageAction<Map<String, Object>> {
		
	private BannerService bannerService;
	
	
	/**
	 * 添加Banner初始化
	 * @return
	 */
	public String addBannerInit() {
		return SUCCESS;
	}
	
	
	public String addBanner() throws Exception {
		String title=paramMap.get("title");
		String imgPath=paramMap.get("imgPath");
		String imgUrl=paramMap.get("imgUrl");
		String imgFont=paramMap.get("imgFont");
		String url=paramMap.get("url");
		String urlTwo=paramMap.get("urlTwo");
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		int type=Convert.strToInt(paramMap.get("type"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		Long result=bannerService.addBanner(title, imgPath,imgUrl,imgFont, url,urlTwo, sortIndex, type, status);
		if(result<0){
			this.addFieldError("errorMessage","添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 修改Banner
	 * @return
	 * @throws Exception
	 */
	public String updateBannerInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=bannerService.queryBannerById(id);
		return SUCCESS;
	}
	
	
	public String updateBanner() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String title=paramMap.get("title");
		String imgPath=paramMap.get("imgPath");
		String imgUrl=paramMap.get("imgUrl");
		String imgFont=paramMap.get("imgFont");
		String url=paramMap.get("url");
		String urlTwo=paramMap.get("urlTwo");
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		int type=Convert.strToInt(paramMap.get("type"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		
		JSONObject obj = new JSONObject();

		obj.putAll(bannerService.updateBanner(id, title, imgPath,imgUrl,imgFont, url,urlTwo, sortIndex, type, status));

		JSONUtils.printObject(obj);
		
		return null;
	}
	
	
	
	/**
	 * 列表初始化
	 * @return
	 */
	public String queryBannerInit() {
		return SUCCESS;
	}
	
	
	public  String queryBanner() throws Exception {
		String title=request("title");
		int type=Convert.strToInt(request("type"), -1);
		int sortIndex=Convert.strToInt(request("sortIndex"), -1);
		StringBuffer condition=new StringBuffer();
		if(StringUtils.isNotBlank(title)){
			condition.append(" AND title like concat('%','"+title+"','%')");			
		}
		if(type>0){
			condition.append(" AND type="+type);
		}
		if(sortIndex>0){
			condition.append(" AND sortIndex="+sortIndex);
		}		
		bannerService.queryBannerPage(pageBean, "*", condition, " order by addTime desc", "t_banner");
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}
	
	
	/**
	 * 删除
	 * @return
	 * @throws Exception
	 */
	public String deleteBanner() throws Exception {
		String ids=request("id");
		Long result=bannerService.deleteBanner(ids);
		if(result<0){
			this.addFieldError("errorMessage","删除失败");
			return INPUT;
		}
		return SUCCESS;
	}


	public void setBannerService(BannerService bannerService) {
		this.bannerService = bannerService;
	}
	
	
}
