package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.ParameterService;

public class ParameterAction extends BasePageAction {

	private ParameterService parameterService;

	/**
	 * 查询颜色列表
	 * @return
	 * @throws Exception
	 */
	public String queryParameterList() throws Exception{
		StringBuffer condition = new StringBuffer();
		
		condition.append(" 1 = 1");
		
		List<Map<String,Object>> list = parameterService.queryParameterAll("*", condition.toString(), " sortIndex asc");
		request().setAttribute("list", list);
		return SUCCESS;
	}
	
	/**
	 * 添加颜色初始化
	 * @return
	 */
	public String addParameterInit(){
		
		return SUCCESS;
	}
	
	/**
	 * 添加颜色
	 * @return
	 * @throws Exception
	 */
	public String addParameter() throws Exception{
		String name = paramMap.get("name");
		if(StringUtils.isBlank(name)){
			this.addFieldError("paramMap.name", "颜色不能为空");
			return INPUT;
		}
		if(name.length() > 50){
			this.addFieldError("paramMap.name", "长度不能大于50");
			return INPUT;
		}
		Integer sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		if(sortIndex < 0){
			this.addFieldError("paramMap.sortIndex", "排序格式不正确");
			return INPUT;
		}
		Integer status = Convert.strToInt(paramMap.get("status"), -1);
		if(status < 0){
			this.addFieldError("paramMap.status", "请选择是否启用");
			return INPUT;
		}
		parameterService.addParameter(name, sortIndex,status);
		return SUCCESS;
	}
	
	/**
	 * 修改颜色初始化
	 * @return
	 * @throws Exception 
	 */
	public String updateParameterInit() throws Exception{
		Long id = Convert.strToLong(request("id"), -1);
		paramMap = parameterService.queryParameterById(id);
		return SUCCESS;
	}
	
	/**
	 * 修改颜色
	 * @return
	 * @throws Exception
	 */
	public String updateParameter() throws Exception{
		Long id = Convert.strToLong(paramMap.get("id"), -1);
		String name = paramMap.get("name");
		if(StringUtils.isBlank(name)){
			this.addFieldError("paramMap.name", "颜色不能为空");
			return INPUT;
		}
		if(name.length() > 50){
			this.addFieldError("paramMap.name", "长度不能大于50");
			return INPUT;
		}
		Integer sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		if(sortIndex < 0){
			this.addFieldError("paramMap.sortIndex", "排序格式不正确");
			return INPUT;
		}
		Integer status = Convert.strToInt(paramMap.get("status"), -1);
		if(status < 0){
			this.addFieldError("paramMap.status", "请选择是否启用");
			return INPUT;
		}
		parameterService.updateParameter(id, name, sortIndex,status);
		return SUCCESS;
	}
	
	/**
	 * 删除颜色
	 * @return
	 * @throws Exception 
	 */
	public String deleteParameter() throws Exception{
		String Ids = request("ids");
		parameterService.deleteParameter(Ids);
		return SUCCESS;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}
	
}
