  package com.shove.web.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.aspectj.util.FileUtil;

import com.shove.Convert;
import com.shove.web.util.DesSecurityUtil;
import com.shove.web.util.FileUtils;
import com.shove.web.util.ImageUtils;
import com.shove.web.util.ServletUtils;
import com.weili.constants.IConstants;
import com.weili.entity.Admin;
import com.weili.entity.User;



/**
 * kindeditor编辑器上传与文件管理
 *
 */
public class KindEditorUploadAction extends BaseAction{
	public static Log log = LogFactory.getLog(KindEditorUploadAction.class);
	private static final long serialVersionUID = 1L;
	private File imgFile;
	
	public static final String[] types = new String[]{"ext","bat","sh","jsp","jspx","js","class"} ;
	
	/**
     * 文件名称
     */
    private String imgFileFileName;

    /**
     * 图片宽度
     */
    private String imgWidth;

    /**
     * 图片高度
     */
    private String imgHeight;

    /**
     * 图片对齐方式
     */
    private String align;

    /**
     * 图片标题
     */
    private String imgTitle;
    
    /**
     * 上传文件到指定的文件夹下会根据当前日期生成新想文件夹进行区分 
     * 编辑器会传递相应的参数 其中dir为上传的类型
     * 类型分为image，flash，media，file
     * @return
     * @throws Exception 
     */
    public String fileUpload() throws Exception {
    	
    	response().setContentType("text/html;charset=utf-8");
    	
        PrintWriter out = null;
        try {
            out = response().getWriter();
        } catch (IOException e1) {
            log.error(e1);
        }
        
    	//加密：String key1 = des.encrypt("");	解密：des.decrypt(key1);
    	DesSecurityUtil des = new DesSecurityUtil();
		
		//参数格式：dir,type,size,compression,userId;文件类型，上传角色(前台/后台/用户中心)，文件大小，是否压缩（1不压缩2压缩），用户/管理员编号
    	String param = "";
    	try{
    		param = des.decrypt(request("p"));
    	}catch (Exception e) {
    		log.error(e);
    		out.println(getError("上传失败"));
            return null;
		}
    	String[] params = param.split(",");
    	if(params.length!=5){
    		out.println(getError("上传失败"));
            return null;
    	}
    	
    	//参数按当前顺序
    	Integer dirName = Convert.strToInt(params[0],0);//0是默认格式,
    	int type = Convert.strToInt(params[1],-1);//文件上传类型 1后台/2用户中心/3前台
    	int size = Convert.strToInt(params[2], -1);//文件上传大小
    	int compression = Convert.strToInt(params[3], 1);//是否压缩（1压缩2不压缩）
    	long userId = Convert.strToLong(params[4], -1);//由于批量上传会丢失session这里通过传递的userId进行处理
    	
        // 文件保存目录路径
        String savePath = ServletActionContext.getServletContext().getRealPath("/") + IConstants.USER_FILE_URL + "/";
        // 文件保存目录URL
        //String saveUrl = ServletUtils.serverUrl() + IConstants.USER_FILE_URL +"/";
        String saveUrl = IConstants.USER_FILE_URL +"/";
        
        if (imgFile == null) {
            out.println(getError("请选择文件。"));
            return null;
        }
        
        // 检查目录
        File uploadDir = new File(savePath);
        if (!uploadDir.isDirectory()) {
        	uploadDir.mkdirs();
        }
        // 检查目录写权限
        if (!uploadDir.canWrite()) {
            out.println(getError("上传目录没有写权限。"));
            return null;
        }
        
        if(!IConstants.EXTMAP.containsKey(dirName)){//如果是空值，那么上面就会转换为0，如果还是不存在，则表示这是用户随便输入的，改为默认值为0（默认格式）
        	dirName = 0 ;
        }
        //创建文件夹,由于这里是要做前/后台/用户的区别，建立文件夹需要区分前后台，前台区分是属于哪个用户
        
        savePath += IConstants.NAMEMAP.get(dirName);
        saveUrl += IConstants.NAMEMAP.get(dirName);
        
        if(type==1&&userId>0){//后台
        	savePath += "/admin/";
        	saveUrl +=  "/admin/";
        	
        }else if(type==2&&userId>0){//用户中心
        	savePath += "/users/"+userId+"/";
        	saveUrl += "/users/"+userId+"/";
        	
        }else if(type==3){//前台----------------是否有其他条件过滤，或者固定上传文件类型？
        	savePath += "/fronts/";
        	saveUrl += "/fronts/";
        }else{
        	out.println(getError("上传失败。"));
            return null;
        }
        
        if(size<0||!IConstants.SIZEMAP.containsKey(size)){
        	out.println(getError("上传失败。"));
            return null;
        }
        
        //检查当前文件的大小
        long fileSize = IConstants.SIZEMAP.get(size);	
        if (imgFile.length() > fileSize) {
            out.println(getError("[ " + imgFileFileName + " ]超过单个文件大小限制，请上传小于"+fileSize/(1024.0*1024)+"M的文件"));
            return null;
        }
        
        File saveDirFile = new File(savePath);
        if (!saveDirFile.exists()) {
        	saveDirFile.mkdirs();
        }
        
        // 创建文件夹
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/yyyyMMdd");
        String ymd = sdf.format(new Date());
        savePath += ymd + "/";
        saveUrl += ymd + "/";
        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }
        String fileExt = imgFileFileName.substring(imgFileFileName.lastIndexOf(".") + 1).toLowerCase();
        
        if(Arrays.<String>asList(types).contains(fileExt)){
          	out.println(getError("上传失败，上传文件扩展名是不允许的扩展名。"));
			return null;
        }
        
        if(!Arrays.<String>asList(IConstants.EXTMAP.get(dirName).split(",")).contains(fileExt)){
			out.println(getError("上传文件扩展名是不允许的扩展名。\n只允许" + IConstants.EXTMAP.get(dirName) + "格式。"));
			return null;
		}
        
        String newFileName = FileUtils.getFileName()+ "." + fileExt;
        File uploadedFile = new File(savePath, newFileName);
        try {
            FileUtil.copyFile(imgFile, uploadedFile);
            JSONObject obj = new JSONObject();
            obj.put("error", 0);
            obj.put("url", saveUrl + newFileName);
            obj.put("type", type);
            obj.put("fileSize", uploadedFile.length());
            log.debug(obj);
            out.println(obj.toString());
            log.debug("上传:[" + uploadedFile.getName() + "]" + ">>>[" + newFileName + "]成功");
             //压缩文件
             if(compression==1&&dirName==0){//只有是图片是才有压缩，
            	ImageUtils.reduceImg(uploadedFile.getPath(), uploadedFile.getParentFile()+"/M_"+uploadedFile.getName(), 100, 100);
            }
        } catch (IOException e) {
            log.error("上传失败:" + e);
        }
        return null;
    }
    
    /**
     * 上传文件管理
     * 根据指定的目录查询出相应的文件中的文件
     * 根据类型进行文件排序
     * 因为编辑器通过ajax方式请求获取数据
     * js中为了防止缓存在请求连接中加入了当前时间戳
     * 会导致struts2转型拦截器报错
     * 可以在 filemanager/filemanager.js文件中找到相应调用方法对请求参数进行一个修改即可 
     * @return   
     * @throws Exception 
     */
    @SuppressWarnings("unchecked")
	public String fileManager() throws Exception{
    	PrintWriter out = response().getWriter();
    	response().setContentType("text/html;charset=utf-8");
    	
        try {
            out = response().getWriter();
        } catch (IOException e1) {
            log.error(e1);
        }
        
    	//加密：String key1 = des.encrypt("");	解密：des.decrypt(key1);
    	DesSecurityUtil des = new DesSecurityUtil();
		
		//参数格式：dir,type,size,compression,userId;文件类型，上传角色(前台/后台/用户中心)，文件大小，是否压缩（1不压缩2压缩），用户/管理员编号
		
    	String param = des.decrypt(request("p"));
    	String[] params = param.split(",");
    	if(params.length!=5){
    		out.println(getError("读取失败"));
            return null;
    	}
    	
    	Integer dirName = Convert.strToInt(params[0],0);//0是默认格式,
    	int type = Convert.strToInt(params[1],-1);//文件上传类型 后台/前台
    	int size = Convert.strToInt(params[2], -1);//文件上传大小
    	int compression = Convert.strToInt(params[3], 1);//文件上传大小
    	long userId = Convert.strToLong(params[4], -1);
    	
    	//根目录路径，可以指定绝对路径，比如 /var/www/attached/
    	String rootPath = ServletActionContext.getServletContext().getRealPath("/") +IConstants.USER_FILE_URL+"/";
    	//根目录URL，可以指定绝对路径，比如 http://www.yoursite.com/attached/
    	String rootUrl = IConstants.USER_FILE_URL+"/";
		
		if(dirName<0){
			out.println(getError("读取失败。"));
            return null;
		}
	     
	    if(!IConstants.EXTMAP.containsKey(dirName)){//如果是空值，那么上面就会转换为0，如果还是不存在，则表示这是用户随便输入的，改为默认值为0（默认格式）
	    	out.println(getError("读取失败。"));
            return null;
	    }
	     //创建文件夹,由于这里是要做前/后台/用户的区别，建立文件夹需要区分前后台，前台区分是属于哪个用户
	     
	    rootPath += IConstants.NAMEMAP.get(dirName);
	    rootUrl += IConstants.NAMEMAP.get(dirName);
         
        if(type==1){//后台
        	Admin admin = (Admin) session(IConstants.SESSION_ADMIN);
        	if(admin==null){
        		out.println(getError("请登录。"));
                return null;
        	}
        	rootPath += "/admin/";
        	rootUrl +=  "/admin/";
        }else if(type==2){//用户中心
        	User user = (User) session(IConstants.SESSION_USER);
        	if(user==null){
        		out.println(getError("请登录。"));
                return null;
        	}
        	rootPath += "/users/"+user.getId()+"/";
        	rootUrl += "/users/"+user.getId()+"/";
        }else if(type==3){//前台----------------是否有其他条件过滤，或者固定上传文件类型？
        	rootPath += "/fronts/";
        	rootUrl += "/fronts/";
        }else{
        	out.println(getError("获取失败。"));
            return null;
        }
    	
		File saveDirFile = new File(rootPath);
		if (!saveDirFile.exists()) {
			saveDirFile.mkdirs();
		}
    	//根据path参数，设置各路径和URL
    	String path = request().getParameter("path") != null ? request().getParameter("path") : "";
    	String currentPath = rootPath + path;
    	String currentUrl = rootUrl + path;
    	String currentDirPath = path;
    	String moveupDirPath = "";
    	if (!"".equals(path)) {
    		String str = currentDirPath.substring(0, currentDirPath.length() - 1);
    		moveupDirPath = str.lastIndexOf("/") >= 0 ? str.substring(0, str.lastIndexOf("/") + 1) : "";
    	}

    	//排序形式，name or size or type
    	String order = request().getParameter("order") != null ? request().getParameter("order").toLowerCase() : "name";

    	//不允许使用..移动到上一级目录
    	if (path.indexOf("..") >= 0) {
    		out.println(getError("Access is not allowed."));
    		return null;
    	}
    	//最后一个字符不是/
    	if (!"".equals(path) && !path.endsWith("/")) {
    		out.println(getError("Parameter is not valid."));
    		return null;
    	}
    	//目录不存在或不是目录
    	File currentPathFile = new File(currentPath);
    	if(!currentPathFile.isDirectory()){
    		out.println(getError("Directory does not exist."));
    		return null;
    	}

    	//遍历目录取的文件信息
    	List<Hashtable> fileList = new ArrayList<Hashtable>();
    	if(currentPathFile.listFiles() != null) {
    		for (File file : currentPathFile.listFiles()) {
    			Hashtable<String, Object> hash = new Hashtable<String, Object>();
    			String fileName = file.getName();
    			if(file.isDirectory()) {
    				hash.put("is_dir", true);
    				hash.put("has_file", (file.listFiles() != null));
    				hash.put("filesize", 0L);
    				hash.put("is_photo", false);
    				hash.put("filetype", "");
    			} else if(file.isFile()){
    				String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
    				hash.put("is_dir", false);
    				hash.put("has_file", false);
    				hash.put("filesize", file.length());
    				hash.put("is_photo", Arrays.<String>asList(IConstants.EXTMAP.get(dirName).split(",")).contains(fileExt));
    				hash.put("filetype", fileExt);
    			}
    			hash.put("filename", fileName);
    			hash.put("datetime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(file.lastModified()));
    			fileList.add(hash);
    		}
    	}

    	if ("size".equals(order)) {
    		Collections.sort(fileList, new SizeComparator());
    	} else if ("type".equals(order)) {
    		Collections.sort(fileList, new TypeComparator());
    	} else {
    		Collections.sort(fileList, new NameComparator());
    	}
    	JSONObject result = new JSONObject();
    	result.put("moveup_dir_path", moveupDirPath);
    	result.put("current_dir_path", currentDirPath);
    	result.put("current_url", currentUrl);
    	result.put("total_count", fileList.size());
    	result.put("file_list", fileList);
    	result.put("type", type);

    	response().setContentType("application/json; charset=UTF-8");
    	out.println(result.toString());
    	return null;
    }
    
	/**
	 * 根据文件名称排序
	 *
	 */
	@SuppressWarnings("unchecked")
	public class NameComparator implements Comparator {
		public int compare(Object a, Object b) {
			Hashtable hashA = (Hashtable)a;
			Hashtable hashB = (Hashtable)b;
			if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {
				return -1;
			} else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {
				return 1;
			} else {
				return ((String)hashA.get("filename")).compareTo((String)hashB.get("filename"));
			}
		}
	}
	
	/**
	 * 根据文件大小排序
	 *
	 */
	@SuppressWarnings("unchecked")
	public class SizeComparator implements Comparator {
		public int compare(Object a, Object b) {
			Hashtable hashA = (Hashtable)a;
			Hashtable hashB = (Hashtable)b;
			if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {
				return -1;
			} else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {
				return 1;
			} else {
				if (((Long)hashA.get("filesize")) > ((Long)hashB.get("filesize"))) {
					return 1;
				} else if (((Long)hashA.get("filesize")) < ((Long)hashB.get("filesize"))) {
					return -1;
				} else {
					return 0;
				}
			}
		}
	}
	
	/**
	 * 根据文件类型排序
	 *
	 */
	@SuppressWarnings("unchecked")
	public class TypeComparator implements Comparator {
		public int compare(Object a, Object b) {
			Hashtable hashA = (Hashtable)a;
			Hashtable hashB = (Hashtable)b;
			if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {
				return -1;
			} else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {
				return 1;
			} else {
				return ((String)hashA.get("filetype")).compareTo((String)hashB.get("filetype"));
			}
		}
	}
    
    /**
     * 返回JSON格式的错误信息
     * @param message
     * @return
     */
    private String getError(String message) {
        JSONObject obj = new JSONObject();
        obj.put("error", 1);
        obj.put("message", message);
        log.debug(obj);
        return obj.toString();
    }
	
	public File getImgFile() {
		return imgFile;
	}
	
	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}
	
	public String getImgFileFileName() {
		return imgFileFileName;
	}
	
	public void setImgFileFileName(String imgFileFileName) {
		this.imgFileFileName = imgFileFileName;
	}
	
	public String getImgWidth() {
		return imgWidth;
	}
	
	public void setImgWidth(String imgWidth) {
		this.imgWidth = imgWidth;
	}
	
	public String getImgHeight() {
		return imgHeight;
	}
	
	public void setImgHeight(String imgHeight) {
		this.imgHeight = imgHeight;
	}
	
	public String getAlign() {
		return align;
	}
	
	public void setAlign(String align) {
		this.align = align;
	}
	
	public String getImgTitle() {
		return imgTitle;
	}
	
	public void setImgTitle(String imgTitle) {
		this.imgTitle = imgTitle;
	}
	
}
