package com.weili.action.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.MaterialsAttributeService;
import com.weili.service.MaterialsService;

public class MaterialsAttributeAction extends BasePageAction {

	private MaterialsAttributeService materialsAttributeService;
	private MaterialsService materialsService;

	/**
	 * 查询资料属性列表
	 * @return
	 * @throws Exception
	 */
	public String queryMaterialsAttributeList() throws Exception{
		Long materialsId = Convert.strToLong(request("id"), -1);
		List<Map<String,Object>> list = materialsAttributeService.queryMaterialsAttributeAll(materialsId);
		request().setAttribute("list", list);
		paramMap = materialsService.queryMaterialsById(materialsId);
		return SUCCESS;
	}
	
	/**
	 * 添加资料属性初始化
	 * @return
	 * @throws Exception 
	 */
	public String addMaterialsAttributeInit() throws Exception{
		Long materialsId = Convert.strToLong(request("id"), -1);
		List<Map<String,Object>> list = materialsAttributeService.queryMaterialsAttributeAll(materialsId);
		StringBuffer buffer = new StringBuffer();
		for(Map<String,Object> map:list){
			buffer.append(map.get("attributeId")+",");
		}
		String idStr = buffer.toString();
		if(StringUtils.isNotBlank(idStr)){
			idStr = idStr.substring(0, idStr.length()-1);
		}
		List<Map<String,Object>> attributeList = materialsAttributeService.queryMaterialsAttributes(idStr);
		request().setAttribute("attributeList", attributeList);
		paramMap.put("materialsId", materialsId+"");
		return SUCCESS;
	}
	
	/**
	 * 添加资料属性
	 * @return
	 * @throws Exception
	 */
	public String addMaterialsAttribute() throws Exception{
		JSONObject obj = new JSONObject();
		long materialsId = Convert.strToLong(paramMap.get("materialsId"), -1);
		if(materialsId < 0){
			obj.put("msg", "数据错误");
			JSONUtils.printObject(obj);
			return null;
		}
		String attributeIds = paramMap.get("attributeIds");
		if(StringUtils.isBlank(attributeIds)){
			obj.put("msg", "请选择属性");
			JSONUtils.printObject(obj);
			return null;
		}
		long[] attributes = StringCommon.checkTurnIds(attributeIds);
		if(attributes == null||attributes.length <= 0){
			obj.put("msg", "请选择属性");
			JSONUtils.printObject(obj);
			return null;
		}
		int attributeLength = attributes.length;
		long attributeId = -1;
		Map<String,Object> attributeMap;
		List<Map<String,Object>> materialsAttitudeList = new ArrayList<Map<String,Object>>();
		for (int i = 0; i <attributeLength; i++){
			attributeId = attributes[i];
			attributeMap = new HashMap<String, Object>();
			attributeMap.put("attributeId", attributeId);
			materialsAttitudeList.add(attributeMap);
		}
		long returnId = materialsAttributeService.addMaterialsAttribute(materialsAttitudeList,materialsId);
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
	 * 修改资料属性初始化
	 * @return
	 * @throws Exception 
	 */
	public String updateMaterialsAttributeInit() throws Exception{
		Long id = Convert.strToLong(request("id"), -1);
		paramMap = materialsAttributeService.queryMaterialsAttributeById(id);
		String parentId = paramMap.get("parentId");
		List<Map<String,Object>> attributeList = materialsAttributeService.queryAttributesByParentId(parentId);
		request().setAttribute("attributeList", attributeList);
		return SUCCESS;
	}
	
	/**
	 * 修改资料属性
	 * @return
	 * @throws Exception
	 */
	public String updateMaterialsAttribute() throws Exception{
		JSONObject obj = new JSONObject();
		long id = Convert.strToLong(paramMap.get("id"), -1);
		if(id < 0){
			obj.put("msg", "数据错误");
			JSONUtils.printObject(obj);
			return null;
		}
		Long attributeId  = Convert.strToLong(paramMap.get("attributeId"), -1);
		if(attributeId < 0){
			obj.put("msg", "请选择属性");
			JSONUtils.printObject(obj);
			return null;
		}
		long returnId = materialsAttributeService.updateMaterialsAttribute(id, attributeId, null);
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
	 * 删除资料属性
	 * @return
	 * @throws Exception 
	 */
	public String deleteMaterialsAttribute() throws Exception{
		String Ids = request("ids");
		materialsAttributeService.deleteMaterialsAttribute(Ids);
		Long materialsId = Convert.strToLong(request("materialsId"), -1);
		ActionContext.getContext().put("id", materialsId);
		return SUCCESS;
	}

	public void setMaterialsAttributeService(
			MaterialsAttributeService materialsAttributeService) {
		this.materialsAttributeService = materialsAttributeService;
	}

	public void setMaterialsService(MaterialsService materialsService) {
		this.materialsService = materialsService;
	}

}
