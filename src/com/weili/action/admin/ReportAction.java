package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.ProductCategoryService;
import com.weili.service.ReportService;

public class ReportAction extends  BasePageAction<Map<String, Object>> {
	private ReportService reportService;
	
	private ProductCategoryService productCategoryService;
	private List<Map<String, Object>> reportCategoryList;
	
	
	/**
	 * 类型
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getReportCategoryList() throws Exception {
		if(reportCategoryList!=null){
			return reportCategoryList;
		}
		try {
			reportCategoryList = productCategoryService.queryProductCategoryAll("*", "1=1", " sortIndex asc");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return reportCategoryList;
	}

	
	

	public void setReportCategoryList(List<Map<String, Object>> reportCategoryList) {
		this.reportCategoryList = reportCategoryList;
	}
	
	


	
	
	/**
	 * 添加质检报告初始化
	 * @return
	 */
	public String addReportInit() {
		return SUCCESS;
	}
	
	
	public String addReport() throws Exception {
		int categoryId=Convert.strToInt(paramMap.get("categoryId"), -1);
		String title=paramMap.get("title");
		String author=paramMap.get("author");
		String image=paramMap.get("image");
		String path=paramMap.get("path");
		int status=Convert.strToInt(paramMap.get("status"), -1);
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		String seoTitle=paramMap.get("seoTitle");
		String seoKeywords=paramMap.get("seoKeywords");
		String seoDescription=paramMap.get("seoDescription");
		
		Long result=reportService.addReport(categoryId, title,author, image, path, status, sortIndex, seoTitle, seoKeywords, seoDescription);
		if(result<0){
			this.addFieldError("errorMessage", "添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 修改质检报告
	 * @return
	 * @throws Exception
	 */
	public  String updateReportInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=reportService.queryReportById(id);
		return SUCCESS;
	}
	
	
	public String updateReport() throws Exception {
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		int categoryId=Convert.strToInt(paramMap.get("categoryId"), -1);
		String title=paramMap.get("title");
		String author=paramMap.get("author");
		String image=paramMap.get("image");
		String path=paramMap.get("path");
		int status=Convert.strToInt(paramMap.get("status"), -1);
		int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
		String seoTitle=paramMap.get("seoTitle");
		String seoKeywords=paramMap.get("seoKeywords");
		String seoDescription=paramMap.get("seoDescription");
		
		
		JSONObject obj = new JSONObject();

		obj.putAll(reportService.updateReport(id, categoryId, title, author, image, path, status, sortIndex, seoTitle, seoKeywords, seoDescription));

		JSONUtils.printObject(obj);
		
		return null;
		
	}
	
	
	/**
	 * 质检报告列表初始化
	 * @return
	 */
	public  String queryReportInit() {
		return SUCCESS;
	}
	
	
	public  String queryReport() throws Exception {
		String title=request("title");
		int categoryId=Convert.strToInt(request("categoryId"), -1);
		int status=Convert.strToInt(request("status"), -1);
		StringBuffer sbCondition=new StringBuffer();
		if(StringUtils.isNotBlank(title)){
			sbCondition.append(" 1=1 AND title LIKE CONCAT('%','"+title+"','%')");
		}
		if(categoryId>0){
			sbCondition.append(" AND categoryId="+categoryId);
		}
		if(status>0){
			sbCondition.append(" AND status="+status);
		}		
		reportService.queryReportPage(pageBean, "*", sbCondition.toString(), " ORDER BY addTime DESC", "v_t_report_category");
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}
	
	
	
	
	public String deleteReport() throws Exception {
		String ids=request("id");
		Long result=reportService.deleteReport(ids);
		if(result<0){
			this.addFieldError("errorMessage","删除失败");
			return INPUT;
		}
		return SUCCESS;
	}


	public void setReportService(ReportService reportService) {
		this.reportService = reportService;
	}


	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}




	
}
