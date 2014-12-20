package com.weili.action.front;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.shove.Convert;
import com.shove.util.FindWebPath;
import com.weili.service.AdvertisementService;
import com.weili.service.DownloadHelpService;

public class FrontDownloadHelpAction extends BaseFrontAction{
	public static Log log = LogFactory.getLog(FrontDownloadHelpAction.class);
	
	private DownloadHelpService downloadHelpService;
	private AdvertisementService advertisementService;
	private List<Map<String, Object>> queryDownloadHelpList;
	private String fileName;//用户下载的文件名
	private String targetFile ;//实际路径文件
	protected InputStream inputStream;
	private String fileRealName ;
	private List<Map<String,Object>>queryAdvertList;
	private List<Map<String,Object>>queryDownloadHelpsList;
   private String caId;
	
	
	public String getCaId() {
		return caId;
	}


	public void setCaId(String caId) {
		this.caId = caId;
	}
	

	public List<Map<String, Object>> getQueryDownloadHelpsList() throws Exception {
		return queryDownloadHelpsList;
	}

	public void setQueryDownloadHelpsList(
			List<Map<String, Object>> queryDownloadHelpsList) {
		this.queryDownloadHelpsList = queryDownloadHelpsList;
	}

	public List<Map<String, Object>> getQueryAdvertList() {
		return queryAdvertList;
	}

	public void setQueryAdvertList(List<Map<String, Object>> queryAdvertList) {
		this.queryAdvertList = queryAdvertList;
	}

	public List<Map<String, Object>> getQueryDownloadHelpList() {
		return queryDownloadHelpList;
	}

	public void setQueryDownloadHelpList(
			List<Map<String, Object>> queryDownloadHelpList) {
		this.queryDownloadHelpList = queryDownloadHelpList;
	}

	public void setDownloadHelpService(DownloadHelpService downloadHelpService) {
		this.downloadHelpService = downloadHelpService;
	}

	/**
	 * 查询前台下载帮助初始化
	 * @throws Exception 
	 */
public String queryDownloadHelpInit() throws Exception{
	
	String name = paramMap.get("name");
	String image = paramMap.get("image");
	String path = paramMap.get("path");
	String advertName = paramMap.get("advertName");
	String advertImage = paramMap.get("advertImage");
	
	try {
		//查询所有的标题
		
		String idStr=request("id");
		Integer status = 1 ;
		caId = request("caId") ;
		queryDownloadHelpsList=downloadHelpService.queryDownloadHelpsList(status);
		Long id =  -1L ;
		if(StringUtils.isNotBlank(idStr)){
	    id  = Convert.strToLong(idStr, -1L);
		}
		Map<String,Object> helpMap = null; 
		if(queryDownloadHelpsList!=null&&queryDownloadHelpsList.size()>0){
			if(id==null||id<=0){
				helpMap  = queryDownloadHelpsList.get(0) ;
			}
			for(Map<String,Object> map:queryDownloadHelpsList){
				Long helpId = (Long)map.get("id");
				if(id.equals(helpId)){
					helpMap  = map ;
				}
			}
		}
		request("helpMap",helpMap);
	    //
		List<Map<String,Object>>newsList = new ArrayList<Map<String,Object>>();
		queryDownloadHelpList=downloadHelpService.queryqueryDownloadHelpIdList(name,image,path);
		if(queryDownloadHelpList!=null&&queryDownloadHelpList.size()>4){
			for(int i=0;i<4;i++){
				newsList.add(queryDownloadHelpList.get(i));
			}
			request("queryDownloadHelpList",newsList);
			
		}else{
			request("queryDownloadHelpList",queryDownloadHelpList);
		}
		
		queryAdvertList=advertisementService.queryAdvertisementerList();
		request("queryAdvertList",queryAdvertList);
		Map<String,String>seoMap=getSeoMap("queryDownloadHelpInit.do");
		request("seoMap",seoMap);
	} catch (Exception e) {
		log.error(e);
		e.printStackTrace();
		throw e;
	}
	
	return SUCCESS;
	
}
/** 
 * 下载文件
 * @author <a href="mailto:xuzhangchu@eims.com.cn">xzc</a>
 * @class com.fs.action.front
 * @since 2014-5-9
 * @edit 2014-5-9
 * @version 1.0
 * @return
* @throws Exception 
*/
public String  downloadFile() throws Exception{
	Long id = Convert.strToLong(request("id"), -1L);
	Map<String,String> map = new HashMap<String, String>();
	map = downloadHelpService.queryCoursewareById(id);
	String path  = FindWebPath.getWebRootPath();
	if(map!=null){
		String file_path = map.get("path") ;
		fileRealName = map.get("name")+file_path.substring(file_path.lastIndexOf("."),file_path.length()) ;
		targetFile =path+File.separator+file_path;
	}
	return SUCCESS ;
}


public InputStream getInputStream(){
	String filePath = targetFile;
	File file = new File(filePath);
	InputStream fis = null;
	try {
		fis = new FileInputStream(file) ;
	}catch (FileNotFoundException e) {
		e.printStackTrace();
		LOG.info("未找到文件名为["+filePath+"]的文件");
	}
	return fis;
}

/** 
* @param inputStream the inputStream to set 
*/
public void setInputStream(InputStream inputStream) {
	this.inputStream = inputStream;
}

/** 
* @return the fileName 
*/
public String getFileName() {
	String downFile =  "" ;
   try {   
   	downFile = new String(fileRealName.getBytes(), "ISO8859-1");   
   } catch (UnsupportedEncodingException e) {   
       e.printStackTrace();   
   }   
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


public void setAdvertisementService(AdvertisementService advertisementService) {
	this.advertisementService = advertisementService;
}

 
}
