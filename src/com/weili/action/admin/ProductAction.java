package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.constants.IConstants;
import com.weili.service.ParameterService;
import com.weili.service.ProductCategoryService;
import com.weili.service.ProductService;

public class ProductAction extends BasePageAction {

	public static Log log = LogFactory.getLog(ProductAction.class);
	
	private ProductService productService;
	private ProductCategoryService productCategoryService;
	private ParameterService parameterService;
	
	private List<Map<String,Object>> categoryList;
	private List<Map<String,Object>> parameterList;

	/**
	 * 添加产品初始化
	 * @return
	 */
	public String addProductInit(){
		return SUCCESS;
	}
	
	public String addProduct() throws Exception{
		String name = request("name");
		long categoryId = Convert.strToLong(request("categoryId"), -1);
		int status = Convert.strToInt(request("status"), -1);
		String url = request("url");
		String wapUrl = request("wapUrl");
		String image = request("image");
		String details = request("details");
		String parameters = request("parameters");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String content = request("content");
		int isShow=Convert.strToInt(request("isShow"), -1);
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(productService.addProduct(name, categoryId, image, url, wapUrl, details, sortIndex, status, seoTitle, seoKeywords, seoDescription, parameters,content,isShow));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String queryProductInit(){
		return SUCCESS;
	}
	
	/**
	 * 修改产品
	 * @return
	 * @throws Exception
	 */
	public String updateProductInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = productService.queryProductById(id);
		return SUCCESS;
	}
	
	public String updateProduct() throws Exception{
		
		long id = Convert.strToLong(request("id"), -1);
		String name = request("name");
		long categoryId = Convert.strToLong(request("categoryId"), -1);
		int status = Convert.strToInt(request("status"), -1);
		String url = request("url");
		String wapUrl = request("wapUrl");
		String image = request("image");
		String details = request("details");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String content = request("content");
		int isShow=Convert.strToInt(request("isShow"), -1);
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(productService.updateProduct(id, name, categoryId, image, url, wapUrl, details, sortIndex, status, seoTitle, seoKeywords, seoDescription,content,isShow));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String queryProductInfo() throws Exception{
		
		Long categoryId = Convert.strToLong(request("categoryId"), -1);
		String name = request("name");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		Integer sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		String fieldList = "*";
		String order = "order by sortIndex,addTime desc";
		String table = "v_t_product_info";
		
		StringBuffer condition = new StringBuffer();
		
		if(categoryId != null && categoryId > 0){
			condition.append(" and categoryId = "+categoryId);
		}
		if(sortIndex != null && sortIndex > 0){
			condition.append(" and sortIndex = "+sortIndex);
		}
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
		
		productService.queryProductPage(pageBean, fieldList, condition, order, table);
		
		return SUCCESS;
	}
	
	/**
	 * 绑定产品
	 * @return
	 */
	public String queryProductRadioInit(){
		return SUCCESS;
	}
	
	public String queryProductRadioInfo() throws Exception{
		Long categoryId = Convert.strToLong(request("categoryId"), -1);
		String name = request("name");
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		
		String fieldList = "*";
		String order = "order by addTime desc";
		String table = "v_t_product_info";
		
		StringBuffer condition = new StringBuffer();
		
		if(categoryId != null && categoryId > 0){
			condition.append(" and categoryId = "+categoryId);
		}
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
		
		productService.queryProductPage(pageBean, fieldList, condition, order, table);
		
		return SUCCESS;
	}
	
	public String deleteProduct() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = productService.deleteProduct(ids);
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
	
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public List<Map<String, Object>> getCategoryList() throws Exception {
		if(categoryList == null){
			categoryList = productCategoryService.queryProductCategoryAll("*", "1=1", " sortIndex asc");
		}
		return categoryList;
	}

	public List<Map<String, Object>> getParameterList() throws Exception {
		if(parameterList == null){
			parameterList = parameterService.queryParameterAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " sortIndex asc");
		}
		return parameterList;
	}
	
}
