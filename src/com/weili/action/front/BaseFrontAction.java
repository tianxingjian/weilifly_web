package com.weili.action.front;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.shove.data.DataException;
import com.shove.web.action.BasePageAction;
import com.weili.constants.IConstants;
import com.weili.service.ConfigService;
import com.weili.service.InfoContentService;
import com.weili.service.InfoService;
import com.weili.service.SeoPageService;
import com.weili.service.ServiceTypeService;

public class BaseFrontAction extends BasePageAction {
	private ConfigService configService;
	private InfoContentService infoContentService;
	private InfoService infoService;
	private SeoPageService seoPageService;
	private ServiceTypeService serviceTypeService;  //服务类型

	private List<Map<String, Object>> infoList;
	private List<Map<String, Object>> list;
	private Map<String, String> paramOnLineOneMap;   //在线客服1
	private Map<String, String> paramOnLineTwoMap;  //在线客服2
	private Map<String, String> configWeiXinMap;   //微信图片
	private Map<String, String> configPhoneMap;
	private Map<String, String> seoMap;
	private List<Map<String, Object>> serviceTypeList; //服务类型
	private Map<String, String> helMap;
	private Map<String,String> imageMap;
	private Map<String,String>maMap;
	private Map<String,String>advertMap;
	private List<Map<String, Object>> copyrightList;  //版权声明
	
	public Map<String, String> getMaMap() throws SQLException, DataException {
		maMap = configService.queryContentMap(12);
		System.out.print(maMap.get("var")) ;
		return maMap;
	}

	public void setMaMap(Map<String, String> maMap) {
		this.maMap = maMap;
	}

	public void setSeoPageService(SeoPageService seoPageService) {
		this.seoPageService = seoPageService;
	}

	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}
	
	
	public Map<String, String> getImageMap() throws Exception {
		if(imageMap==null){
			try {
				imageMap = configService.queryContentMap(10);
			} catch (Exception e) {				
				e.printStackTrace();
				throw e;
			}
		}
		
		return imageMap;
	}

	public void setImageMap(Map<String, String> imageMap) {
		this.imageMap = imageMap;
	}

	
	
    /**
     * 查询浮动块
     * @return
     * @throws SQLException
     * @throws DataException
     */
	public Map<String, String> getHelMap() throws SQLException, DataException {
		//type = 9代表右侧浮动块
		Map<String,String>heMap = configService.queryContentMap(9);
		helMap  = new HashMap<String,String>() ;
		String name = heMap.get("name");
		String var = heMap.get("var");
		String title = heMap.get("title");
		String[] va = name.split("メ");
		String[] varAry = var.split("τ");
		String[] tit = title.split("τ");
		//网店
		String shopAll = va[0].toString();
		helMap.put("shopTitle", shopAll.split("τ")[0]);
		helMap.put("shopUrl", shopAll.split("τ")[1]);
		helMap.put("shopImg", varAry[0]);
		helMap.put("shopStatus", tit[0]);
		
		//客服
		String serviceAll = va[1].toString();
		helMap.put("serviceTitle", serviceAll.split("τ")[0]);
		helMap.put("serviceUrl", serviceAll.split("τ")[1]);
		helMap.put("serviceImg", varAry[1]);
		helMap.put("serviceStatus", tit[1]);
		return helMap;
	}

	public void setHelMap(Map<String, String> helMap) {
		this.helMap = helMap;
	}

	public ConfigService getConfigService() {
		return configService;
	}

	public List<Map<String, Object>> getInfoList() throws Exception {
		if (infoList == null) {
			StringBuffer condition = new StringBuffer();
			condition.append(" 1=1 AND status=1 and id<6");
			try {
				infoList = infoService.queryInfoAll("id,name", condition
						.toString(), "id");
				System.out.println(infoList);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return infoList;
	}

	public List<Map<String, Object>> getList() throws Exception {
		if (list == null) {
			StringBuffer condition = new StringBuffer();
			condition.append(" 1=1 AND status=1");
			try {
				list = infoContentService.queryInfoContentAll("*", condition
						.toString(), "sortIndex ASC");
			} catch (Exception e) {

				e.printStackTrace();
				throw e;
			}
		}
		return list;
	}
	
	
	
	
	/**
	 * 版权声明
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCopyrightList() throws Exception {
		if(copyrightList==null){
			StringBuffer condition=new StringBuffer();
			condition.append(" 1=1 and status=1 and infoId=6");
			try {
				copyrightList=infoContentService.queryInfoContentAll("*", condition.toString(), "sortIndex ASC");
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return copyrightList;
	}


	
	
	
	/**
	 * 服务类型
	 * @return
	 */
	public List<Map<String, Object>> getServiceTypeList() {
		if(serviceTypeList==null){
			StringBuffer condition = new StringBuffer();
			condition.append(" 1=1 AND status=1");
			try {
				serviceTypeList=serviceTypeService.queryServiceTypeAll("*", condition.toString(), "sortIndex ASC");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return serviceTypeList;
	}

	
	
	/***
	 * 在线客服1
	 * @return
	 * @throws Exception 
	 */
	public Map<String, String> getParamOnLineOneMap() throws Exception {
		if (paramOnLineOneMap == null) {
			try {
				paramOnLineOneMap = configService
						.queryConfigById(IConstants.CONFIG_ID_AFTERSALES_CONSULTING);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return paramOnLineOneMap;
	}

	/**
	 * 在线客服2
	 * @return
	 * @throws Exception 
	 */
	public Map<String, String> getParamOnLineTwoMap() throws Exception {
		if (paramOnLineTwoMap == null) {
			try {
				paramOnLineTwoMap = configService
						.queryConfigById(IConstants.CONFIG_ID_PRESALES_CONSULTING);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return paramOnLineTwoMap;
	}

	
	/**
	 * 微信图片
	 * @return
	 * @throws Exception 
	 */
	public Map<String, String> getConfigWeiXinMap() throws Exception {
		if (configWeiXinMap==null) {
			try {
				configWeiXinMap = configService
						.queryConfigById(IConstants.CONFIG_ID_WEIXIN);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return configWeiXinMap;
	}

	
	
	
	/**
	 * 电话号码
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getConfigPhoneMap() throws Exception {
		if (configPhoneMap == null) {
			try {
				configPhoneMap = configService
						.queryConfigById(IConstants.CONFIG_ID_PHONE);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		return configPhoneMap;
	}
	
	//主页弹出广告
	public Map<String, String> getAdvertMap() throws SQLException, DataException {
		//弹出广告
		advertMap = configService.queryContentMap(11);
				String name  = advertMap.get("name");
				String var = advertMap.get("var");
				String[] na = name.split("τ");
				String[] va = var.split("τ");
				
				advertMap.put("url", na[0]);
				advertMap.put("gUrl", na[1]);
				advertMap.put("img", va[0]);
				advertMap.put("gImg", va[1]);
		  
		return advertMap;
	}
	public void setAdvertMap(Map<String, String> advertMap) {
		this.advertMap = advertMap;
	}


	
	
	/**
	 * 查询页面seo
	 * @param pageUrl
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getSeoMap(String pageUrl) throws Exception {
		seoMap = new HashMap<String, String>();
		try {
			seoMap = seoPageService.querySeoUrl(pageUrl);
			if(seoMap == null||seoMap.isEmpty()){
				seoPageService.addSeoUrl(pageUrl);
				seoMap = seoPageService.querySeoUrl(pageUrl);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return seoMap;
	}

	public void setInfoContentService(InfoContentService infoContentService) {
		this.infoContentService = infoContentService;
	}

	public void setInfoService(InfoService infoService) {
		this.infoService = infoService;
	}

	public InfoContentService getInfoContentService() {
		return infoContentService;
	}

	public void setServiceTypeService(ServiceTypeService serviceTypeService) {
		this.serviceTypeService = serviceTypeService;
	}

	public InfoService getInfoService() {
		return infoService;
	}


	

}
