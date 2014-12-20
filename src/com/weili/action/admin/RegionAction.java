package com.weili.action.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;

import com.shove.Convert;
import com.shove.data.DataException;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.RegionService;

/**
 * 省市区管理
 * @author Administrator
 *
 */
public class RegionAction extends BasePageAction{
	
	private static final long serialVersionUID = 1L;
	
	public static Log log =LogFactory.getLog(RegionAction.class);
	
	private RegionService regionService;
	
	private List<Map<String,Object>> provinceList;
	
	
	/**
	 * 省市联动
	 * @return
	 * @throws Exception 
	 */
	public String ajaxqueryRegion() throws Exception{
		Long parentId = Convert.strToLong(request("parentId"), -1);  //地区父编号
		Integer regionType = Convert.strToInt(request("regionType"), -1);  //地区类型
		List<Map<String, Object>> list;
		try {
			list = regionService.queryRegionList(-1L, parentId, regionType);
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		} catch (DataException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			throw e;
		}
		String jsonStr = JSONArray.toJSONString(list);
		JSONUtils.printStr(jsonStr);
		return null;
	}

	


	public void setRegionService(RegionService regionService) {
		this.regionService = regionService;
	}

	/**
	 * 获取省份
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
			provinceList = regionService.queryRegionList(-1L,1L, 1);
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		return provinceList;
	}

}
