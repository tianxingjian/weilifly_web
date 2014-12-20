package com.weili.action.front;

import java.util.List;
import java.util.Map;

import com.weili.constants.IConstants;
import com.weili.service.BannerService;
import com.weili.service.WeiliDisplayService;

public class IndexAction extends BaseFrontAction {
	private static final long serialVersionUID = 1L;
	private WeiliDisplayService weiliDisplayService;
	
	private BannerService bannerService;
	

	public String index() throws Exception {
		
		//微力研究院id=1     WEILI_RESEARCH_ID  包含typeId=6,7,8
		//标杆案例    id=2     WEILI_CASE_ID   包含typeId=9,10
		//o2o兵器库 id=3     WEILI_O2O_ID    包含typeId=11,12,13,14,15,16
		//第一步：通过id找出子类的list或map
		//第二步：根据子类id查找所有对应的内容list（这个可以展示出去）
//		Integer id = Convert.strToInt(request("id"), -1);
		
		//调用查询方法查询子类的id目录
		List<Map<String, Object>> researchTypeList = weiliDisplayService.queryDisplayIndex(IConstants.WEILI_RESEARCH_ID);
		
		List<Map<String, Object>> caseTypeList = weiliDisplayService.queryDisplayIndex(IConstants.WEILI_CASE_ID);
		
		List<Map<String, Object>> o2OTypeList = weiliDisplayService.queryDisplayIndex(IConstants.WEILI_O2O_ID);
		
		List<Map<String, Object>> newestList = weiliDisplayService.queryNewestIndex();
		
		//将每个目录对应的子目录id分别放在不同的StringBuffer对象中
		StringBuffer researchType = new StringBuffer();
		StringBuffer caseType = new StringBuffer();
		StringBuffer o2OType = new StringBuffer();
		
		for(Map<String,Object> map:researchTypeList){
			researchType.append(map.get("id")+",");
		}
		researchType.deleteCharAt(researchType.length()-1);
		for(Map<String,Object> map:caseTypeList){
			caseType.append(map.get("id")+",");
		}
		caseType.deleteCharAt(caseType.length()-1);
		for(Map<String,Object> map:o2OTypeList){
			o2OType.append(map.get("id")+",");
		}
		o2OType.deleteCharAt(o2OType.length()-1);
		//~
		
		
//		//首页推荐显示的列表（limit 5）
//				StringBuffer condition = new StringBuffer();
//				condition.append(" 1=1 and typeId in ("+type+") and isIndex = 1 limit 0 ,5 ");
//				List<Map<String, Object>> DisplayIndexList = weiliDisplayService.queryDisplayByRecommendId(condition);
		//第二步：通过子id目录查找文章列表,首页推荐显示的列表（limit 5）
		List<Map<String, Object>> researchList = weiliDisplayService.queryDisplayByRecommendId(researchType);
		
		List<Map<String, Object>> caseList = weiliDisplayService.queryDisplayByRecommendCase(caseType);
		
		List<Map<String, Object>> o2OList = weiliDisplayService.queryDisplayByRecommendId(o2OType);
		
		
		request().setAttribute("researchList", researchList);
		request().setAttribute("caseList", caseList);
		request().setAttribute("o2OList", o2OList);
		request().setAttribute("newestList", newestList);
		
//		List<Map<String,Object>> productList = getConfigService().queryProductConfigByType(IConstants.CONFIG_TYPE_PRODUCT);
		List<Map<String,Object>> bannerList = bannerService.queryBannerList(IConstants.STATUS_ON, IConstants.BANNER_TYPE_INDEX_PC);
		
		paramMap = getConfigService().queryConfigById(IConstants.CONFIG_ID_ONLINE_VIDEO);
		
		String titleImage = paramMap.get("name");
		String[] titleImages = titleImage.split("ɑ");
		
		paramMap.put("title", titleImages[0]);
		paramMap.put("image", titleImages[1]);
		
		//request().setAttribute("newList", newList);
		//request().setAttribute("productList", productList);
		request().setAttribute("bannerList", bannerList);
		Map<String,String> seoMap = getSeoMap("index.do");
		request("seoMap",seoMap);
		
		
		
		return SUCCESS;
	}

	
	

	public void setBannerService(BannerService bannerService) {
		this.bannerService = bannerService;
	}



	public void setWeiliDisplayService(WeiliDisplayService weiliDisplayService) {
		this.weiliDisplayService = weiliDisplayService;
	}


}
