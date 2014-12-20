package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.ProductCategoryService;
import com.weili.service.DownloadService;

@SuppressWarnings("rawtypes")
public class DownloadAction extends BasePageAction {

	private static final long serialVersionUID = 1L;

	public static Log log = LogFactory.getLog(DownloadAction.class);
	
	private DownloadService downloadService;
	
	private List<Map<String,Object>> categoryList;

	/**
	 * 查询下载资料初始化
	 * @return
	 */
	public String queryDownloadInit(){
		return "success";
	}
	/**
	 * 查询下载资料详细化
	 * @return
	 */
	public String queryDownloadInfo() throws Exception{
		//---查询的条件开始---
		String name = request("name");//名称
		Long categoryId = Convert.strToLong(request("categoryId"), -1);//类型
		Integer status = Convert.strToInt(request("status"), -1);//状态
		String startDate = request("startDate");//添加时间开始于
		String endDate = request("endDate");//添加时间结束于
		
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
			condition.append(" and date_format(addTime,'%Y-%m-%d') >= '" + startDate + "'"); //格式化时间显示date_format(time,'%Y-%m-%d')
		}if(StringUtils.isNotBlank(endDate)){
			condition.append(" and date_format(addTime,'%Y-%m-%d') <= '"+ endDate +"'");
		}
		//---查询的条件结束---
		
		//待添加size、seoTitle、seoKeywords、seoDescription
				//	String size = request("size"); //size大小是自己输入的还是自动识别呢？自动的话怎么识别呢？	
				//	String seoTitle = request("seoTitle");	
				//	String seoKeywords = request("seoKeywords");	
				//	String seoDescription = request("seoDescription");
		
		//---查询sql语句中的结果\排序条件\表名或视图名
		String fieldList = "*"; //* 输出表或视图中所有列数据
		String order = "order by addTime desc"; //按时间最近顺序排序
		String table = "v_t_download"; //要查询的表名或视图名
		
		downloadService.queryDownloadPage(pageBean, fieldList, condition, order, table);
		return "success";
	}
	
	/**
	 * 添加下载资料初始化
	 * @return
	 */
	public String addDownloadInit(){
		return SUCCESS;
	}
	/**
	 * 添加下载资料详细化
	 * @return
	 */
	public String addDownload() throws Exception{
		//---添加参数取出开始---
		String name = request("name");
		Long categoryId = Convert.strToLong(request("categoryId"), -1);//下拉选择(通过查询得到)
		Integer status = Convert.strToInt(request("status"), -1);//复选框选择是与否
		Integer isRecommend = Convert.strToInt(request("isRecommend"), -1);//复选框选择是与否
		String path = request("path");//浏览上传得到的地址
		String image = request("image");
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);//排序
		//待添加size、seoTitle、seoKeywords、seoDescription
		//	String size = request("size"); //size大小是自己输入的还是自动识别呢？自动的话怎么识别呢？	
		//	String seoTitle = request("seoTitle");	
		//	String seoKeywords = request("seoKeywords");	
		//	String seoDescription = request("seoDescription");
		//---添加参数取出结束---
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(downloadService.addDownload(name, image, path, categoryId, sortIndex,status,isRecommend, null, null, null));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	/**
	 * 修改下载资料初始化
	 * @return
	 */
	public String updateDownloadInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = downloadService.queryCoursewareById(id);
		return "success";
	}
	/**
	 * 修改下载资料详细化
	 * @return
	 */
	public String updateDownload() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String name = request("name");
		Long categoryId = Convert.strToLong(request("categoryId"), -1);
		Integer status = Convert.strToInt(request("status"), -1);
		Integer sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String path = request("path");
		String image = request("image");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(downloadService.updateDownload(id , name , image, path, categoryId, sortIndex, status, null, null, null));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	/**
	 * 删除下载资料
	 * @return
	 */
	public String deleteDownload() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = downloadService.deleteDownload(ids);
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
	
	
//	-------------set方法---------------
	public void setDownloadService(DownloadService downloadService) {
		this.downloadService = downloadService;
	}

	public void setCategoryList(List<Map<String, Object>> categoryList) {
		this.categoryList = categoryList;
	}
	/**
	 * 获取下载资料分类列表
	 * @return
	 */
	public List<Map<String, Object>> getCategoryList() throws Exception {
		if(categoryList == null){
			categoryList = downloadService.queryDownloadCategoryAll("*", "1=1");
		}
		System.out.println("-------"+categoryList);
		return categoryList;
	}

}
