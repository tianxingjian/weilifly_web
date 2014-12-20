package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.InfoService;

public class InfoAction extends BasePageAction<Map<String, Object>> {

		private InfoService infoService;
		
		
		/**
		 * 添加底部信息初始化
		 * @return
		 */
		public String addInfoInit() {
			return SUCCESS;
		}
		
		
		public String addInfo() throws Exception {
			String name=paramMap.get("name");
			int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
			int status=Convert.strToInt(paramMap.get("status"), -1);
			
			Long result=infoService.addInfo(name, sortIndex, status);
			
			if(result<0){
				this.addFieldError("errorMessage","添加失败");
				return INPUT;
			}
			return SUCCESS;
		}
		
		
		/**
		 * 修改底部信息初始化
		 * @return
		 * @throws Exception
		 */
		public String updateInfoInit() throws Exception {
			Long id=Convert.strToLong(request("id"), -1);
			paramMap=infoService.queryInfoById(id);
			return SUCCESS;			
		}
	
		
		public String updateInfo() throws Exception {
			Long id=Convert.strToLong(paramMap.get("id"), -1);
			String name=paramMap.get("name");
			int sortIndex=Convert.strToInt(paramMap.get("sortIndex"), -1);
			int status=Convert.strToInt(paramMap.get("status"), -1);
			
			Long result=infoService.updateInfo(id, name,sortIndex, status);
			
			if(result<0){
				this.addFieldError("errorMessage","修改失败");
				return INPUT;
			}
			return SUCCESS;
		}
		
		
		
		/**
		 * 底部信息初始化
		 * @return
		 */
		public String queryInfoInit() {
		return SUCCESS;
		}
		
		
		public String queryInfo() throws Exception {
			StringBuffer condition=new StringBuffer();
			condition.append(" 1=1");
			List<Map<String,Object>> list = infoService.queryInfoAll("*", condition.toString(), "id desc");
			request().setAttribute("list",list);
			return SUCCESS;		
		}
		
		
		
		/**
		 * 删除底部信息
		 * @return
		 * @throws Exception 
		 */
		public String deleteInfo() throws Exception {
			String ids=request("id");
			Long result=infoService.deleteInfo(ids);
			if(result<0){
				this.addFieldError("errorMessage","删除失败");
				return INPUT;
			}
			return SUCCESS;
		}


		public void setInfoService(InfoService infoService) {
			this.infoService = infoService;
		}
				
}
