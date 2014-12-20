package com.weili.action.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.xwork2.ActionContext;
import com.shove.Convert;
import com.shove.data.DataException;
import com.shove.web.action.BasePageAction;
import com.weili.constants.IConstants;
import com.weili.service.AttributeService;
import com.weili.service.ProductService;

public class AttributeAction extends BasePageAction {
	
	public static Log log = LogFactory.getLog(AttributeAction.class);

	private AttributeService attributeService;
	private ProductService productService;
	
	private List<Map<String,Object>> productList;

	/**
	 * 查询属性初始化
	 * @return
	 */
	public String queryAttributeInit(){
		return SUCCESS;
	}

	/**
	 * 查询属性初始化
	 * @return
	 * @throws SQLException 
	 * @throws DataException 
	 */
	public String queryAttributeSonInit() throws Exception{
		Long parentId = Convert.strToLong(request("parentId"), -1);
		paramMap = attributeService.queryAttributeById(parentId);
		request().setAttribute("parentId", parentId);
		return SUCCESS;
	}
	
	/**
	 * 查询属性信息
	 * @return
	 * @throws DataException 
	 * @throws SQLException 
	 */
	public String queryAttributeInfo() throws Exception{
		String name = paramMap.get("name");
		Long parentId = Convert.strToLong(paramMap.get("parentId"), -1);
		
		String fieldList = "*";
		String order = "order by sortIndex asc";
		String table = "t_attribute";
		
		StringBuffer condition = new StringBuffer();
		
		if(StringUtils.isNotBlank(name)){
			condition.append(" and `name` LIKE CONCAT('%','"+name.trim()+"','%')");
		}
		if(parentId != null){
			condition.append(" and parentId = "+parentId);
		}
		attributeService.queryAttributePage(pageBean, fieldList, condition.toString(), order, table);
		request().setAttribute("parentId", parentId);
		return SUCCESS;
	}

	/**
	 * 添加属性初始化
	 * @return
	 */
	public String addAttributeInit(){
		Long parentId = Convert.strToLong(request("parentId"), -1);
		request().setAttribute("parentId", parentId);
		return SUCCESS;
	}
	
	/**
	 * 添加属性信息
	 * @return
	 * @throws Exception 
	 */
	public String addAttribute() throws Exception{
		Long parentId = Convert.strToLong(paramMap.get("parentId"), -1);
		request().setAttribute("parentId", parentId);
		String name = paramMap.get("name");
		if(StringUtils.isBlank(name)){
			this.addFieldError("paramMap.name", "属性不能为空");
			return INPUT;
		}
		Integer sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		if(sortIndex<0){
			this.addFieldError("paramMap.sortIndex", "排序格式输入不正确");
			return INPUT;
		}
		String productIds = paramMap.get("productIds");
		if(parentId == IConstants.ATTRIBUTE_ID_MODULE&&StringUtils.isBlank(productIds)){
			this.addFieldError("paramMap.productIds", "请选择关联产品");
			return INPUT;
		}
		Integer status = Convert.strToInt(paramMap.get("status"), -1);
		if(status < 0){
			this.addFieldError("paramMap.status", "请选择是否显示");
			return INPUT;
		}
		
		attributeService.addAttribute(name, parentId, sortIndex, status,productIds);
		
		if(parentId == -1){
			return "attribute";
		}else{
			ActionContext.getContext().put("parentId", parentId);
			return "attributeSon";
		}
	}
	
	/**
	 * 修改属性信息初始化
	 * @return
	 * @throws SQLException 
	 * @throws DataException 
	 */
	public String updateAttributeInit() throws Exception{
		Long parentId = Convert.strToLong(request("parentId"), -1);
		Long id = Convert.strToLong(request("id"), -1);
		paramMap = attributeService.queryAttributeById(id);
		String productIds = paramMap.get("productIds");
		if(StringUtils.isNotBlank(productIds)){
			String[] products = productIds.split(",");
			request("products",products);
		}
		
		request().setAttribute("parentId", parentId);
		return SUCCESS;
	}
	
	/**
	 * 修改属性信息
	 * @return
	 * @throws Exception 
	 */
	public String updateAttribute() throws Exception{
		long id = Convert.strToLong(paramMap.get("id"), -1);
		Long parentId = Convert.strToLong(paramMap.get("parentId"), -1);
		request().setAttribute("parentId", parentId);
		Integer sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		if(sortIndex<0){
			this.addFieldError("paramMap.sortIndex", "排序格式输入不正确");
			return INPUT;
		}
		String name = paramMap.get("name");
		if(StringUtils.isBlank(name)){
			this.addFieldError("paramMap.name", "属性不能为空");
			return INPUT;
		}
		
		String productIds = paramMap.get("productIds");
		if(parentId == IConstants.ATTRIBUTE_ID_MODULE&&StringUtils.isBlank(productIds)){
			this.addFieldError("paramMap.productIds", "请选择关联产品");
			return INPUT;
		}
		
		Integer status = Convert.strToInt(paramMap.get("status"), -1);
		if(status < 0){
			this.addFieldError("paramMap.status", "请选择是否显示");
			return INPUT;
		}
		
		attributeService.updateAttribute(id, name, parentId, sortIndex, status,productIds);
		
		if(parentId == -1){
			return "attribute";
		}else{
			ActionContext.getContext().put("parentId", parentId);
			return "attributeSon";
		}
	}
	
	/**
	 * 删除属性
	 * @return
	 * @throws SQLException
	 */
	public String deleteAttribute() throws Exception{
		Long parentId = Convert.strToLong(request("parentId"), -1);
		request().setAttribute("parentId", parentId);
		String Ids = request("ids");
		attributeService.deleteAttribute(Ids);
		if(parentId == -1){
			return "attribute";
		}else{
			ActionContext.getContext().put("parentId", parentId);
			return "attributeSon";
		}
	}

	public void setAttributeService(AttributeService attributeService) {
		this.attributeService = attributeService;
	}
	
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public List<Map<String, Object>> getProductList() throws Exception {
		if(productList == null){
			productList = productService.queryProductAll("*", "1=1", "");
		}
		return productList;
	}
	
}
