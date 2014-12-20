package com.weili.action.usercenter;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.shove.Convert;
import com.shove.util.ExportUtils;
import com.shove.util.FindWebPath;
import com.shove.util.StringCommon;
import com.shove.util.UtilDate;
import com.shove.web.util.FileUtils;
import com.weili.action.front.BaseFrontAction;
import com.weili.constants.IConstants;
import com.weili.service.DesignCategoryService;

public class FrontDesignCategoryAction extends BaseFrontAction {
	public static Log log = LogFactory.getLog(FrontDesignCategoryAction.class);

	private DesignCategoryService designCategoryService;
	private List<Map<String, Object>> queryDesignCategoryList;
	private String caId;
	private String fileName;// 用户下载的文件名
	private String targetFile;// 实际路径文件
	protected InputStream inputStream;
	private String fileRealName;
	private Map<String,Object> firstCatMap ;
	
	

	public Map<String, Object> getFirstCatMap() {
		return firstCatMap;
	}

	public void setFirstCatMap(Map<String, Object> firstCatMap) {
		this.firstCatMap = firstCatMap;
	}

	public String getCaId() {
		return caId;
	}

	public void setCaId(String caId) {
		this.caId = caId;
	}

	public List<Map<String, Object>> getQueryDesignCategoryList() {
		return queryDesignCategoryList;
	}

	public void setQueryDesignCategoryList(
			List<Map<String, Object>> queryDesignCategoryList) {
		this.queryDesignCategoryList = queryDesignCategoryList;
	}

	public void setDesignCategoryService(
			DesignCategoryService designCategoryService) {
		this.designCategoryService = designCategoryService;
	}

	/**
	 * 前台设计素材
	 * 
	 * @throws Exception
	 */
	public String frontDesignCategoryInit() throws Exception {
		// 迭代名称
		Integer status = 1;
		caId = request("caId");
		request("caId",caId);
		queryDesignCategoryList  =  new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> catList = designCategoryService
		.queryDesignCategoryList(status);
		if(catList!=null&&catList.size()>0){
			for(Map<String,Object>map:catList){
				Map<String,Object> catMap  = map ;
				if(caId!=null&&caId.equalsIgnoreCase(map.get("categoryId")+"")){
					catMap.put("check", 1); //选中 
				}else{
					catMap.put("check", 2);
				}
				queryDesignCategoryList.add(catMap);
			}
			firstCatMap =  catList.get(0) ;
			Map<String,String> seoMap = getSeoMap("frontDesignCategoryInit.do");
			request("seoMap",seoMap);
		}
		int pageNum = Convert.strToInt(request("curPage"), 1);
		request("pageNum",pageNum);
		return SUCCESS;
	}

	public String frontDesignCategoryInfo() {
		pageBean.setPageSize(16);// 分页
		try {
                                  
			designCategoryService.queryFrontDesignCategory(pageBean);
			List<Map<String, Object>> cList = new ArrayList<Map<String, Object>>();
			List<Map<String, Object>> commList = new ArrayList<Map<String, Object>>();
			commList = pageBean.getPage();
			if (commList != null && commList.size() > 0) {
				for (Map<String, Object> map : commList) {
					Map<String, Object> comMap = new HashMap<String, Object>();
					comMap = map;
					String imgs = map.get("imgUrl") + "";
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
		} catch (Exception e) {
			log.error(e);
		}
		return SUCCESS;
	}

	/***************************************************************************
	 * 前台设计素材下的名称
	 * 
	 * @throws Exception
	 */
	public String queryFrontDesignPageInit() throws Exception {
		// 迭代名称
		Integer status = 1;
		caId = request("caId");
		queryDesignCategoryList  =  new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> catList = designCategoryService
		.queryDesignCategoryList(status);
		if(catList!=null&&catList.size()>0){
			for(Map<String,Object>map:catList){
				Map<String,Object> catMap  = map ;
				if(caId!=null&&caId.equalsIgnoreCase(map.get("categoryId")+"")){
					catMap.put("check", 1); //选中 
				}else{
					catMap.put("check", 2);
				}
				queryDesignCategoryList.add(catMap);
			}
		}
		return SUCCESS;

	}

	public String queryFrontDesignPageInfo() throws Exception {
		pageBean.setPageSize(16);// 分页
		Long categoryId = Convert.strToLong(paramMap.get("categoryId"), -1l);
        request("caId",categoryId);
		try {
			designCategoryService.queryFrontDesignPage(pageBean, categoryId);
			List<Map<String, Object>> cList = new ArrayList<Map<String, Object>>();
			List<Map<String, Object>> commList = new ArrayList<Map<String, Object>>();
			commList = pageBean.getPage();
			if (commList != null && commList.size() > 0) {
				for (Map<String, Object> map : commList) {
					Map<String, Object> comMap = new HashMap<String, Object>();
					comMap = map;
					String imgs = map.get("imgUrl") + "";
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
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		return SUCCESS;

	}
	
	/** 
	 * 下载文件设计素材
	 * @author <a href="mailto:xuzhangchu@eims.com.cn">xzc</a>
	 * @class com.fs.action.front
	 * @since 2014-5-9
	 * @edit 2014-5-9
	 * @version 1.0
	 * @return
	* @throws Exception 
	*/
	public String  downloadBatchFile() throws Exception{
		String  ids = request("ids");
		Long tid = Convert.strToLong(request("tid"), -1L);
		Map<String,String> desMap  = designCategoryService.queryDesignById(IConstants.STATUS_ON,tid);
		List<Map<String,Object>> fileList = new ArrayList<Map<String,Object>>();
		List<String> downList = new ArrayList<String>();
		String title = ""; 
		if(desMap!=null){
			title  = desMap.get("title");
			if(StringUtils.isBlank(ids)){
				fileList = designCategoryService.queryImageIdsList(1, tid);
			}else{
				int i  = StringCommon.checkIds(ids) ;
				if(i>0){
					fileList = designCategoryService.queryImageByIds(1, tid,ids);
				}
			}
			if(fileList!=null&&fileList.size()>0){
				for(Map<String,Object> map :fileList){
					downList.add(map.get("downUrl")+"");
				}
			}
		}
		
		String path  = ServletActionContext.getServletContext().getRealPath("/");//FindWebPath.getWebRootPath();
		if(downList!=null&&downList.size()>0){
			String zipFileName = "batch"+System.currentTimeMillis()+".zip";
			String file_path = ExportUtils.createBtachFile(downList, path, "", zipFileName) ;  
			fileRealName =title ;
			targetFile = file_path ;
			if(StringUtils.isNotBlank(file_path)){
				if(!file_path.startsWith("/zip")){
					response().setCharacterEncoding("UTF-8");
					response().sendRedirect(URLEncoder.encode(file_path, "utf-8").replace("%3A%2F%2F", "://").replace("%2F", "/"));
					return null;
				}
			}
		}
		return null ;
	}



	public InputStream getInputStream() throws Exception{
		String filePath = targetFile;
		if(StringUtils.isNotBlank(filePath)){
				File file = new File(filePath);
				InputStream fis = null;
				try {
					fis = new FileInputStream(file) ;
				}catch (FileNotFoundException e) {
					e.printStackTrace();
					LOG.info("未找到文件名为["+filePath+"]的文件");
				}
				return fis;
		}else{
			response().sendRedirect(filePath);
		}
		
		return null;
	}

	/** 
	* @param inputStream the inputStream to set 
	*/
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	
	/**
	 * @return the fileName
	 * @throws Exception 
	 */
	public String getFileName() throws Exception {
		String downFile = "素材"+System.currentTimeMillis();
		try {
			String agent = request().getHeader("USER-AGENT");
			if (null != agent && -1 != agent.indexOf("MSIE")) {
				downFile = URLEncoder.encode(downFile, "UTF-8");
			} else {
				downFile = new String(downFile.getBytes(), "ISO8859-1");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		downFile = downFile+".zip" ;
		return downFile;
	}
	/** 
	* @param fileName the fileName to set 
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
	* @param fileRealName the fileRealName to set 
	*/
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}

	 
}
