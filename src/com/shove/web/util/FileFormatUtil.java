package com.shove.web.util;

import java.io.*;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

public class FileFormatUtil {

	/**
	 * 判断文件是否正确
	 * @param file 上传文件
	 * @param fileName 文件名称
	 * @return
	 * @throws Exception
	 */
	public static String fileIsTrue(File file, String fileName) throws Exception {
		if(file == null){
			return "请上传文件!";
		}
		
		if(!file.exists()){
			return "文件不存在";
		}
		
		int lastIndex = fileName.lastIndexOf(".");//从后面查找
		String suffix = fileName.substring(lastIndex + 1);//截取
		if(!"XLS".equalsIgnoreCase(suffix)){
			return "文件格式不正确";
		}
		return null;
	}
	
	
	/**
	 * 判断文件是否正确
	 * @param file 上传文件
	 * @param fileName 文件名称
	 * @return
	 * @throws Exception
	 */
	public static String fileIsTrues(File file, String fileName) throws Exception {
		if(file == null){
			return "请上传文件!";
		}
		
		if(!file.exists()){
			return "文件不存在";
		}
		
		int lastIndex = fileName.lastIndexOf(".");//从后面查找
		String suffix = fileName.substring(lastIndex + 1);//截取
		if(!"sql".equalsIgnoreCase(suffix)){
			return "文件格式不正确";
		}
		return null;
	}
	
	/**
	 * 上传文件
	 * @param fileName 文件名
	 * @return 文件路径
	 * @throws Exception 
	 */
	public static String uploadFiledd(File file,String fileName) throws Exception{
		//基于myFile创建一个文件输入流  
        InputStream is = null;
        OutputStream os =null;
        String path="";
		try {
			 // 设置上传文件目录  
	        String uploadPath = ServletActionContext.getServletContext()  
	                .getRealPath("/uploadfile"); 
	        File uploadDir = new File(uploadPath);//检查文件是否是目录不是则创建
	        if (!uploadDir.isDirectory()) {
	        	uploadDir.mkdirs();
			}
			is = new FileInputStream(file);
			//若有相同文件，先删除已存在文件
			deleteFile(uploadPath, fileName);
	          
	        // 设置目标文件  
	        File toFile = new File(uploadPath, fileName);  
	         
	        // 创建一个输出流  
	        os = new FileOutputStream(toFile);  
	        if(StringUtils.isNotBlank(fileIsTrues(toFile, fileName))){
	        	  return "";
	          }
	        //设置缓存  
	        byte[] buffer = new byte[1024];  
	  
	        int length = 0;  
	  
	        //读取myFile文件输出到toFile文件中  
	        while ((length = is.read(buffer)) > 0) {  
	            os.write(buffer, 0, length);  
	        }   
	        path=toFile.getPath();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally{
			
	        //关闭输出流  
	        os.close();  
	        //关闭输入流  
	        is.close();  
		}
       return path;
	}
	
	
	/**
	 * 上传文件
	 * @param fileName 文件名
	 * @return 文件路径
	 * @throws Exception 
	 */
	public static String uploadFile(File file,String fileName) throws Exception{
		//基于myFile创建一个文件输入流  
        InputStream is = null;
        OutputStream os =null;
        String path="";
		try {
			 // 设置上传文件目录  
	        String uploadPath = ServletActionContext.getServletContext()  
	                .getRealPath("/uploadfile"); 
	        File uploadDir = new File(uploadPath);//检查文件是否是目录不是则创建
	        if (!uploadDir.isDirectory()) {
	        	uploadDir.mkdirs();
			}
			is = new FileInputStream(file);
			//若有相同文件，先删除已存在文件
			deleteFile(uploadPath, fileName);
	          
	        // 设置目标文件  
	        File toFile = new File(uploadPath, fileName);  
	         
	        // 创建一个输出流  
	        os = new FileOutputStream(toFile);  
	        if(StringUtils.isNotBlank(fileIsTrue(toFile, fileName))){
	        	  return "";
	          }
	        //设置缓存  
	        byte[] buffer = new byte[1024];  
	  
	        int length = 0;  
	  
	        //读取myFile文件输出到toFile文件中  
	        while ((length = is.read(buffer)) > 0) {  
	            os.write(buffer, 0, length);  
	        }   
	        path=toFile.getPath();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally{
			
	        //关闭输出流  
	        os.close();  
	        //关闭输入流  
	        is.close();  
		}
       return path;
	}
	
	/**
	 * 若有重复文件，删除已存在的文件
	 * @param source
	 * @param fileName
	 */
	public  static  void deleteFile(String parent,String fileName){
		parent=parent.replace("/", File.separator);
		File f=new File(parent,fileName);
		if(f!=null && f.exists() && f.isFile()){
			f.delete();
		}
	}
}
