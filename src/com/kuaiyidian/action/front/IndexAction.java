package com.kuaiyidian.action.front;

import java.util.List;
import java.util.Map;

import com.kuaiyidian.constants.IConstants;
import com.kuaiyidian.service.BannerService;
import com.kuaiyidian.service.WeiliResearchesService;
import com.kuaiyidian.service.ProductService;

public class IndexAction extends BaseFrontAction {
	private BannerService bannerService;
	private WeiliResearchesService weiliResearchesService;
	private ProductService productService;
	
	public String index() throws Exception {
		
		List<Map<String, Object>> newList = weiliResearchesService.queryBrandNewsIndex(IConstants.STATUS_ON);
		
		List<Map<String,Object>> productList = getConfigService().queryProductConfigByType(IConstants.CONFIG_TYPE_PRODUCT);
		
		List<Map<String,Object>> bannerList = bannerService.queryBannerList(IConstants.STATUS_ON, IConstants.BANNER_TYPE_INDEX_PC);
		
		paramMap = getConfigService().queryConfigById(IConstants.CONFIG_ID_ONLINE_VIDEO);
		
		String titleImage = paramMap.get("name");
		String[] titleImages = titleImage.split("ɑ");
		
		paramMap.put("title", titleImages[0]);
		paramMap.put("image", titleImages[1]);
		
		request().setAttribute("newList", newList);
		request().setAttribute("productList", productList);
		request().setAttribute("bannerList", bannerList);
		Map<String,String> seoMap = getSeoMap("index.do");
		request("seoMap",seoMap);
		
		return SUCCESS;
	}
	


	public void setBannerService(BannerService bannerService) {
		this.bannerService = bannerService;
	}


	public void setWeiliResearchesService(
			WeiliResearchesService weiliResearchesService) {
		this.weiliResearchesService = weiliResearchesService;
	}



	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

}
