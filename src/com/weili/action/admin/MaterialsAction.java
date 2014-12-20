package com.weili.action.admin;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.shove.Convert;
import com.shove.util.ExcelUtils;
import com.shove.util.StringCommon;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.constants.IConstants;
import com.weili.entity.Admin;
import com.weili.service.AttributeService;
import com.weili.service.MaterialsService;
import com.weili.service.ProductService;

public class MaterialsAction extends BasePageAction {
	
	private Log log = LogFactory.getLog(MaterialsAction.class);

	private MaterialsService materialsService;
	private ProductService productService;
	private AttributeService attributeService;
	
	private List<Map<String,Object>> productList;
	private List<Map<String,Object>> attributeList;
	private List<Map<String, Object>> attributeModuleList;
	
		
	
	
	/**
	 * 查询资料
	 * @return
	 */
	public String queryMaterialsInit(){
		return SUCCESS;
	}
	
	public String queryMaterialsInfo() throws Exception{
		String number = request("number");
		String name = request("name");
		Long productId = Convert.strToLong(request("productId"), -1);
		Long aId=Convert.strToLong(request("aId"), -1);	
		Integer status = Convert.strToInt(request("status"), -1);
		String startDate = request("startDate");
		String endDate = request("endDate");
			
		materialsService.queryMaterialsPage(pageBean, number, name, productId,aId,status, startDate, endDate);
		
		return SUCCESS;
	}
	
	/**
	 * 添加资料
	 * @return
	 */
	public String addMaterialsInit(){
		return SUCCESS;
	}
	
	public String addMaterials() throws Exception{
		String number = request("number");
		String name = request("name");
//		Long productId = Convert.strToLong(request("productId"), -1);
//		String productIds = request("productIds");
		Integer status = Convert.strToInt(request("status"), -1);
		String path = request("path");
		String size = request("size");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String attributeIds = request("attributeIds");
		
		JSONObject obj = new JSONObject();
		
		obj.putAll(materialsService.addMaterials(name, number, null, path, size, sortIndex, status, seoTitle, seoKeywords, seoDescription, attributeIds));
		
		JSONUtils.printObject(obj);
		
		return null;
	}

	/**
	 * 修改资料
	 * @return
	 * @throws Exception 
	 */
	public String updateMaterialsInit() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		paramMap = materialsService.queryMaterialsById(id);
		List<Map<String,Object>>checkList = materialsService.queryMaterById(id);
		String fieldList = "*";
		String order = "sortIndex asc";
		StringBuffer condition = new StringBuffer();
		condition.append(" 1 = 1");
		condition.append(" and status = "+IConstants.STATUS_ON);
		List<Map<String,Object>> reattrList  =  null ; 
		reattrList = attributeService.queryAttributeAll(fieldList, condition.toString(), order);
		if(reattrList!=null&&reattrList.size()>0){
			List<Map<String,Object>> attrList  =  new ArrayList<Map<String,Object>>() ; 
			for(Map<String,Object> map : reattrList){
				Map<String,Object> attrMap  = map  ;
				Long attId = (Long)map.get("id") ;
				Long parId = (Long)map.get("parentId") ;
				boolean bool = false ;
				for(Map<String,Object> reMap:checkList){
					Long attrId = (Long)reMap.get("attributeId") ;
					Long parentId = (Long)reMap.get("parentId") ;
					if(parId==parentId&&attrId==attId){
						bool  = true ;
						break ;
					}
				}
				attrMap.put("check", bool?1:2) ;
				attrList.add(attrMap) ; 
			}
			request("attrList",attrList);
		}
		
		return SUCCESS;
	}
	
	public String updateMaterials() throws Exception{
		long id = Convert.strToLong(request("id"), -1);
		String number = request("number");
		String name = request("name");
//		Long productId = Convert.strToLong(request("productId"), -1);
		Integer status = Convert.strToInt(request("status"), -1);
		String path = request("path");
		String size = request("size");
		String seoTitle = request("seoTitle");
		String seoKeywords = request("seoKeywords");
		String seoDescription = request("seoDescription");
		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		String attributeIds = request("attributeIds");
		JSONObject obj = new JSONObject();
		
		obj.putAll(materialsService.updateMaterials(id,name, number, null, path, size, sortIndex, status, seoTitle, seoKeywords, seoDescription,attributeIds));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String deleteMaterials() throws Exception{
		JSONObject obj = new JSONObject();
		
		String ids = request("id");
		
		String msg = "删除失败！";
		
		try {
			int rid = StringCommon.checkIds(ids);
			if(rid<=0){
				return null;
			}
		
			long returnId = materialsService.deleteMaterials(ids);
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

	public void setMaterialsService(MaterialsService materialsService) {
		this.materialsService = materialsService;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public void setAttributeService(AttributeService attributeService) {
		this.attributeService = attributeService;
	}

	public List<Map<String, Object>> getProductList() throws Exception {
		if(productList == null){
			productList = productService.queryProductAll("*", "1=1", "");
		}
		return productList;
	}

	public List<Map<String, Object>> getAttributeList() throws Exception {
		if(attributeList == null){
			String fieldList = "*";
			String order = "sortIndex asc";
			StringBuffer condition = new StringBuffer();
			
			condition.append(" 1 = 1");
			
			condition.append(" and status = "+IConstants.STATUS_ON);
			
			attributeList = attributeService.queryAttributeAll(fieldList, condition.toString(), order);
		}
		return attributeList;
	}
   
	public List<Map<String, Object>> getAttributeModuleList() throws Exception {
		if(attributeModuleList==null){
			String fieldList = "*";
			String order = "sortIndex asc";
			StringBuffer condition = new StringBuffer();
			
			condition.append(" 1 = 1");
			
			condition.append(" and parentId = "+ IConstants.ATTRIBUTE_ID_MODULE);
			
			attributeModuleList = attributeService.queryAttributeAll(fieldList, condition.toString(), order);
		}
		return attributeModuleList;
	}
	
	
	
	/** 
	* 批量导入资料
	* @return 
	* @throws Exception 
	*/ 
	public String importProductBatchInit(){
		return SUCCESS;
	}
	public String importProductBatch() throws Exception{ 
		JSONObject object = new JSONObject(); 
		String number = paramMap.get("number");
		 Long productId = Convert.strToLong(paramMap.get("productId"), -1l);
		String attributeIds = paramMap.get("attributeIds");
		String size = paramMap.get("size");
		Integer sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		Integer status = Convert.strToInt(paramMap.get("status"), -1);
		String seoTitle = paramMap.get("seoTitle");
		String seoKeywords = paramMap.get("seoKeywords");
		String seoDescription = paramMap.get("seoDescription");
		String path = paramMap.get("path"); 
		if(StringUtils.isBlank(path)){ 
			object.put("msg", "请选择导入商品数据excel文件"); 
			JSONUtils.printObject(object); 
			return null; 
		} 
		String paths = ServletActionContext.getServletContext().getRealPath("/") + path; 
		File file = new File(paths);// 取得文件名。 
		//忽略第一行
		String[][] result = ExcelUtils.getData(file, 1); 
		Admin admin=(Admin)session().getAttribute(IConstants.SESSION_ADMIN);
		Long adminid = admin.getId() ;
		Map<String,Object> reMap = materialsService.importProductBatch(result,adminid,number,productId,
				size,sortIndex,
				status,seoTitle,seoKeywords,seoDescription,attributeIds); 
		if(reMap==null||reMap.get("returnId")==null){
			  object.put("flag", "-1"); 
			  object.put("msg", "添加失败！"); 
			  JSONUtils.printObject(object); 
			  return null; 
		}
		long returnId = Convert.strToLong(reMap.get("returnId") +"", -1) ;
		if(returnId>0){
			  object.put("flag", "1"); 
			  object.put("msg", "添加成功！"); 
			  JSONUtils.printObject(object); 
			  return null;  
		}else{
			  object.put("flag", "-1"); 
			  object.put("msg", "添加失败！"); 
			  JSONUtils.printObject(object); 
			  return null; 
		}
		
	}

	public void setAttributeModuleList(List<Map<String, Object>> attributeModuleList) {
		this.attributeModuleList = attributeModuleList;
	}

	
}
