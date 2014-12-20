package com.weili.action.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.data.DataException;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.constants.IConstants;
import com.weili.service.ConfigService;
import com.weili.service.ProductService;

public class ConfigAction extends BasePageAction<Map<String, Object>> {

	private ConfigService configService; // 配置表

	/**
	 * 修改在线支持初始化
	 * 
	 * @return
	 * @throws DataException
	 * @throws SQLException
	 */
	public String updateConfigOnLineInit() throws SQLException, DataException {
		paramMap = configService.queryConfigById(IConstants.CONFIG_ID_ONLINE);
		return SUCCESS;
	}

	public String updateConfig() throws SQLException, IOException {
		Long id = Convert.strToLong(request("id"), -1);
		JSONObject obj = new JSONObject();
		String name = request("name");
		String var = request("var");
		int status = 1;
		Long result = configService
				.updateConfig(id, 1, name, var, null, status);
		if (result != null && result > 0) {
			obj.put("flag", "1");
			obj.put("msg", "修改成功");
			JSONUtils.printObject(obj);
			return null;
		} else {
			obj.put("flag", "2");
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}
	}

	/**
	 * 修改服务政策初始化
	 * 
	 * @return
	 * @throws DataException
	 * @throws SQLException
	 */
	public String updateServicePolicyInit() throws SQLException, DataException {
		paramMap = configService
				.queryConfigById(IConstants.CONFIG_ID_SERVICE_POLICY);
		return SUCCESS;
	}

	public String updateService() throws SQLException, IOException {
		Long id = Convert.strToLong(request("id"), -1);
		String name = request("name");
		String var = request("var");
		int status = 1;
		Long result = configService
				.updateConfig(id, 2, name, var, null, status);
		JSONObject obj = new JSONObject();
		if (result != null && result > 0) {
			obj.put("flag", "1");
			obj.put("msg", "修改成功");
			JSONUtils.printObject(obj);
			return null;
		} else {
			obj.put("flag", "2");
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}
	}

	/**
	 * 在线客服QQ初始化（售前）（在线客服2）
	 * 
	 * @return
	 * @throws DataException
	 * @throws SQLException
	 */
	public String updatePreSalesConsultingInit() throws SQLException,
			DataException {
		paramMap = configService
				.queryConfigById(IConstants.CONFIG_ID_PRESALES_CONSULTING);
		return SUCCESS;
	}

	public String updatePreSalesConsulting() throws SQLException, IOException {
		Long id = Convert.strToLong(request("id"), -1);
		JSONObject obj = new JSONObject();
		String name = request("name");
		String var = request("var");
		String title = request("title");
		int status = 1;
		int type = 3;
		Long result = configService.updateConfig(id, type, name, var, title,
				status);
		if (result != null && result > 0) {
			obj.put("flag", "1");
			obj.put("msg", "修改成功");
			JSONUtils.printObject(obj);
			return null;
		} else {
			obj.put("flag", "2");
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}
	}

	/**
	 * 在线客服QQ初始化(售后)(在线客服1)
	 * 
	 * @return
	 * @throws SQLException
	 * @throws DataException
	 */
	public String updateAfterSalesConsultingInit() throws SQLException,
			DataException {
		paramMap = configService
				.queryConfigById(IConstants.CONFIG_ID_AFTERSALES_CONSULTING);
		return SUCCESS;
	}

	public String updateAfterSalesConsulting() throws SQLException, IOException {
		Long id = Convert.strToLong(request("id"), -1);
		JSONObject obj = new JSONObject();
		String name = request("name");
		String var = request("var");
		String title = request("title");
		int status = 1;
		int type = 4;
		Long result = configService.updateConfig(id, type, name, var, title,
				status);
		if (result != null && result > 0) {
			obj.put("flag", "1");
			obj.put("msg", "修改成功");
			JSONUtils.printObject(obj);
			return null;
		} else {
			obj.put("flag", "2");
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}
	}

	/***************************************************************************
	 * 微信图片
	 * 
	 * @return
	 * @throws DataException
	 * @throws SQLException
	 */
	public String updateWeiXinInit() throws SQLException, DataException {
		paramMap = configService.queryConfigById(IConstants.CONFIG_ID_WEIXIN);
		return SUCCESS;
	}

	public String updateWeiXin() throws SQLException, IOException {
		Long id = Convert.strToLong(request("id"), -1);
		JSONObject obj = new JSONObject();
		String var = request("var");
		int status = 1;
		int type = 5;
		Long result = configService.updateConfig(id, type, null, var, null,
				status);
		if (result != null && result > 0) {
			obj.put("flag", "1");
			obj.put("msg", "修改成功");
			JSONUtils.printObject(obj);
			return null;
		} else {
			obj.put("flag", "2");
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}
	}

	/**
	 * 电话号码
	 * 
	 * @return
	 * @throws SQLException
	 * @throws DataException
	 */
	public String updatePhoneInit() throws SQLException, DataException {
		paramMap = configService.queryConfigById(IConstants.CONFIG_ID_PHONE);
		return SUCCESS;
	}

	public String updatePhone() throws SQLException, IOException {
		Long id = Convert.strToLong(request("id"), -1);
		JSONObject obj = new JSONObject();
		String name = request("name");
		String var = request("var");
		int status = 1;
		int type = 10;
		Long result = configService.updateConfig(id, type, name, var, null,
				status);
		if (result != null && result > 0) {
			obj.put("flag", "1");
			obj.put("msg", "修改成功");
			JSONUtils.printObject(obj);
			return null;
		} else {
			obj.put("flag", "2");
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}
	}

	/*
	 * public String updateSutraVideo() {
	 *  }
	 */

	/**
	 * 首页产品推荐
	 */
	public String queryProductConfig() throws SQLException, DataException {
		List<Map<String, Object>> list = configService
				.queryProductConfigByType(IConstants.CONFIG_TYPE_PRODUCT);

		request("list", list);

		return SUCCESS;
	}

	public String updateProductConfigInit() throws SQLException, DataException {
		Long id = Convert.strToLong(request("id"), -1);

		paramMap = configService.queryProductConfigById(id);
		return SUCCESS;
	}

	/**
	 * 修改首页产品推荐
	 * 
	 * @return
	 * @throws Exception
	 */
	public String updateProductConfig() throws Exception {
		JSONObject obj = new JSONObject();
		Long id = Convert.strToLong(request("id"), -1);
		if (id < 0) {
			obj.put("msg", "数据错误");
			JSONUtils.printObject(obj);
			return null;
		}
		Long productId = Convert.strToLong(request("productId"), -1);
		if (productId < 0) {
			obj.put("msg", "请点击关联产品");
			JSONUtils.printObject(obj);
			return null;
		}
		String image = request("image");
		if (StringUtils.isBlank(image)) {
			obj.put("msg", "请上传图片");
			JSONUtils.printObject(obj);
			return null;
		}
		
		String title=request("title");
		if(StringUtils.isBlank(title)){
			obj.put("msg", "请输入简介");
			JSONUtils.printObject(obj);
			return null;
		}
		long returnId = configService.updateConfig(id, null, productId + "",
				image, title, null);

		if (returnId < 0) {
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}

		obj.put("msg", "1");
		JSONUtils.printObject(obj);
		return null;
	}

	/**
	 * 修改首页经典视频
	 * 
	 * @return
	 * @throws SQLException
	 * @throws DataException
	 */
	public String updateConfigVideoInit() throws SQLException, DataException {
		paramMap = configService
				.queryConfigById(IConstants.CONFIG_ID_ONLINE_VIDEO);

		String titleImage = paramMap.get("name");
		String[] titleImages = titleImage.split("ɑ");

		paramMap.put("title", titleImages[0]);
		paramMap.put("image", titleImages[1]);

		return SUCCESS;
	}

	public String updateConfigVideo() throws SQLException, DataException,
			Exception {
		JSONObject obj = new JSONObject();
		Long id = Convert.strToLong(request("id"), -1);
		if (id < 0) {
			obj.put("msg", "数据错误");
			JSONUtils.printObject(obj);
			return null;
		}

		String title = request("title");// 标题
		if (StringUtils.isBlank(title)) {
			obj.put("msg", "标题不能为空");
			JSONUtils.printObject(obj);
			return null;
		}

		String path = request("path");// 视频路径
		if (StringUtils.isBlank(path)) {
			obj.put("msg", "请上传视频");
			JSONUtils.printObject(obj);
			return null;
		}

		String image = request("image");// 图片
		if (StringUtils.isBlank(image)) {
			obj.put("msg", "请上传图片");
			JSONUtils.printObject(obj);
			return null;
		}

		long returnId = configService.updateConfig(id, null, title + "ɑ"
				+ image, path, null, null);

		if (returnId < 0) {
			obj.put("msg", "修改失败");
			JSONUtils.printObject(obj);
			return null;
		}

		obj.put("msg", "1");
		JSONUtils.printObject(obj);
		return null;
	}

	/**
	 * 儿童类应用隐私协议
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryHotlineInit() throws Exception {
		// type = 8代表儿童类应用隐私协议
		paramMap = configService.queryContentMap(8);
		return SUCCESS;
	}

	
	/**
	 * 修改儿童类应用隐私协议
	 * 
	 * @return
	 * @throws Exception
	 */
	public String updateGabalnara() throws Exception {
		JSONObject obj = new JSONObject();
		Long id = Convert.strToLong(paramMap.get("id"), -1);
		String vars = paramMap.get("vars");
		String title = paramMap.get("title");
		if (StringUtils.isBlank(vars)) {
			obj.put("msg", "儿童类应用隐私协议不能为空");
			JSONUtils.printObject(obj);
			return null;
		}
		
		long returnId = configService.updateConfigInfoById(id, null, vars,title,null
				);
		if (returnId < 0) {
			obj.put("msg", "保存失败");
			JSONUtils.printObject(obj);
			return null;
		}
		obj.put("msg", "1");
		JSONUtils.printObject(obj);

		return null;
	}
	
	/**
	 * 右侧浮动块
	 * @param configService
	 * @throws DataException 
	 * @throws SQLException 
	 */
	public String queryShopInit() throws SQLException, DataException{
		//type = 9代表右侧浮动块
		paramMap = configService.queryContentMap(9);
		String name = paramMap.get("name");
		String var = paramMap.get("var");
		String title = paramMap.get("title");
		String[] va = name.split("メ");
		String[] varAry = var.split("τ");
		String[] tit = title.split("τ");
		//网店
		String shopAll = va[0].toString();
		paramMap.put("shopTitle", shopAll.split("τ")[0]);
		paramMap.put("shopUrl", shopAll.split("τ")[1]);
		paramMap.put("shopImg", varAry[0]);
		paramMap.put("shopStatus", tit[0]);
		//客服
		String serviceAll = va[1].toString();
		paramMap.put("serviceTitle", serviceAll.split("τ")[0]);
		paramMap.put("serviceUrl", serviceAll.split("τ")[1]);
		paramMap.put("serviceImg", varAry[1]);
		paramMap.put("serviceStatus", tit[1]);
		
		return SUCCESS;
	}
	/**
	 * 右侧浮动块
	 * @param configService
	 * @throws IOException 
	 * @throws DataException 
	 * @throws SQLException 
	 * @throws DataException 
	 * @throws SQLException 
	 */
	public String updateShop() throws IOException, SQLException, DataException{
		JSONObject obj = new JSONObject();
		Long id = Convert.strToLong(paramMap.get("id"), -1l);
		//网店
		String shopTitle = paramMap.get("shopTitle");
		String shopUrl = paramMap.get("shopUrl");
		String shopImg = paramMap.get("shopImg");
		String shopStatus = paramMap.get("shopStatus");
		
		//在线客服
		String serviceTitle = paramMap.get("serviceTitle");
		String serviceUrl = paramMap.get("serviceUrl");
		String serviceImg = paramMap.get("serviceImg");
		String serviceStatus = paramMap.get("serviceStatus");
		
		if(StringUtils.isBlank(shopTitle)||StringUtils.isBlank(shopUrl)||StringUtils.isBlank(shopImg)){
			obj.put("msg", "网店标题和网店地址及网店图片不能为空！");
			JSONUtils.printObject(obj);
			return null;
		}
		if(StringUtils.isBlank(serviceTitle)||StringUtils.isBlank(serviceUrl)||StringUtils.isBlank(serviceImg)){
			obj.put("msg", "客服标题和客服地址及客服图片不能为空！");
			JSONUtils.printObject(obj);
			return null;
		}
			String name =  shopTitle +"τ"+shopUrl+"メ"+ serviceTitle+"τ"+serviceUrl;
			String vars = shopImg+"τ"+serviceImg;
			String title = shopStatus+"τ"+serviceStatus;
			long returnId = configService.updateConfigInfoById(id, name, vars,title,null
					);

		if(returnId <0){
			obj.put("msg", "保存失败");
			JSONUtils.printObject(obj);
			return null;
		}
		obj.put("msg", "保存成功!");
		JSONUtils.printObject(obj);
		return null;
	}
	
	
	/**
	 * 资料下载搜索管理
	 * @param configService
	 * @throws DataException 
	 * @throws SQLException 
	 */
	public String querySearchInit() throws SQLException, DataException{
		paramMap = configService.queryContentMap(10);
		return SUCCESS;
	}
	
	public String updateSearch() throws Exception, DataException{
	JSONObject obj = new JSONObject();
	Long id = Convert.strToLong(paramMap.get("id"), -1l);
	String vars = paramMap.get("vars");
    long returnId = configService.updateConfigInfoById(id, null, vars,null,null
	);
    if(returnId <0){
    	obj.put("msg", "保存失败!");
    	JSONUtils.printObject(obj);
    	return null;
    }
    obj.put("msg", "保存成功!");
    JSONUtils.printObject(obj);
	return null;
		
	}
	
	
	/**
	 * 弹出广告图片管理
	 * @param configService
	 * @throws DataException 
	 * @throws SQLException 
	 */
	public String queryAdvertInit() throws SQLException, DataException{
		paramMap = configService.queryContentMap(11);
		String name  = paramMap.get("name");
		String var = paramMap.get("var");
		String[] na = name.split("τ");
		String[] va = var.split("τ");
		
		paramMap.put("url", na[0]);
		paramMap.put("gUrl", na[1]);
		paramMap.put("img", va[0]);
		paramMap.put("gImg", va[1]);
		return SUCCESS;
	}
	
	public String updateAdvert() throws Exception{
	JSONObject obj = new JSONObject();
	Long id = Convert.strToLong(paramMap.get("id"), -1l);
	String img = paramMap.get("img");
	String gImg = paramMap.get("gImg");
	String url = paramMap.get("url");
	String gUrl = paramMap.get("gUrl");
	Integer status = Convert.strToInt(paramMap.get("status"), -1);
	if(StringUtils.isBlank("img")){
		obj.put("msg","图片不能为空!");
		JSONUtils.printObject(obj);
		return null;
	}
	if(StringUtils.isBlank("gImg")){
		obj.put("msg","图片不能为空!");
		JSONUtils.printObject(obj);
		return null;
	}
	if(StringUtils.isBlank("url")){
		obj.put("msg","链接地址不能为空!");
		JSONUtils.printObject(obj);
		return null;
	}
	if(StringUtils.isBlank("gUrl")){
		obj.put("msg","链接地址不能为空!");
		JSONUtils.printObject(obj);
		return null;
	}
	
	String name = url+"τ"+gUrl;
	String vars = img+"τ"+gImg;
	long returnId = configService.updateConfigInfoById(id, name, vars,null,status);
	 if(returnId<0){
		 obj.put("msg", "修改失败!");
		 JSONUtils.printObject(obj);
		 return null;
	 }
	 obj.put("msg", "修改成功!");
	 JSONUtils.printObject(obj);
	 return null;
	}
	
	
	/**
	 * 	App专区二维码
	 * @param configService
	 */
	public String queryWeiMaInit() throws SQLException, DataException{
		paramMap = configService.queryContentMap(12);
		return SUCCESS;
	}
	
	public String updateWeiMa() throws Exception{
		JSONObject obj = new JSONObject();
		Long id = Convert.strToLong(paramMap.get("id"), -1l);
		String vars = paramMap.get("vars");
		
		if(StringUtils.isBlank("vars")){
			obj.put("msg", "图片不能为空!");
			JSONUtils.printObject(obj);
			return null;
		}
		long returnId = configService.updateConfigInfoById(id, null, vars,null,null);
		if(returnId<0){
			obj.put("msg", "修改失败!");
			JSONUtils.printObject(obj);
			return null;
		}
		obj.put("msg", "修改成功!");
		JSONUtils.printObject(obj);
		return null;
	}
	
	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}

}
