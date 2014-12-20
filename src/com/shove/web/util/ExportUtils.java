/* *
 * ============================================================================
 * <p>Title: XXX项目</p>
 * <p>Company: 深圳英迈思文化科技有限公司</p>
 * <p>Copyright:2010-2014深圳英迈思文化科技有限公司|项目组，版权所有。 </p>
 * @(#)ExportUtils.java 2014-4-15 
 * © 2014 ShenZhen Technology Development Co.,Ltd, All Right Reserved.  ©
 * ============================================================================
*/
package com.shove.web.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.shove.Convert;
import com.shove.data.ConnectionManager;
import com.shove.data.DataException;
import com.shove.data.DataSet;
import com.shove.data.dao.MySQL;
import com.shove.vo.PageBean;
import com.weili.database.Dao;

/** 
 * 请添加方法说明注释
 * @author <a href="mailto:xuzhangchu@eims.com.cn">zf</a>
 * @class com.shove.util
 * @since 2014-4-15
 * @edit 2014-4-15
 * @version 1.0
 */
public class ExportUtils {
	private static Log log = LogFactory.getLog(ExportUtils.class);
	public static void CreateZipFile(String filePath, String zipFilePath) {
		FileOutputStream fos = null;
		ZipOutputStream zos = null;
		try {
			fos = new FileOutputStream(zipFilePath);
			zos = new ZipOutputStream(fos);
			writeZipFile(new File(filePath), zos, "");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if (zos != null)
					zos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if (fos != null)
					fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	public static void writeZipFile(File f, ZipOutputStream zos,
			String hiberarchy) {
		if (f.exists()) {
			if (f.isDirectory()) {
				hiberarchy += f.getName() + "/";
				File[] fif = f.listFiles();
				for (File file : fif) {
					writeZipFile(file, zos, hiberarchy);
				}
			} else {
				FileInputStream fis = null;
				try {
					fis = new FileInputStream(f);
					ZipEntry ze = new ZipEntry(f.getName());
					zos.putNextEntry(ze);
					byte[] b = new byte[1024];
					while (fis.read(b) != -1) {
						zos.write(b);
						b = new byte[1024];
					}
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						if (fis != null){
							fis.close();
						}
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

			}
		}

	}
	
	/** 
	  * 批量下载
	  * @author <a href="mailto:xuzhangchu@eims.com.cn">xzc</a>
	  * @class com.shove.util
	  * @since 2014-7-30
	  * @edit 2014-7-30
	  * @version 1.0
	  * @param fileList  文件路径列表
	  * @param filePath  tomcat文件基本存储路径 
	  * @param otherPath 指定服务器生成的zip存储路径（可选）
	  * @param zipFileName 返回的下载的压缩文件
	*/
	public static String createBtachFile(List<String>fileList,String filePath,String otherPath,String zipFileName){
		String path = "";
		if(StringUtils.isBlank(otherPath)){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Date newDate = new Date();
			String newDateStr = sdf.format(newDate);
			path = path + "/zips/"+newDateStr+"/"+newDate.getTime();
		}else{
			path = otherPath;
		}
		//zip文件路径
		String zipFilePath = path+"/zip/";
		//创建zip存储路径
		createFile(zipFilePath);
		//压缩文件详细路径
		if(StringUtils.isBlank(zipFileName)){
			zipFilePath = zipFilePath + "project.zip";
		}else{
			zipFilePath = zipFilePath + zipFileName;
		}
		
		FileOutputStream fos = null;
		ZipOutputStream zos = null; 
		try {
			fos = new FileOutputStream(zipFilePath);
			zos = new ZipOutputStream(fos);
			for(String file:fileList){
				File tempFile  = new File(filePath+file) ;
				writeZipFile(tempFile, zos,"") ;
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if (zos != null)
					zos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				if (fos != null)
					fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return zipFilePath;
	}
	
	/**
	 * 将所有数据放到一个excel表格中，不分页显示
	 * @param connectionManager
	 * @param pageBean
	 * @param filePath
	 * @param paramMap
	 * @param table
	 * @param field
	 * @param order
	 * @param condition
	 * @param row1
	 * @param rows
	 * @throws Exception
	 */
	public static void createExcels(ConnectionManager connectionManager,PageBean<Map<String,Object>> pageBean,String filePath,String zipFileName,Map<String,Object> paramMap,String table,String field,String order,String condition,String[] row1,String[] rows,Integer type) throws Exception{
		Connection conn = MySQL.getConnection();
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		try{
			DataSet ds = MySQL.executeQuery(conn, "select "+field+" from "+table+" where 1=1 "+condition.toString()+" "+order);
			ds.tables.get(0).rows.genRowsMap();
			list = ds.tables.get(0).rows.rowsMap;
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			throw e;
		}finally{
			conn.close();
		}
		if(list==null||list.size()<=0){
			return;
		}
		//导出excel
		HSSFWorkbook wb = null;
		if(type == 1){//订单导出
			wb = exportOrderExcel(list,row1,rows);
		}else if(type == 3){//优惠券导出
			wb = exportCouponExcel(list,row1,rows);
		}else{//其它导出
			wb = exportExcel(list,row1,rows);
		}
		
		if (wb != null) {
			FileOutputStream os = new FileOutputStream(new File(filePath + zipFileName + ".xls"));
			wb.write(os);
			os.flush();
			os.close();
			os=null;
			wb = null;
		}
	}
	
	/**
	 * 	 * 批量生成excel文件
	 * @param pageBean 分页数据
	 * @param filePath 生成文件路径
	 * @param paramMap 查询条件参数全部放在pMap中
	 * @param connectionManager	数据库链接对象，由于数据量比较大时，如果不及时的开启关闭数据库链接会占用很多资源，操作时间过长时，会出现连接超时，传递连接对象由工具类进行开启关闭连接
	 * @param table	表名
	 * @param field	字段名
	 * @param order	排序
	 * @param condition 条件
	 * @param row1	头部列说明	new String[]{"用户名","密码","邮箱"}
	 * @param rows	列字段内容	new String[]{"name","password","email"}	两者相互对应,上面的来自用户对字段的说明，下者来自数据库查询出的字段
	 * @throws Exception 
	 */
	/*	
	public static void createExcels(ConnectionManager connectionManager ,PageBean<Map<String,Object>> pageBean,String filePath,Map<String,Object> paramMap,String table,String field,String order,String condition,String[] row1,String[] rows) throws Exception{
		Connection conn = connectionManager.getConnection();
		try{
			getDataSet(conn,pageBean,paramMap,table,field,order,condition);//查询数据
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			throw e;
		}finally{
			conn.close();
		}
		List<Map<String,Object>> list = pageBean.getPage();
		if(list==null||list.size()<=0){
			return;
		}
		pageBean.setPage(null);//把本次处理的记录清空，
		//导出excel
		HSSFWorkbook wb = exportExcel(list,row1,rows);
		if (wb != null) {
			FileOutputStream os = new FileOutputStream(new File(filePath + pageBean.getPageNum() + ".xls"));
			wb.write(os);
			os.flush();
			os.close();
			os=null;
			wb = null;
		}
		
		//判断是否还有数据，如果还有则继续递归
		if(list!=null&&list.size()==pageBean.getPageSize()&&pageBean.getPageNum()<pageBean.getTotalPageNum()){//如果不等于null，每页展示pageSize条，如果相等，说明可能后面还有，由于每页展示数据是pageSize条，如果不与pageSize相等说明没有数据了。
			int pageNum = (int)pageBean.getPageNum()+1;
			pageBean.setPageNum(pageNum);//查询下一页数据
			list = null;
			createExcels(connectionManager,pageBean,filePath,paramMap,table,field,order,condition,row1,rows);
		}
	}*/
	
	/**
	 * 生成zip压缩文件
	 * @param pageBean	数据源分页
	 * @param paramMap	数据源查询条件
	 * @param path	临时文件生成路径，用户传入服务器地址，然后通过默认规范进行拼接
	 * @param zipFileName	zip压缩文件名，默认为project.zip
	 * @param otherPath 临时文件路径，优先级高于path。当otherPath不为空时，则临时文件存放目录以此为准不会作其他拼接
	 * @param connectionManager	数据库链接对象，由于数据量比较大时，如果不及时的开启关闭数据库链接会占用很多资源，操作时间过长时，会出现连接超时，传递连接对象由工具类进行开启关闭连接
	 * @param table	表名
	 * @param field	字段名
	 * @param order	排序
	 * @param condition 条件
	 * @param row1	头部列说明	new String[]{"用户名","密码","邮箱"}
	 * @param rows	列字段内容	new String[]{"name","password","email"}	两者相互对应,上面的来自用户对字段的说明，下者来自数据库查询出的字段
	 * @return
	 * @throws Exception 
	 */

	public static String createZip(ConnectionManager connectionManager ,PageBean<Map<String,Object>>pageBean,Map<String,Object> paramMap,Integer type,String path,String zipFileName,String otherPath,String table,String field,String order,String condition,String[] row1,String[] rows) throws Exception{
		if(StringUtils.isBlank(otherPath)){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Date newDate = new Date();
			String newDateStr = sdf.format(newDate);
			path = path + "/zips/"+newDateStr+"/"+newDate.getTime();
		}else{
			path = otherPath;
		}
		
		String filePath = path+"/excel/";//excel文件路径
		String zipFilePath = path+"/zip/";//zip文件路径
		createFile(filePath);
		createFile(zipFilePath);
		
		if(StringUtils.isBlank(zipFileName)){
			zipFilePath = zipFilePath + "project.zip";
		}else{
			zipFilePath = zipFilePath + zipFileName;
		}
		int index = zipFileName.lastIndexOf(".");
		String fileName = zipFileName.substring(0,index);
		createExcels(connectionManager,pageBean, filePath, fileName,paramMap,table,field,order,condition,row1,rows,type);
		CreateZipFile(filePath, zipFilePath);
		return zipFilePath;
	}
	
	/**
	 * 获得数据源（BaseService里面的dataPage方法，代码拷贝过来的，没作任何修改）
	 * @param conn
	 * @param pageBean
	 * @param paramMap
	 * @param table	表名
	 * @param field	字段名
	 * @param order	排序
	 * @param condition	条件
	 * @throws SQLException
	 * @throws DataException
	 */
	 
	public static void getDataSet(Connection conn,PageBean<Map<String,Object>> pageBean,Map<String,Object> paramMap,String table,String field,String order,String condition) throws SQLException, DataException{
		DataSet ds = new DataSet();
		List<Object> outParameterValues = new ArrayList<Object>();
		long curPage =  pageBean.getPageNum();
		Dao.Procedures.pr_pager(conn, ds, outParameterValues, table, field, pageBean.getPageSize(), curPage, order, condition, 0);
		long count = (Long) outParameterValues.get(0);
		boolean result = pageBean.setTotalNum(count);
		if(result){
			ds.tables.get(0).rows.genRowsMap();
			pageBean.setPage(ds.tables.get(0).rows.rowsMap);
		}
	}
	
	/**
	 * excel生成格式
	 * @param list	数据源
	 * @param row1	头部列说明	new String[]{"用户名","密码","邮箱"}
	 * @param rows	列字段内容	new String[]{"name","password","email"}	两者相互对应,上面的来自用户对字段的说明，下者来自数据库查询出的字段
	 * @return
	 */
	 
	public static HSSFWorkbook exportExcel(List<Map<String,Object>> list,String[] row1,String[] rows){
		HSSFWorkbook wb = new HSSFWorkbook();
		try {
			HSSFSheet sheet = null;
			sheet = wb.createSheet("sheet1");
			HSSFRow topRow = sheet.createRow(0);
			for (int i = 0; i < row1.length; i++) {
				setCellGBKValue(topRow.createCell((short) i), row1[i]);
			}
			
			HSSFRow row = null;
			int length = list.size();
			Map<String,Object> map ;
			int j = 1;
			for (int i = 0;i < length ; i++) {
				row = sheet.createRow(j);
				map = list.get(i);
				for (int k = 0; k < rows.length; k++) {
					Object obj = map.get(rows[k]);
					if(isNullOrEmpty(obj)){
						setCellGBKValue(row.createCell((short) k), "");
					}else{
						setCellGBKValue(row.createCell((short) k), obj+"");
					}
				}
				map = null;
				row = null;
				j++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wb;
	}
	
	public static HSSFWorkbook exportCouponExcel(List<Map<String,Object>> list,String[] row1,String[] rows){
		HSSFWorkbook wb = new HSSFWorkbook();
		try {
			HSSFSheet sheet = null;
			sheet = wb.createSheet("sheet1");
			HSSFRow topRow = sheet.createRow(0);
			for (int i = 0; i < row1.length; i++) {
				setCellGBKValue(topRow.createCell((short) i), row1[i]);
			}
			
			HSSFRow row = null;
			int length = list.size();
			Map<String,Object> map ;
			int j = 1;
			for (int i = 0;i < length ; i++) {
				row = sheet.createRow(j);
				map = list.get(i);
				for (int k = 0; k < rows.length; k++) {
					Object obj = map.get(rows[k]);
					Integer status = -1;
					if(k == 3){
						status = Convert.strToInt(obj+"", -1);
						if(status == 1){
							setCellGBKValue(row.createCell((short) k), "包邮");
						}else if(status == 2){
							setCellGBKValue(row.createCell((short) k), "满减");
						}else if(status == 3){
							setCellGBKValue(row.createCell((short) k), "产品满减");
						}
						continue;
					}
					if(isNullOrEmpty(obj)){
						setCellGBKValue(row.createCell((short) k), "");
					}else{
						setCellGBKValue(row.createCell((short) k), obj+"");
					}
				}
				map = null;
				row = null;
				j++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wb;
	}

	public static HSSFWorkbook exportOrderExcel(List<Map<String,Object>> list,String[] row1,String[] rows){
		HSSFWorkbook wb = new HSSFWorkbook();
		try {
			HSSFSheet sheet = null;
			sheet = wb.createSheet("sheet1");
			HSSFRow topRow = sheet.createRow(0);
			int len= row1.length-5;
			for (int i = 0; i < len; i++) {
				setCellGBKValue(topRow.createCell((short) i), row1[i]);
			}
			
			HSSFRow row = null;
			int length = list.size();
			Map<String,Object> map ;
			int j = 1;
			for (int i = 0;i < length ; i++) {
				row = sheet.createRow(j);
				map = list.get(i);
				for (int k = 0; k < len; k++) {
					Integer status = -1;
					Object obj = map.get(rows[k]);
					if(k == 6){
						status = Convert.strToInt(obj+"", -1);
						if(status == 1){
							setCellGBKValue(row.createCell((short) k), "未付款");
						}else if(status == 2){
							setCellGBKValue(row.createCell((short) k), "待审核");
						}else if(status == 3){
							setCellGBKValue(row.createCell((short) k), "待发货");
						}else if(status == 4){
							setCellGBKValue(row.createCell((short) k), "已发货");
						}else if(status == 5){
							setCellGBKValue(row.createCell((short) k), "交易成功");
						}else if(status == 6){
							setCellGBKValue(row.createCell((short) k), "已取消");
						}
						continue;
					}else if(k == 7){
						status = Convert.strToInt(obj+"", -1);
						BigDecimal rmbPrice = (BigDecimal) map.get(rows[32]);
						if(rmbPrice.compareTo(BigDecimal.ZERO) == 0){
							setCellGBKValue(row.createCell((short) k), "余额支付");
						}else if(status == 1){
							setCellGBKValue(row.createCell((short) k), "在线支付");
						}else if(status == 2){
							setCellGBKValue(row.createCell((short) k), "货到付款");
						}
						continue;
					}else if(k == 16){
						Object provinceName = map.get(rows[33]);
						Object cityName = map.get(rows[34]);
						Object areaName = map.get(rows[35]);
						if(isNullOrEmpty(areaName)){
							areaName = "";
						}
						Object address = map.get(rows[36]);
						setCellGBKValue(row.createCell((short) k), ""+provinceName+cityName+areaName+address);
						continue;
					}else if(k == 22){
						status = Convert.strToInt(obj+"", -1);
						if(status == 1){
							setCellGBKValue(row.createCell((short) k), "普通商品");
						}else if(status == 2){
							setCellGBKValue(row.createCell((short) k), "秒杀商品");
						}else if(status == 3){
							setCellGBKValue(row.createCell((short) k), "积分商品");
						}else if(status == 4){
							setCellGBKValue(row.createCell((short) k), "赠品");
						}else if(status == 5){
							setCellGBKValue(row.createCell((short) k), "随心配");
						}else if(status == 7){
							setCellGBKValue(row.createCell((short) k), "换购商品");
						}else if(status == 8){
							setCellGBKValue(row.createCell((short) k), "预售商品");
						}
						continue;
					}else if(k == 26){
						status = Convert.strToInt(obj+"", -1);
						if(status == 1){
							setCellGBKValue(row.createCell((short) k), "普通发票");
						}else if(status == 2){
							setCellGBKValue(row.createCell((short) k), "不开发票");
						}
						continue;
					}else if(k == 27){
						status = Convert.strToInt(obj+"", -1);
						if(status != null&&status == 1){
							setCellGBKValue(row.createCell((short) k), "个人");
						}else if(status != null&&status == 2){
							setCellGBKValue(row.createCell((short) k), "单位");
						}else{
							setCellGBKValue(row.createCell((short) k), "");
						}
						continue;
					}else if(k == 29){
						status = Convert.strToInt(obj+"", -1);
						if(status != null&&status == 1){
							setCellGBKValue(row.createCell((short) k), "明细");
						}else{
							setCellGBKValue(row.createCell((short) k), "");
						}
						continue;
					}else if(k == 31){
						status = Convert.strToInt(obj+"", -1);
						if(status == 1){
							setCellGBKValue(row.createCell((short) k), "申请中");
						}else if(status == 2){
							setCellGBKValue(row.createCell((short) k), "申请成功");
						}else if(status == 3){
							setCellGBKValue(row.createCell((short) k), "产品已寄出");
						}else if(status == 4){
							setCellGBKValue(row.createCell((short) k), "审核中");
						}else if(status == 5){
							setCellGBKValue(row.createCell((short) k), "产品已发货");
						}else if(status == 6){
							setCellGBKValue(row.createCell((short) k), "退换货结束");
						}else if(status == 7){
							setCellGBKValue(row.createCell((short) k), "申请失败 ");
						}
						continue;
					}
					
					if(isNullOrEmpty(obj)){
						setCellGBKValue(row.createCell((short) k), "");
					}else{
						setCellGBKValue(row.createCell((short) k), obj+"");
					}
				}
				map = null;
				row = null;
				j++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wb;
	}
	
	/**
	 * 设置excel编码
	 * @param cell
	 * @param value
	 */
	public static void setCellGBKValue(HSSFCell cell, String value) {
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue(value);
	}
	
	/**
	 * 创建文件夹
	 * @param filePath
	 */
	public static void createFile(String filePath) {
		File file = new File(filePath);
		if (!file.exists()) {
			file.mkdirs();
		}
	}
	
	/**
	 * 判断对象是否为空: 对象为null，字符序列长度为0，集合类、Map为empty
	 * 
	 * @param obj
	 * @return
	 */
	public static boolean isNullOrEmpty(Object obj) {
		if (obj == null)
			return true;

		if (obj instanceof CharSequence)
			return ((CharSequence) obj).length() == 0;

		if (obj instanceof Collection)
			return ((Collection) obj).isEmpty();

		if (obj instanceof Map)
			return ((Map) obj).isEmpty();

		if (obj instanceof Object[]) {
			Object[] object = (Object[]) obj;
			if (object.length == 0) {
				return true;
			}
			boolean empty = true;
			for (int i = 0; i < object.length; i++) {
				if (!isNullOrEmpty(object[i])) {
					empty = false;
					break;
				}
			}
			return empty;
		}
		return false;
	}
}
