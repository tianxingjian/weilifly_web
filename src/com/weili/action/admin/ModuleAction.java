package com.weili.action.admin;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.shove.Convert;
import com.shove.data.DataException;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.ModuleService;

public class ModuleAction extends BasePageAction{
	
	
	private static final long serialVersionUID = 1L;

	public static Log log = LogFactory.getLog(ModuleAction.class);
	private ModuleService moduleService;
	private List<Map<String, Object>> moduleList;
	private String pageNow;

	public String getPageNow() {
		return pageNow;
	}

	public void setPageNow(String pageNow) {
		this.pageNow = pageNow;
	}

	/**
	 * 查询模块初始化
	 * @return
	 */
	public String queryModuleInit(){
		return SUCCESS;
	}
	
	/**
	 * 查询模块信息 按照检索条件查询匹配数据
	 * @return
	 * @throws SQLException
	 * @throws DataException
	 */
	public String queryModuleInfo() throws SQLException, DataException{
		String summary  = paramMap.get("summary");//模块名称
		Integer isIntercept = Convert.strToInt(paramMap.get("isIntercept"),-1);//可分配 1：是  2:否
		pageBean.setPageSize(10);//10条记录一页
		moduleService.queryModulePage(summary, isIntercept, pageBean);
		return SUCCESS;
	}
	
	/**
	 * 添加模块初始化
	 * @return
	 */
	public String addModuleInit(){
		paramMap.put("isIntercept", 1+"");
		paramMap.put("isLog", 1+"");
		return SUCCESS;
	}
	
	/**
	 * 添加模块信息
	 * @return
	 * @throws SQLException
	 * @throws DataException 
	 */
	public String addModule() throws SQLException, DataException{		
		String summary = paramMap.get("summary");
		String action = paramMap.get("action");
		String description = paramMap.get("description");
		int isLog = Convert.strToInt(paramMap.get("isLog"), -1);//是否记录日志，1：是  2：否
		long parentId = Convert.strToLong(paramMap.get("parentId"),-1);
		int isIntercept = Convert.strToInt(paramMap.get("isIntercept"), -1);//可分配 1：是  2:否
		int isQuery=Convert.strToInt(paramMap.get("isQuery"), -1);//是否显示 1：是   2：否
		int indexs=Convert.strToInt(paramMap.get("indexs"), -1);//排序值
		Long result=moduleService.addModule(summary,action,parentId,isQuery,isIntercept,indexs,isLog,description);
		if(result<0){
			this.addFieldError("errorMessage","添加失败");
			return INPUT;
		}
		return SUCCESS;
	}
	
	/**
	 * 修改模块初始化
	 * @return
	 * @throws DataException 
	 * @throws SQLException 
	 */
	public String updateModuleInit() throws SQLException, DataException{
		Long id = Long.parseLong(request("id"));
		paramMap = moduleService.queryModuleById(id);
		int pageNow = Convert.strToInt(request("pageNow"), 1);
		paramMap.put("pageNow", pageNow+"");
		return SUCCESS;
	}
	
	/**
	 * 修改模块信息
	 * @return
	 * @throws SQLException 
	 */
	public String updateModule() throws Exception{
		Long id=Convert.strToLong(paramMap.get("id"), -1);
		String summary = paramMap.get("summary");
		String action = paramMap.get("action");
		String description = paramMap.get("description");
		int isLog = Convert.strToInt(paramMap.get("isLog"), -1);
		long parentId = Convert.strToLong(paramMap.get("parentId"),-1);
		int isIntercept = Convert.strToInt(paramMap.get("isIntercept"), -1);//可分配 1：是  2:否
		int isQuery=Convert.strToInt(paramMap.get("isQuery"), -1);//是否显示 1：是   2：否
		int indexs=Convert.strToInt(paramMap.get("indexs"), -1);//排序值
		
		JSONObject obj = new JSONObject();
		obj.putAll(moduleService.updateModule(id, summary,action,parentId,isQuery,isIntercept,indexs,isLog,description));		
		JSONUtils.printObject(obj);
		return null;
	}

	/**
	 * 删除模块信息 -- id
	 * @return
	 * @throws DataException
	 * @throws SQLException
	 */
	public String deleteModule() throws DataException, SQLException{
		String moduleIds = request("id");
		
		String[] moduleids = moduleIds.split(",");
		int length= moduleids.length;
		if(length<=0){
			return SUCCESS;
		}
		long[] ids = new long[length];
		for (int i = 0; i < moduleids.length; i++) {
			ids[i] = Convert.strToLong(moduleids[i], -1);
			if(ids[i]==-1){
				return SUCCESS;
			}
		}
		try {
			moduleService.deleteModule(moduleIds);
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
			throw e;
		}
		
		int pageNow = Convert.strToInt(request("pageNow"), 1);
		this.pageNow = pageNow+"";
		return SUCCESS;
	}
	
	public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	}

	public List<Map<String, Object>> getModuleList() throws SQLException, DataException {
		if(moduleList!=null){
			return moduleList;
		}
		moduleList = moduleService.queryModuleList();
		return moduleList;
	}
	
}