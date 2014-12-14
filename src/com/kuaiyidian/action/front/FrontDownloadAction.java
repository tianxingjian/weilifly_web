package com.kuaiyidian.action.front;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.kuaiyidian.constants.IConstants;
import com.kuaiyidian.service.AdvertisementService;
import com.kuaiyidian.service.AttributeService;
import com.kuaiyidian.service.ConfigService;
import com.kuaiyidian.service.DownloadHelpService;
import com.kuaiyidian.service.MaterialsService;
import com.kuaiyidian.service.ProductCategoryService;
import com.kuaiyidian.service.ProductService;
import com.kuaiyidian.service.UpdateProgramService;
import com.shove.Convert;
import com.shove.data.DataException;
import com.shove.util.StringCommon;
import com.shove.web.util.FileUtils;


public class FrontDownloadAction extends BaseFrontAction {

	private ProductCategoryService productCategoryService;
	private ProductService productService;
	private UpdateProgramService updateProgramService;
	private DownloadHelpService downloadHelpService;
	private AdvertisementService advertisementService;
	private AttributeService attributeService;;
	private MaterialsService materialsService;


	

	/**
	 * 下载综合
	 * @return
	 * @throws Exception
	 */
	public String downloadIndex() throws Exception{
		queryProductCategory();//产品系列
		queryDownloadHelp();//下载帮助
		List<Map<String,Object>> productList = productService.queryProductAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " sortIndex asc");//产品型号
		
		queryUpdateProgram();//升级程序，最新的前五个
		
		queryAdvertise();//广告片
		
		request("productList",productList);
		Map<String,String> seoMap = getSeoMap("downloadIndex.do");//seo
		request("seoMap",seoMap);
		return SUCCESS;
	}
	
	/**
	 * 升级程序
	 * @return
	 * @throws Exception 
	 */
	public String updateProgramIndex() throws Exception{
		
		List<Map<String,Object>> categoryList = productCategoryService.queryProductCategoryAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " sortIndex asc");//产品系列
	
		Long categoryId = -1L;
		if(categoryList != null&&categoryList.size() > 0){
			categoryId = Convert.strToLong(request("a"), (Long)categoryList.get(0).get("id"));
		}
		int pageNum = Convert.strToInt(request("curPage"), 1);
		pageBean.setPageNum(pageNum);
		pageBean.setPageSize(9);
		
		updateProgramService.queryUpdateProgram(pageBean, IConstants.STATUS_ON,categoryId);//升级程序
		
		queryDownloadHelp();//下载帮助
		queryAdvertise();//广告片
		
		Map<String,String> seoMap = getSeoMap("updateProgramIndex.do");//seo
		request("seoMap",seoMap);
		
		request("categoryId",categoryId);
		request("categoryList",categoryList);
		return SUCCESS;
	}
	
	/**
	 * 下载升级程序
	 * @return
	 * @throws IOException 
	 */
	public String downloadProgram() throws IOException{
		String filePath = request("filePath");
		if (StringUtils.isNotBlank(filePath)) {
			if(filePath.startsWith("upload")){
				FileUtils.downloadFile(ServletActionContext.getServletContext().getRealPath("/")+filePath, response());
				return null;
			}else{
				response().sendRedirect(filePath);
			}
			
		}
		
		return null;
	}
	
	/**
	 * 广告片
	 * @return
	 * @throws Exception
	 */
	public String advertiseIndex() throws Exception{
		queryDownloadHelp();//下载帮助
		
		int pageNum = Convert.strToInt(request("curPage"), 1);
		pageBean.setPageNum(pageNum);
		pageBean.setPageSize(12);
		
		advertisementService.queryAdvertisementer(pageBean, IConstants.STATUS_ON);
		
		Map<String,String> seoMap = getSeoMap("advertiseIndex.do");//seo
		request("seoMap",seoMap);
		
		return SUCCESS;
	}
	
	/**
	 * 资料下载
	 * @return
	 * @throws Exception
	 */
	public String materialsIndex() throws Exception{
		
		Long id = Convert.strToLong(request("id"), -1);//产品ID
		paramMap = productService.queryProductCategoryById(id);
		List<Map<String,Object>> attributeList = attributeService.queryAttributes(IConstants.STATUS_ON);//属性
		queryDownloadHelp();//下载帮助
		queryAdvertise();//广告片
		String attributeIds = materialsService.queryProductAttributes(id+"");//模块属性ID
		Map<String,String> seoMap = getSeoMap("materialsIndex.do");//seo
		request("seoMap",seoMap);
		request("attributeList",attributeList);
		request("attributeIds",attributeIds);
		return SUCCESS;
	}
	
	public String materialsList() throws Exception{
		
		Long productId = Convert.strToLong(request("id"), -1);//产品ID
		String keywords = request("keywords");
		String attributeIds = request("attributeIds");
		String pattributeIds = request("pattributeIds");
		
		long count = materialsService.queryMaterials(pageBean, productId, keywords, attributeIds,pattributeIds);
		
		request("count",count);
		
		paramMap = productService.queryProductCategoryById(productId);
		
		return SUCCESS;
	}
	
	/**
	 * 资料下载
	 * @return
	 * @throws Exception 
	 */
	public String downloadMaterials() throws Exception{
		String ids = request("id");
		int i = StringCommon.checkIds(ids);
		if(i < 0){
			request("msg","数据错误！");
			return "msg";
		}
		String filePath = materialsService.createMaterialsBtachFile(ids);
		if (StringUtils.isNotBlank(filePath)) {
			if(!filePath.startsWith("/zip")){
//				response().setCharacterEncoding("UTF-8");
//				response().sendRedirect(URLEncoder.encode(filePath,"UTF-8"));
				response().sendRedirect(filePath);
			}else{
				FileUtils.downloadFile(filePath, response());
				return null;
			}
			
		}
		
		return null;
	}
	
	/**
	 * ios下载
	 * @return
	 * @throws Exception 
	 */
	public String downloadIosMaterials() throws Exception{
		String ids = request("id");
		int i = StringCommon.checkIds(ids);
		if(i < 0){
			request("msg","数据错误！");
			return "msg";
		}
		String filePath = materialsService.createMaterialsIosBtachFile(ids);
		if (StringUtils.isNotBlank(filePath)) {
			if(!filePath.startsWith("/zip")){
//				response().setCharacterEncoding("UTF-8");
//				response().sendRedirect(URLEncoder.encode(filePath,"UTF-8"));
				response().sendRedirect(filePath);
			}else{
				FileUtils.downloadFile(filePath, response());
				return null;
			}
			
		}
		
		return null;
	}
	/**
	 * android下载
	 * @return
	 * @throws Exception 
	 */
	public String downloadAndroidMaterials() throws Exception{
		String ids = request("id");
		int i = StringCommon.checkIds(ids);
		if(i < 0){
			request("msg","数据错误！");
			return "msg";
		}
		String filePath = materialsService.createMaterialsAndroidBtachFile(ids);
		if (StringUtils.isNotBlank(filePath)) {
			if(!filePath.startsWith("/zip")){
//				response().setCharacterEncoding("UTF-8");
//				response().sendRedirect(URLEncoder.encode(filePath,"UTF-8"));
				response().sendRedirect(filePath);
			}else{
				FileUtils.downloadFile(filePath, response());
				return null;
			}
			
		}
		
		return null;
	}
	
	private void queryProductCategory() throws Exception{
		List<Map<String,Object>> categoryList = productCategoryService.queryProductCategoryAll("*", "1=1 and `isShow` = "+IConstants.STATUS_ON, " sortIndex asc");//产品系列
		request("categoryList",categoryList);
	}
	
	private void queryDownloadHelp() throws Exception{
		
		List<Map<String,Object>> downloadHelpList = downloadHelpService.queryDownloadHelpFour(IConstants.STATUS_ON);//下载帮助
		request("downloadHelpList",downloadHelpList);
	}
	
	private void queryUpdateProgram() throws Exception{
		pageBean.setPageSize(9);
		updateProgramService.queryUpdateProgram(pageBean, IConstants.STATUS_ON,null);
		
		List<Map<String,Object>> updateProgramList = pageBean.getPage();
		
		request("updateProgramList",updateProgramList);
	}
	
	private void queryAdvertise() throws Exception{
		List<Map<String,Object>> advertiseList = advertisementService.queryAdvertisementerList();
		request("advertiseList",advertiseList);
	}
	
	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public void setUpdateProgramService(UpdateProgramService updateProgramService) {
		this.updateProgramService = updateProgramService;
	}

	public void setDownloadHelpService(DownloadHelpService downloadHelpService) {
		this.downloadHelpService = downloadHelpService;
	}

	public void setAdvertisementService(AdvertisementService advertisementService) {
		this.advertisementService = advertisementService;
	}

	public void setAttributeService(AttributeService attributeService) {
		this.attributeService = attributeService;
	}

	public void setMaterialsService(MaterialsService materialsService) {
		this.materialsService = materialsService;
	}
	
}
