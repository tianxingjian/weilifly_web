package com.weili.action.front;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.weili.constants.IConstants;
import com.weili.service.BrandService;
import com.weili.service.ProductCategoryService;


public class FrontWebsiteMapAction extends FrontInfoContentAction{
	
	private ProductCategoryService productCategoryService;
	private BrandService brandService;
	
	
	/***
	 * 初始化
	 * @return
	 * @throws Exception 
	 */
	public String mapInit() throws Exception {
		List<Map<String,Object>> categoryList = productCategoryService.queryProductCategoryAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " sortIndex asc");
		request("categoryList",categoryList);
		List<Map<String, Object>> brandList =brandService.queryBrandAll("id,name", " 1=1 and parentId=-1 and status="+IConstants.STATUS_ON, "sortIndex asc");
		request().setAttribute("brandList", brandList);
		List<Map<String, Object>> infoContentList =getInfoContentService().queryInfoContentAll("*", " 1=1 and infoId=6 and status=1", "sortIndex asc");
		request().setAttribute("infoContentList", infoContentList);
		List<Map<String, Object>> infoContentList2 =getInfoContentService().queryInfoContentAll("*", " 1=1 and infoId=1 and status=1", "sortIndex asc");
		request().setAttribute("infoContentList2", infoContentList2);
		List<Map<String, Object>> infoContentList3 =getInfoContentService().queryInfoContentAll("*", " 1=1 and infoId=5 and status=1", "sortIndex asc");
		request().setAttribute("infoContentList3", infoContentList3);
		HttpServletRequest request=ServletActionContext.getRequest();
        String a=request.getParameter("a");
        request("a",a);
		Map<String,String> seoMap = getSeoMap("mapInit.do?a=3a");//seo
		request("seoMap",seoMap);
		return SUCCESS;
	}
		
	

	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}


	public void setBrandService(BrandService brandService) {
		this.brandService = brandService;
	}


		
	
}
