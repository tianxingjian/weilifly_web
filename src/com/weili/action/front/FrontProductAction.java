package com.weili.action.front;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.shove.Convert;
import com.weili.constants.IConstants;
import com.weili.service.ParameterService;
import com.weili.service.ProductCategoryService;
import com.weili.service.ProductDetailService;
import com.weili.service.ProductParameterService;
import com.weili.service.ProductService;

public class FrontProductAction extends BaseFrontAction {

	private ProductService productService;
	private ProductCategoryService productCategoryService;
	private ProductParameterService productParameterService;
	private ParameterService parameterService;
	private ProductDetailService productDetailService;
	private Map<String, String> paramNumOneServiceMap;
	
	
	
	/**
	 * 在线客服1
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getParamNumOneServiceMap() throws Exception {
		if(paramNumOneServiceMap==null){
			try {
				paramNumOneServiceMap=getConfigService().queryConfigById(IConstants.CONFIG_ID_AFTERSALES_CONSULTING);	
			} catch (Exception e) {				
				e.printStackTrace();
				throw e;
			}
		}
		return paramNumOneServiceMap;
	}
	
	
	public String productIndex() throws Exception{
		
		List<Map<String,Object>> categoryList = productCategoryService.queryProductCategoryAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " sortIndex asc");
		/*Long categoryId = -1L;
		
		if(categoryList != null&&categoryList.size() > 0){
			categoryId = (Long) categoryList.get(0).get("id");
		}
		Long id = Convert.strToLong(request("id"), categoryId);
		
		paramMap = productCategoryService.queryProductCategoryById(id);*/
		
		request("categoryList",categoryList);
		
		Map<String,String> seoMap = getSeoMap("productIndex.do");
		request("seoMap",seoMap);
		
		return SUCCESS;
	}
	
	public String queryCategoryInfo() throws Exception{
		List<Map<String,Object>> categoryList = productCategoryService.queryProductCategoryAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " sortIndex asc");
		Long categoryId = -1L;
		
		if(categoryList != null&&categoryList.size() > 0){
			categoryId = (Long) categoryList.get(0).get("id");
		}
		Long id = Convert.strToLong(request("id"), categoryId);
		
		paramMap = productCategoryService.queryProductCategoryById(id);
		
		return SUCCESS;
	}
	
	/**
	 * 产品详情 列表
	 * @return
	 * @throws Exception
	 */
	public String productDetail() throws Exception{
		Long categoryId = Convert.strToLong(request("id"), -1);
		
		Map<String,String> categoryMap = productCategoryService.queryProductCategoryById(categoryId);//产品系列Map
		
		List<Map<String,Object>> productList = new ArrayList<Map<String,Object>>();//前四个
		
		productList = productService.queryProductListFour(IConstants.STATUS_ON, categoryId);
		
		List<Map<String,Object>> productMoreList = new ArrayList<Map<String,Object>>();//更多
		
		productMoreList = productService.queryProductListMore(IConstants.STATUS_ON, categoryId);
		
		Long productId = Convert.strToLong(request("pid"), -1);;
		if(productId < 0&&productList != null&&productList.size() > 0){
			productId = (Long) productList.get(0).get("id");
		}
		
		paramMap = productService.queryProductById(productId);
		
		List<Map<String,Object>> productDetailList = new ArrayList<Map<String,Object>>();//产品详情
		
		productDetailList = productDetailService.queryProductDetailList(productId);
		
		for(Map<String,Object> map:productDetailList){
			Integer type = (Integer) map.get("type");
			if(type == 3){
				String imageStr = (String) map.get("images");
				if(StringUtils.isNotBlank(imageStr)){
					String[] images = imageStr.split(",");
					map.put("images", images);
				}
			}
		}
		
		request("categoryMap",categoryMap);
		request("productList",productList);
		request("productMoreList",productMoreList);
		request("productDetailList",productDetailList);
		
		return SUCCESS;
	}
	
	public String productCompare() throws Exception{
		Long id = Convert.strToLong(request("id"), -1);//产品系列ID
		
		paramMap = productCategoryService.queryProductCategoryById(id);
		
		int pageNum = Convert.strToInt(request("curPage"), 1);
		pageBean.setPageNum(pageNum);
		pageBean.setPageSize(4);
		
		productService.queryProductCompare(pageBean,id, IConstants.STATUS_ON);//产品
		
		List<Map<String,Object>> productParameterList = productParameterService.queryProductParameterList();//产品参数
		
		List<Map<String,Object>> parameterList = parameterService.queryParameterList(IConstants.STATUS_ON);//参数
		
//		request("productList",productList);
		request("productParameterList",productParameterList);
		request("parameterList",parameterList);
		
		Map<String,String> seoMap = getSeoMap("productCompare.do");
		request("seoMap",seoMap);
		
		return SUCCESS;
	}
	
	
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}

	public void setProductParameterService(
			ProductParameterService productParameterService) {
		this.productParameterService = productParameterService;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public void setProductDetailService(ProductDetailService productDetailService) {
		this.productDetailService = productDetailService;
	}
	


	public void setParamNumOneServiceMap(Map<String, String> paramNumOneServiceMap) {
		this.paramNumOneServiceMap = paramNumOneServiceMap;
	}

}
