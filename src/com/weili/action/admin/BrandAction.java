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
import com.weili.service.BrandService;

public class BrandAction extends BasePageAction {

	public static Log log = LogFactory.getLog(BrandAction.class);
	
	private BrandService brandService;
	
	/**
	 * 查询品牌
	 * @return
	 */
	public String queryBrandInit(){
		return SUCCESS;
	}
	
	public String queryBrandInfo() throws Exception{
		String name = request("name");
		Integer status = Convert.strToInt(request("status"), -1);
		Long parentId = Convert.strToLong(request("parentId"), -1);
		
		String fieldList = "*";
		String order = "order by sortIndex asc";
		String table = "t_brand";
		
		StringBuffer condition = new StringBuffer();
		
		if(parentId != null){
			condition.append(" and parentId = "+parentId);
		}
		
		if(StringUtils.isNotBlank(name)){
			condition.append(" and `name` LIKE CONCAT('%','"+name.trim()+"','%')");
		}
		if(status != null&&status > 0){
			condition.append(" and `status` = "+status);
		}
		
		brandService.queryBrandPage(pageBean, fieldList, condition, order, table);
		
		return SUCCESS;
	}
	
	public String queryBrandList() throws Exception{
		Long parentId = Convert.strToLong(request("parentId"), -1);

		String fieldList = "*";
		String order = "";
		StringBuffer condition = new StringBuffer();
		condition.append("1=1");
		condition.append(" and parentId = "+parentId);
		
		List<Map<String,Object>> list = brandService.queryBrandAll(fieldList, condition.toString(), "sortIndex asc");
		
		request("list",list);
		request("parentId",parentId);
		return SUCCESS;
	}
	
	/**
	 * 添加品牌
	 * @return
	 */
	public String addBrandInit(){
		Long parentId = Convert.strToLong(request("parentId"), -1);
		request("parentId",parentId);
		return SUCCESS;
	}
	
	public String addBrand() throws Exception{
		String name = request("name");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer type = Convert.strToInt(request("type"), -1);
		Long parentId = Convert.strToLong(request("parentId"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String content = request("content");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(brandService.addBrand(name, content, IConstants.ISLEVEL_OFF, type, parentId, sortIndex, status, seoTitle, seoKeywords, seoDescription));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改品牌
	 * @return
	 * @throws Exception 
	 */
	public String updateBrandInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = brandService.queryBrandById(id);
		return SUCCESS;
	}
	
	public String updateBrand() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		int type = Convert.strToInt(request("type"), -1);
		int isLevel = Convert.strToInt(request("isLevel"), -1);
		String name = request("name");
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String content = request("content");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(brandService.updateBrand(id, name, content, isLevel, type, null, sortIndex, status, seoTitle, seoKeywords, seoDescription));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteBrand() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = brandService.deleteBrand(ids);
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

	public void setBrandService(BrandService brandService) {
		this.brandService = brandService;
	}
	
	
	/**
	 * 查询微力展示内容初始化
	 * @return
	 */
	public String queryWeiliResearchTypeInit(){
		return SUCCESS;
	}
	/**
	 * 查询微力展示内容
	 * @return
	 */
	public String queryWeiliResearchTypeInfo() throws Exception{
		String name = request("name");
		Integer status = Convert.strToInt(request("status"), -1);
		Long parentId = Convert.strToLong(request("parentId"), -1);
		
		String fieldList = "*";
		String order = "order by sortIndex asc";
		String table = "t_brand";
		
		StringBuffer condition = new StringBuffer();
		
		if(parentId != null){
			condition.append(" and parentId = "+parentId);
		}
		
		if(StringUtils.isNotBlank(name)){
			condition.append(" and `name` LIKE CONCAT('%','"+name.trim()+"','%')");
		}
		if(status != null&&status > 0){
			condition.append(" and `status` = "+status);
		}
		
		brandService.queryBrandPage(pageBean, fieldList, condition, order, table);
		
		return SUCCESS;
	}
}
