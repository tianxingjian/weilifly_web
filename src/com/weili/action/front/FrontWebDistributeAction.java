package com.weili.action.front;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.util.StrCharSetTool;
import com.sun.xml.internal.bind.v2.model.core.ID;
import com.weili.entity.Icon;
import com.weili.service.RegionService;
import com.weili.service.WebDistributeService;
import com.weili.service.WebDistributeTypeService;

public class FrontWebDistributeAction extends BaseFrontAction {

	private WebDistributeService webDistributeService; // 网点分布
	private RegionService regionService;
	private WebDistributeTypeService webDistributeTypeService; // 网点分布类型

	private List<Map<String, Object>> provinceList;

	private List<Map<String, Object>> webDistributeTypeList;

	public void setRegionService(RegionService regionService) {
		this.regionService = regionService;
	}

	/**
	 * 获得网点分布类型
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getWebDistributeTypeList()
			throws Exception {
		if (webDistributeTypeList == null) {
			StringBuffer condition = new StringBuffer();
			try {
				webDistributeTypeList = webDistributeTypeService
						.queryWebDistributeTypeAll("*", condition.toString(),
								"sortIndex asc");
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
	 * 网点分布
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryWebDistributeListInit() throws Exception {
		String add = FrontWebDistributeAction.queryExpressInfo();
		String provinceName = "";
		String addString = StringCommon.escapeBlankChar(add);
		if (StringUtils.isBlank(addString) || addString.indexOf("省") == -1) {
			provinceName = new String("广东");
		} else {
			provinceName = addString.substring(0, addString.indexOf("省"));
		}
		String cityName = "";
		if (StringUtils.isBlank(addString) || addString.indexOf("省") == -1
				|| addString.indexOf("市") == -1) {
			cityName = new String("深圳");
		} else {
			cityName = addString.substring(addString.indexOf("省") + 1,
					addString.indexOf("市"));
		}
		paramMap = regionService.queryAddId(provinceName);
		long provinceId = 0l;
		Long cityId = 0l;
		if (paramMap == null) {
			provinceId = 6;
		} else {
			provinceId = Convert.strToLong(paramMap.get("id"), -1);
		}
		request().setAttribute("provinceId", provinceId);
		paramMap = regionService.queryAddId(cityName);
		if (paramMap == null) {
			cityId = 77l;
		} else {
			cityId = Convert.strToLong(paramMap.get("id"), -1);
		}
		request("cityId", cityId);
		Map<String, String> seoMap = getSeoMap("queryWebDistributeListInit.do");// seo
		request("seoMap", seoMap);
		return SUCCESS;
	}

	/**
	 * 显示所有信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryWebDistributeAll() throws Exception {
		Long type = Convert.strToLong(request("type"), -1);
		Long provinceId = Convert.strToLong(request("provinceId"), -1);
		Long cityId = Convert.strToLong(request("cityId"), -1);
		Long areaId = Convert.strToLong(request("areaId"), -1);
		StringBuffer condition = new StringBuffer();
		condition.append(" 1=1 and status=1");
		if (type > 0) {
			condition.append(" and type=" + type);
		}
		if (provinceId > 0) {
			condition.append(" AND provinceId=" + provinceId);
		}
		if (cityId > 0) {
			condition.append(" AND cityId=" + cityId);
		}
		if (areaId > 0) {
			condition.append(" AND areaId=" + areaId);
		}
		List<Map<String, Object>> rwbList = webDistributeService
				.queryWebDistributeAll2("*", condition.toString(), "");
		List<Map<String, Object>> wbList = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < rwbList.size(); i++) {
			Map<String, Object> map = rwbList.get(i);
			map.put("content", "地址：" + rwbList.get(i).get("provinceName")
					+ rwbList.get(i).get("cityName")
					+ rwbList.get(i).get("areaName")
					+ rwbList.get(i).get("address"));
			map.put("icon", new Icon(39, 25, 2, 0, 9, 12));
			map.put("point", rwbList.get(i).get("longitude") + "|"
					+ rwbList.get(i).get("latitude"));
			map.put("title", rwbList.get(i).get("storeName"));
			map.put("phone", "电话：" + rwbList.get(i).get("phone"));
			map.put("isOpen", 0);
			wbList.add(map);
		}
		JSONArray wbAryArray = JSONArray.fromObject(wbList);
		request("strInfo", wbAryArray.toString());

		Map<String, String> provinceNameMap = new HashMap<String, String>(); // 省份名称
		Map<String, String> cityNameMap = new HashMap<String, String>(); // 城市名称
		Map<String, String> areaNameMap = new HashMap<String, String>(); // 区域名称
		String addressName = "";
		int joinCenter = 0;
		if (provinceId > 0) {
			provinceNameMap = regionService.queryRegionById(provinceId);
			if (provinceNameMap.get("regionName") != null) {
				addressName = provinceNameMap.get("regionName").toString();
				joinCenter = 8;
			}
		}
		if (cityId > 0) {
			cityNameMap = regionService.queryRegionById(cityId);
			if (cityNameMap.get("regionName") != null) {
				if(cityNameMap.get("regionName").toString().equals(addressName)){
					addressName=cityNameMap.get("regionName").toString();
				}else {
					addressName += cityNameMap.get("regionName").toString();
				}
				joinCenter = 12;
			}
		}
		if (areaId > 0) {
			areaNameMap = regionService.queryRegionById(areaId);
			if (areaNameMap.get("regionName") != null) {
				addressName += areaNameMap.get("regionName").toString();
				joinCenter = 14;
			}
		}
		JSONArray wbAddr = new JSONArray();
		wbAddr.add(0, addressName);
		request("addressName", wbAddr.toString());
		JSONArray wbJoinCenter = new JSONArray();
		wbJoinCenter.add(0, joinCenter);
		request("joinCenter", wbJoinCenter.toString());
		return SUCCESS;
	}

	/**
	 * 列表
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryWebDistributeList() throws Exception {
		int type = Convert.strToInt(request("type"), -1);
		int provinceId = Convert.strToInt(request("provinceId"), -1);
		int cityId = Convert.strToInt(request("cityId"), -1);
		int areaId = Convert.strToInt(request("areaId"), -1);
		String storeName = request("keyword");
		pageBean.setPageSize(10);
		webDistributeService.queryWebDPage(type, provinceId, cityId, areaId,
				storeName, pageBean);
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}

	public void setWebDistributeService(
			WebDistributeService webDistributeService) {
		this.webDistributeService = webDistributeService;
	}

	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	private static String queryExpressInfo() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		FrontWebDistributeAction f = new FrontWebDistributeAction();
		String express_key = f.getIpAddr(request);
		String express_url = "http://whois.pconline.com.cn/ip.jsp";
		String request_url = express_url + "?" + "ip=" + "112.95.172.42"
				+ "&level=3";
		String get_content = "";
		try {
			URL url = new URL(request_url);
			URLConnection con = url.openConnection();
			con.setAllowUserInteraction(false);
			InputStream urlStream = url.openStream();
			String type = URLConnection.guessContentTypeFromStream(urlStream);
			String charSet = null;
			if (type == null)
				type = con.getContentType();
			if (type == null || type.trim().length() == 0
					|| type.trim().indexOf("text/html") < 0)
				return null;

			if (type.indexOf("charset=") > 0)
				charSet = type.substring(type.indexOf("charset=") + 8);

			byte b[] = new byte[10000];
			int numRead = urlStream.read(b);
			String content = new String(b, 0, numRead);
			while (numRead != -1) {
				numRead = urlStream.read(b);
				if (numRead != -1) {
					// String newContent = new String(b, 0, numRead);
					String newContent = new String(b, 0, numRead, charSet);
					content += newContent;
				}
			}
			get_content = content;
			urlStream.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		get_content = StrCharSetTool.toUTF_8(get_content);
		return get_content;
	}

	public void setWebDistributeTypeService(
			WebDistributeTypeService webDistributeTypeService) {
		this.webDistributeTypeService = webDistributeTypeService;
	}

}
