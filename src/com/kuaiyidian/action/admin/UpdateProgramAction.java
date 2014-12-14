package com.kuaiyidian.action.admin;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.kuaiyidian.service.ProductCategoryService;
import com.kuaiyidian.service.UpdateProgramService;
import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;

public class UpdateProgramAction extends BasePageAction {

	public static Log log = LogFactory.getLog(UpdateProgramAction.class);
	
	private UpdateProgramService updateProgramService;
	private ProductCategoryService productCategoryService;
	
	private List<Map<String,Object>> categoryList;

	/**
	 * 查询升级程序
	 * @return
	 */
	public String queryUpdateProgramInit(){
		return SUCCESS;
	}
	
	public String queryUpdateProgramInfo() throws Exception{
		String name = request("name");
		Long categoryId = Convert.strToLong(request("categoryId"), -1);
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
		
		String fieldList = "*";
		String order = "order by addTime desc";
		String table = "v_t_update_program";
		
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
		
		updateProgramService.queryUpdateProgramPage(pageBean, fieldList, condition, order, table);
		return SUCCESS;
	}
	
	/**
	 * 添加升级程序
	 * @return
	 */
	public String addUpdateProgramInit(){
		return SUCCESS;
	}
	
	public String addUpdateProgram() throws Exception{
		String name = request("name");
		Long categoryId = Convert.strToLong(request("categoryId"), -1);
		Integer status = Convert.strToInt(request("status"), -1);
		String path = request("path");
		String image = request("image");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(updateProgramService.addUpdateProgram(name, image, path, categoryId, null, null, status, null, null, null));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改升级程序
	 * @return
	 * @throws Exception 
	 */
	public String updateUpdateProgramInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = updateProgramService.queryUpdateProgramById(id);
		return SUCCESS;
	}
	
	public String updateUpdateProgram() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String name = request("name");
		Long categoryId = Convert.strToLong(request("categoryId"), -1);
		Integer status = Convert.strToInt(request("status"), -1);
		String path = request("path");
		String image = request("image");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(updateProgramService.updateUpdateProgram(id,name, image, path, categoryId, null, null, status, null, null, null));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteUpdateProgram() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = updateProgramService.deleteUpdateProgram(ids);
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
	
	public void setUpdateProgramService(UpdateProgramService updateProgramService) {
		this.updateProgramService = updateProgramService;
	}
	
	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}

	public List<Map<String, Object>> getCategoryList() throws Exception {
		if(categoryList == null){
			categoryList = productCategoryService.queryProductCategoryAll("*", "1=1", " sortIndex asc");
		}
		return categoryList;
	}

}
