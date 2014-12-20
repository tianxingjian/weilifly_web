package com.weili.action.admin;

import java.util.Map;
import org.apache.commons.lang.StringUtils;
import net.sf.json.JSONObject;
import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.ImgListService;

public class ImgListAction  extends BasePageAction<Map<String, Object>> {
	
	private ImgListService imgListService;
	
	
	
	
	/**
	 * 添加图片列表初始化
	 * @return
	 */
	public String addImgListInit() {
		return SUCCESS;
	}
	
	public String addImgList() throws Exception {
		int tid=Convert.strToInt(request("tid"), -1);
		String imgUrl=request("imgUrl");
		String downUrl=request("downUrl");
		int status=Convert.strToInt(request("status"), -1);
		int sortIndex=Convert.strToInt(request("sortIndex"), -1);
		
		JSONObject obj = new JSONObject();
		obj.putAll(imgListService.addImgList(tid, imgUrl, downUrl, status, sortIndex));
		JSONUtils.printObject(obj);
		return null;
	}

	
	/**
	 * 修改图片列表初始化
	 * @return
	 * @throws Exception 
	 */
	public String updateImgListInit() throws Exception {
		Long id=Convert.strToLong(request("id"), -1) ;
		paramMap=imgListService.queryImgListById(id);
		return SUCCESS;
	}
	
	
	
	public String updateImgList() throws Exception {
		Long id=Convert.strToLong(request("id"), -1) ;
		int tid=Convert.strToInt(request("tid"), -1) ;
		String imgUrl=request("imgUrl");
		String downUrl=request("downUrl");
		int status=Convert.strToInt(request("status"), -1);
		int sortIndex=Convert.strToInt(request("sortIndex"), -1);
		JSONObject obj=new JSONObject();
		obj.putAll(imgListService.updateImgList(id, tid, imgUrl, downUrl, status, sortIndex));
		JSONUtils.printObject(obj);
		return null;
	}
	
	
	
	/**
	 * 图片列表
	 * @return
	 */
	public String queryImgListInit() {
		return SUCCESS;
	}
	
	
	public String queryImgList() throws Exception {
		String title=request("title");
		int status=Convert.strToInt(request("status"), -1);
		StringBuffer condition=new StringBuffer();
		if(StringUtils.isNotBlank(title)){
			condition.append(" and title="+title);
		}
		if(status>0){
			condition.append(" and status="+status);
		}
		imgListService.queryImgListPage(pageBean, "*", condition, "order by id desc", "v_t_img_design");
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}
	
	
	/**
	 * 删除
	 * @return
	 * @throws Exception
	 */
	public String deleteImgList() throws Exception {
		String ids=request("id");
		Long result=imgListService.deleteImgList(ids);
		if(result<0){
			this.addFieldError("errorMessage","删除失败");
			return INPUT;
		}
		return SUCCESS;
	}

	
	public void setImgListService(ImgListService imgListService) {
		this.imgListService = imgListService;
	}

	
	
}
