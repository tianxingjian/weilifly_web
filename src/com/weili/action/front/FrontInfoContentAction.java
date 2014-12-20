package com.weili.action.front;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import com.shove.Convert;

public class FrontInfoContentAction extends BaseFrontAction {

	private List<Map<String, Object>> infoLists;
	private List<Map<String, Object>> lists;
		

	public List<Map<String, Object>> getInfoLists() throws Exception {
		if(infoLists == null){
			StringBuffer condition = new StringBuffer();
			condition.append(" 1=1 ");
			try {
				infoLists =getInfoService().queryInfoAll("id,name", condition.toString(), "id");
				System.out.println(infoLists);
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}		
		return infoLists;
	}

	
	public List<Map<String, Object>> getLists() throws Exception{
		if(lists==null){
			StringBuffer condition = new StringBuffer();
			condition.append(" 1=1 ");
			try {
				lists =getInfoContentService().queryInfoContentAll("*", condition.toString(), "sortIndex ASC");
			} catch (Exception e) {
				
				e.printStackTrace();
				throw e;
			}			
		}
		return lists;
	}


	
	
	/**
	 * 通过id得到内容
	 * @return
	 * @throws Exception
	 */
	public String queryInfoContent() throws Exception {
		Long id=Convert.strToLong(request("id"), -1);
		paramMap=getInfoContentService().queryInfoContentViewById(id);
		HttpServletRequest request=ServletActionContext.getRequest();
        String a=request.getParameter("a");
        request("a",a);
        Map<String,String> seoMap = getSeoMap("queryInfoContent.do");//seo
		request("seoMap",seoMap);
		return SUCCESS;
	}


	
}
