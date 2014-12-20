package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.RegionService;
import com.weili.service.WebDistributeService;
import com.weili.service.WebDistributeTypeService;

public class WebDistributeAction extends BasePageAction<Map<String, Object>> {

	private WebDistributeService webDistributeService; // 网点分布
	private WebDistributeTypeService webDistributeTypeService;//网点分布类型 
	private RegionService regionService;

	private List<Map<String, Object>> provinceList;
	
	private List<Map<String, Object>> webDistributeTypeList;   //网点分布类型

	public void setRegionService(RegionService regionService) {
		this.regionService = regionService;
	}

	
	//获取网点分布类型
	public List<Map<String, Object>> getWebDistributeTypeList() throws Exception {
		if(webDistributeTypeList==null){
			StringBuffer condition=new StringBuffer();
			try {
				webDistributeTypeList=webDistributeTypeService.queryWebDistributeTypeAll("*", condition.toString(), "id asc");
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return webDistributeTypeList;
	}

	
	
	/**
	 * 获取省份
	 * 
	 * @Title: getProvinceList
	 * @Description: TODO
	 * @return
	 * @throws Exception
	 * @return List<Map<String,Object>>
	 * @throws
	 */
	public List<Map<String, Object>> getProvinceList() throws Exception {
		if (provinceList != null) {
			return provinceList;
		}
		try {
			provinceList = regionService.queryRegionList(-1L, 1L, 1);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return provinceList;
	}

	public void setProvinceList(List<Map<String, Object>> provinceList) {
		this.provinceList = provinceList;
	}

	/**
	 * 添加网点分布初始化
	 * 
	 * @return
	 */
	public String addWebDistributeInit() {
		return SUCCESS;
	}

	public String addWebDistribute() throws Exception {
		long type = Convert.strToLong(paramMap.get("type"), -1);
		int provinceId = Convert.strToInt(paramMap.get("provinceId"), -1);
		int cityId = Convert.strToInt(paramMap.get("cityId"), -1);
		int areaId = Convert.strToInt(paramMap.get("areaId"), -1);
		String address = paramMap.get("address");
		String storeName = paramMap.get("storeName");
		String phone = paramMap.get("phone");
		String longitude = paramMap.get("longitude");
		String latitude = paramMap.get("latitude");
		int sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status = Convert.strToInt(paramMap.get("status"), -1);

		Long result = webDistributeService.addWebDistribute(type, provinceId,
				cityId, areaId, address, storeName, phone, longitude, latitude,
				sortIndex, status);
		if (result < 0) {
			this.addFieldError("errorMessage", "添加失败");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 修改网点分布初始化
	 * 
	 * @return
	 * @throws Exception
	 */
	public String updateWebDistributeInit() throws Exception {
		Long id = Convert.strToLong(request("id"), -1);
		paramMap = webDistributeService.queryWebDistributeById(id);
		return SUCCESS;
	}

	public String updateWebDistribute() throws Exception {
		Long id = Convert.strToLong(paramMap.get("id"), -1);
		long type = Convert.strToLong(paramMap.get("type"), -1);
		int provinceId = Convert.strToInt(paramMap.get("provinceId"), -1);
		int cityId = Convert.strToInt(paramMap.get("cityId"), -1);
		int areaId = Convert.strToInt(paramMap.get("areaId"), -1);
		String address = paramMap.get("address");
		String storeName = paramMap.get("storeName");
		String phone = paramMap.get("phone");
		String longitude = paramMap.get("longitude");
		String latitude = paramMap.get("latitude");
		int sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status = Convert.strToInt(paramMap.get("status"), -1);

		Long result = webDistributeService.updateWebDistribute(id, type,
				provinceId, cityId, areaId, address, storeName, phone,
				longitude, latitude, sortIndex, status);
		if (result < 0) {
			this.addFieldError("errorMessage", "修改失败");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 网点分布列表初始化
	 * 
	 * @return
	 */
	public String queryWebDistributeInit() {
		return SUCCESS;
	}

	public String queryWebDistribute() throws Exception {
		Long type = Convert.strToLong(request("type"), -1);
		String storeName = request("storeName");
		Long status = Convert.strToLong(request("status"), -1);
		pageBean.setPageSize(20);
		webDistributeService.queryWebDistributePage(type, storeName, status,
				pageBean);
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}

	
	
	
	
	
	/**
	 * 删除网点分布
	 * 
	 * @return
	 * @throws Exception
	 */
	public String deleteWebDistribute() throws Exception {
		String id = request("id");
		Long result = webDistributeService.deleteWebDistribute(id);
		if (result < 0) {
			this.addFieldError("errorMessage", "删除失败");
			return INPUT;
		}
		return SUCCESS;
	}

	public void setWebDistributeService(
			WebDistributeService webDistributeService) {
		this.webDistributeService = webDistributeService;
	}

	public void setWebDistributeTypeService(
			WebDistributeTypeService webDistributeTypeService) {
		this.webDistributeTypeService = webDistributeTypeService;
	}

	
}
