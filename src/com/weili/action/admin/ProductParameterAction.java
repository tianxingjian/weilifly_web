package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.ProductParameterService;
import com.weili.service.ProductService;

public class ProductParameterAction extends BasePageAction {

	private ProductParameterService productParameterService;
	private ProductService productService;

	/**
	 * 查询产品参数列表
	 * @return
	 * @throws Exception
	 */
	public String queryProductParameterList() throws Exception{
		Long productId = Convert.strToLong(request("id"), -1);
		List<Map<String,Object>> list = productParameterService.queryProductParameterAll(productId);
		request().setAttribute("list", list);
		paramMap = productService.queryProductById(productId);
		return SUCCESS;
	}
	
	/**
	 * 添加产品参数初始化
	 * @return
	 * @throws Exception 
	 */
	public String addProductParameterInit() throws Exception{
		Long productId = Convert.strToLong(request("id"), -1);
		List<Map<String,Object>> list = productParameterService.queryProductParameterAll(productId);
		StringBuffer buffer = new StringBuffer();
		for(Map<String,Object> map:list){
			buffer.append(map.get("parameterId")+",");
		}
		String idStr = buffer.toString();
		if(StringUtils.isNotBlank(idStr)){
			idStr = idStr.substring(0, idStr.length()-1);
		}
		List<Map<String,Object>> parameterList = productParameterService.queryProductParameters(idStr);
		request().setAttribute("parameterList", parameterList);
		paramMap.put("productId", productId+"");
		return SUCCESS;
	}
	
	/**
	 * 添加产品参数
	 * @return
	 * @throws Exception
	 */
	public String addProductParameter() throws Exception{
		JSONObject obj = new JSONObject();
		long productId = Convert.strToLong(paramMap.get("productId"), -1);
		if(productId < 0){
			obj.put("msg", "数据错误");
			JSONUtils.printObject(obj);
			return null;
		}
		long parameterId = Convert.strToLong(paramMap.get("parameterId"), -1);
		if(parameterId < 0){
			obj.put("msg", "请选择参数");
			JSONUtils.printObject(obj);
			return null;
		}
		String content = paramMap.get("content");
		if(StringUtils.isBlank(content)){
			obj.put("msg", "请输入参数内容");
			JSONUtils.printObject(obj);
			return null;
		}
		long returnId = productParameterService.addProductParameter(productId, parameterId, content);
		if(returnId < 0){
			obj.put("msg", "添加失败");
			JSONUtils.printObject(obj);
			return null;
		}
		obj.put("msg", "1");
		JSONUtils.printObject(obj);
		return null;
	}
	
	/**
	 * 修改产品参数初始化
	 * @return
	 * @throws Exception 
	 */
	public String updateProductParameterInit() throws Exception{
		Long id = Convert.strToLong(request("id"), -1);
		paramMap = productParameterService.queryProductParameterById(id);
		return SUCCESS;
	}
	
	/**
	 * 修改产品参数
	 * @return
	 * @throws Exception
	 */
	public String updateProductParameter() throws Exception{
		JSONObject obj = new JSONObject();
		long id = Convert.strToLong(paramMap.get("id"), -1);
		if(id < 0){
			obj.put("msg", "数据错误");
			JSONUtils.printObject(obj);
			return null;
		}
		String content = paramMap.get("content");
		if(StringUtils.isBlank(content)){
			obj.put("msg", "请输入参数内容");
			JSONUtils.printObject(obj);
			return null;
		}
		long returnId = productParameterService.updateProductParameter(id, null, null, content);
		if(returnId < 0){
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}
		obj.put("msg", "1");
		JSONUtils.printObject(obj);
		return null;
	}
	
	/**
	 * 删除产品参数
	 * @return
	 * @throws Exception 
	 */
	public String deleteProductParameter() throws Exception{
		String Ids = request("ids");
		productParameterService.deleteProductParameter(Ids);
		Long productId = Convert.strToLong(request("productId"), -1);
		ActionContext.getContext().put("id", productId);
		return SUCCESS;
	}

	public void setProductParameterService(
			ProductParameterService productParameterService) {
		this.productParameterService = productParameterService;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

}
