package com.weili.action.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.ProductCategoryService;

public class ProductCategoryAction extends BasePageAction {
	
	public static Log log = LogFactory.getLog(ProductCategoryAction.class);

	private ProductCategoryService productCategoryService;
	
	/**
	 * 添加产品系列
	 * @return
	 */
	public String addProductCategoryInit(){
		return SUCCESS;
	}
	
	public String addProductCategory() throws Exception{
		/*String name,String image,String introduction,String backImage,String url,int status,int sortIndex,String seoTitle,String seoKeywords,String seoDescription*/
		String name = request("name");
		String image = request("image");
		String introduction = request("introduction");
		String backImage = request("backImage");
		String url = request("url");
		int status = Convert.strToInt(request("status"), -1);
		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		int isShow=Convert.strToInt(request("isShow"), -1);
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(productCategoryService.addProductCategory(name, image, introduction, backImage, url, status, sortIndex,isShow, seoTitle, seoKeywords, seoDescription));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改产品系列
	 * @return
	 * @throws Exception 
	 */
	public String updateProductCategoryInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = productCategoryService.queryProductCategoryById(id);
		return SUCCESS;
	}
	
	public String updateProductCategory() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String name = request("name");
		String image = request("image");
		String introduction = request("introduction");
		String backImage = request("backImage");
		String url = request("url");
		int status = Convert.strToInt(request("status"), -1);
		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		int isShow=Convert.strToInt(request("isShow"), -1);
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(productCategoryService.updateProductCategory(id,name, image, introduction, backImage, url, status, sortIndex,isShow, seoTitle, seoKeywords, seoDescription));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 查询产品系列初始化
	 * @return
	 */
	public String queryProductCategoryInit(){
		return SUCCESS;
	}
	
	public String queryProductCategoryInfo() throws Exception{
		
		List<Map<String,Object>> productCategoryList = productCategoryService.queryProductCategoryAll("*", "1=1", " sortIndex asc");
		request("productCategoryList",productCategoryList);
		
		return SUCCESS;
	}
	
	public String deleteProductCategory() throws IOException{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = productCategoryService.deleteProductCategory(ids);
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

	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}
	
}
