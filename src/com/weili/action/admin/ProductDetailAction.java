package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.constants.IConstants;
import com.weili.service.ProductDetailService;
import com.weili.service.ProductService;

public class ProductDetailAction extends BasePageAction {
	
	private Log log = LogFactory.getLog(ProductDetailAction.class);
	
	private ProductDetailService productDetailService;
	private ProductService productService;
	
	/**
	 * 查询产品详情列表
	 * @return
	 */
	public String queryProductDetailList() throws Exception{
		Long productId = Convert.strToLong(request("id"), -1);
		Long parentId = Convert.strToLong(request("parentId"), -1);
		
		List<Map<String,Object>> list = productDetailService.queryProductDetailAll(productId,parentId);
		
		request().setAttribute("list", list);
		if(parentId < 0){
			paramMap = productService.queryProductById(productId);
		}else if(parentId > 0){
			paramMap = productDetailService.queryProductDetailById(parentId);
		}
		
		if(parentId < 0){
			return SUCCESS;
		}
		if(parentId > 0){
			request("parentId",parentId);
			return "child";
		}
		return SUCCESS;
		
	}
	
	/**
	 * 修改产品详情
	 * @return
	 * @throws Exception 
	 */
	public String updateProductDetailInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = productDetailService.queryProductDetailById(id);
		
		int type = Convert.strToInt(paramMap.get("type"), -1);
		if(type == 3){
			String[] images = null;
			
			String imageStrs = paramMap.get("images");
			if(StringUtils.isNotBlank(imageStrs)){
				images = imageStrs.split(",");
			}
			
			request("images", images);
		}
		
		return SUCCESS;
	}
	
	public String updateProductDetail() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String name = request("name");
		String content = request("content");
		Long productId = Convert.strToLong(request("productId"), -1);
		Integer status = Convert.strToInt(request("status"), -1);
		String introduction = request("introduction");
		String image = request("image");
		String backImage = request("backImage");
		String images = request("images");
		Long parentId = Convert.strToLong(request("parentId"), -1);
		int type = Convert.strToInt(request("type"), -1);
//		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(productDetailService.updateProductDetail(id, name, productId, content, introduction, image, images, parentId, type, null, status,backImage));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String addProductDetailInit() throws Exception{
		Long id = Convert.strToLong(request("id"), -1);
		Map<String,String> parentMap = productDetailService.queryProductDetailById(id);
		
		request("parentMap",parentMap);
		return SUCCESS;
	}
	
	public String addProductDetail() throws Exception{
		String name = request("name");
		String content = request("content");
		Long productId = Convert.strToLong(request("productId"), -1);
		Integer status = Convert.strToInt(request("status"), -1);
		String introduction = request("introduction");
		String image = request("image");
		String backImage = request("backImage");
		String images = request("images");
		Long parentId = Convert.strToLong(request("parentId"), -1);
		int type = Convert.strToInt(request("type"), -1);
		int chilType = -1;
		if(type == IConstants.PRODUCT_DETAIL_TYPE_HASPHONE){
			chilType = IConstants.PRODUCT_DETAIL_TYPE_PHONE;
		}else if(type == IConstants.PRODUCT_DETAIL_TYPE_HASZHEN){
			chilType = IConstants.PRODUCT_DETAIL_TYPE_ZHEN;
		}else if(type == IConstants.PRODUCT_DETAIL_TYPE_HASQUESTION){
			chilType = IConstants.PRODUCT_DETAIL_TYPE_QUESTION;
		}else if(type == IConstants.PRODUCT_DETAIL_TYPE_HASIMAGESCHILD){
			chilType = IConstants.PRODUCT_DETAIL_TYPE_IMAGESCHILD;
		}
//		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(productDetailService.addProductDetail(name, productId, content, introduction, image, images, parentId, chilType, null, status,backImage));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteProductDetail() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = productDetailService.deleteProductDetail(ids);
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

	public void setProductDetailService(ProductDetailService productDetailService) {
		this.productDetailService = productDetailService;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

}
