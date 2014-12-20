package com.weili.action.usercenter;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.shove.Convert;
import com.shove.util.FindWebPath;
import com.weili.action.front.BaseFrontAction;
import com.weili.constants.IConstants;
import com.weili.service.DesignCategoryService;
import com.weili.service.ProductCategoryService;
import com.weili.service.ReportService;

public class FrontReportAction extends BaseFrontAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static Log log = LogFactory.getLog(FrontReportAction.class);
	private ReportService reportService;
	private String fileName;// 用户下载的文件名
	private String targetFile;// 实际路径文件
	protected InputStream inputStream;
	private String fileRealName;
	private DesignCategoryService designCategoryService;
	private ProductCategoryService productCategoryService;
	private List<Map<String, Object>> queryReportssList;
	private List<Map<String, Object>> queryDesignCategoryList;
	private List<Map<String, Object>> reportCategoryList;
	private List<Map<String, Object>> queryImageList;
	private String caId;

	public List<Map<String, Object>> getQueryImageList() {
		return queryImageList;
	}

	public void setQueryImageList(List<Map<String, Object>> queryImageList) {
		this.queryImageList = queryImageList;
	}

	/**
	 * 类型
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getReportCategoryList() throws Exception {
		if (reportCategoryList != null) {
			return reportCategoryList;
		}
		try {
			reportCategoryList = productCategoryService
					.queryProductCategoryAll("*", "1=1", " sortIndex asc");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return reportCategoryList;
	}

	public void setReportCategoryList(
			List<Map<String, Object>> reportCategoryList) {
		this.reportCategoryList = reportCategoryList;
	}

	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}

	public String getCaId() {
		return caId;
	}

	public void setCaId(String caId) {
		this.caId = caId;
	}

	public List<Map<String, Object>> getQueryReportssList() throws Exception {
		return queryReportssList;
	}

	public void setQueryReportssList(List<Map<String, Object>> queryReportssList) {
		this.queryReportssList = queryReportssList;
	}

	public void setReportService(ReportService reportService) {
		this.reportService = reportService;
	}

	/**
	 * 查询质检报告
	 * 
	 * @throws Exception
	 */
	public String queryFrontReportInit() throws Exception {
		// 查询所有的标题
		Integer status = 1;
		caId = request("caId");
		queryDesignCategoryList = designCategoryService
				.queryDesignCategoryList(status);
		// queryReportssList=reportService.queryReportssList(status);
		Map<String, String> seoMap = getSeoMap("queryFrontReportInit.do");
		request("seoMap", seoMap);
		int pageNum = Convert.strToInt(request("curPage"), 1);
		request("pageNum", pageNum);
		return SUCCESS;
	}

	public String queryFrontReportInfo() throws Exception {
		pageBean.setPageSize(16);
		String title = paramMap.get("title");
		String author = paramMap.get("author");
		Integer status = Convert.strToInt(paramMap.get("status"), -1);
		Integer item_type = Convert.strToInt(paramMap.get("item_type"), -1);
		Long categoryId = Convert.strToLong(paramMap.get("categoryId"), -1);
		request("caId", categoryId);

		try {
			// 质检报告
			if (item_type != null && item_type == 1) {
				if (categoryId == null || categoryId == -1) {
					List<Map<String, Object>> caList = null;
					caList = productCategoryService.queryProductCategoryAll(
							"*", "1=1", " sortIndex asc");
					categoryId = (Long) caList.get(0).get("id");
					request("caId", categoryId);
				}
				reportService.queryFrontReport(pageBean, title, author, status,
						categoryId);
				return "report";
			}
			// 素材
			if (item_type != null && item_type == 2) {
				pageBean.setPageSize(5);
				designCategoryService
						.queryFrontDesignPage(pageBean, categoryId);
				queryDesignCategoryList = designCategoryService
						.queryDesignCategoryList(IConstants.STATUS_ON);
				queryImageList = designCategoryService.queryImageList(IConstants.STATUS_ON);
				List<Map<String, Object>> cList = new ArrayList<Map<String, Object>>();
				List<Map<String, Object>> commList = new ArrayList<Map<String, Object>>();
				commList = pageBean.getPage();
				if (commList != null && commList.size() > 0) {
					for (Map<String, Object> map : commList) {
						Map<String, Object> comMap = new HashMap<String, Object>();
						comMap = map;
						String imgs = map.get("t_imgUrl") + "";
						List<String> imgList = new ArrayList<String>();
						if (imgs != "" && imgs != null) {
							String[] imgAry = imgs.split(",");
							Collections.addAll(imgList, imgAry);
						}
						comMap.put("imgList", imgList);
						cList.add(comMap);
					}
				}
				pageBean.setPage(cList);
				return "design";
			}
			// 查询详情
			if (item_type != null && item_type == 3) {
				Long id = Convert.strToLong(paramMap.get("id"), -1l);
				paramMap = reportService.queryReportDetailId(id);
				return "detail";
			}

		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		return SUCCESS;

	}

	/**
	 * 质检报告详情
	 * 
	 * @throws Exception
	 */
	public String queryFrontReportDetail() throws Exception {
		// 查询详情
		Long id = Convert.strToLong(request("id"), -1l);
		paramMap = reportService.queryReportDetailId(id);
		return SUCCESS;
	}

	/**
	 * 下载文件质检报告
	 * 
	 * @author <a
	 * 
	 *         href="mailto:xuzhangchu@eims.com.cn">xzc</a>
	 * @class com.fs.action.front
	 * @since 2014-5-9
	 * @edit 2014-5-9
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public String downloadFiles() throws Exception {
		Long id = Convert.strToLong(request("id"), -1L);
		Map<String, String> map = new HashMap<String, String>();
		map = reportService.queryReportsById(id);
		String path = ServletActionContext.getServletContext().getRealPath("/");//FindWebPath.getWebRootPath();
		path = path.substring(0, path.length()-1);
		if (map != null) {
			String file_path = map.get("path");
			//String file_path = request("file_path");
			if (StringUtils.isNotBlank(file_path)) {
				if(file_path.startsWith("upload")){
			  fileRealName = map.get("title")
					+ file_path.substring(file_path.lastIndexOf("."), file_path
							.length());
			targetFile = path + File.separator + file_path;
			downloadFile(targetFile, response());
			return null;
		}else{
			response().sendRedirect(file_path);
			}
		}
		}
		return null;
	}
	
	/**
	 * 文件下载
	 * @param path
	 */
	public static void downloadFile(String path,HttpServletResponse response){
		try {
			// path是指欲下载的文件的路径。
			File file = new File(path);
			// 取得文件名。
			String filename = file.getName();
			// 取得文件的后缀名。

			// 以流的形式下载文件。
			InputStream fis = new BufferedInputStream(new FileInputStream(path));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer);
			fis.close();
			// 清空response
			response.reset();
			// 设置response的Header
			response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
			response.addHeader("Content-Length", "" + file.length());
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");
			toClient.write(buffer);
			toClient.flush();
			toClient.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
	

	

	public InputStream getInputStream() {
		String filePath = targetFile;
		File file = new File(filePath);
		InputStream fis = null;
		try {
			fis = new FileInputStream(file);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			LOG.info("未找到文件名为[" + filePath + "]的文件");
		}
		return fis;
	}

	/**
	 * @param inputStream
	 *            the inputStream to set
	 */
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	/**
	 * @return the fileName
	 */
	public String getFileName() {
		String downFile = "";
		try {
			String agent = request().getHeader("USER-AGENT");
			if (null != agent && -1 != agent.indexOf("MSIE")) {
				downFile = URLEncoder.encode(fileRealName, "utf-8");
			} else {
				downFile = new String(fileRealName.getBytes(), "ISO8859-1");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return downFile;
	}

	/**
	 * @param fileName
	 *            the fileName to set
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * @return the fileRealName
	 */
	public String getFileRealName() {
		return fileRealName;
	}

	/**
	 * @param fileRealName
	 *            the fileRealName to set
	 */
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}

	public void setDesignCategoryService(
			DesignCategoryService designCategoryService) {
		this.designCategoryService = designCategoryService;
	}

	public List<Map<String, Object>> getQueryDesignCategoryList() {
		return queryDesignCategoryList;
	}

	public void setQueryDesignCategoryList(
			List<Map<String, Object>> queryDesignCategoryList) {
		this.queryDesignCategoryList = queryDesignCategoryList;
	}

}
