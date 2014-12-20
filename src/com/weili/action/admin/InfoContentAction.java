package com.weili.action.admin;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;

import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.shove.web.util.JSONUtils;
import com.weili.service.InfoContentService;
import com.weili.service.InfoService;

public class InfoContentAction extends BasePageAction<Map<String, Object>> {

	private InfoContentService infoContentService;
	private InfoService infoService;

	private List<Map<String, Object>> infoList;

	public List<Map<String, Object>> getInfoList() throws Exception {
		if (infoList != null) {
			return infoList;
		}
		StringBuffer condition = new StringBuffer();
		condition.append(" 1=1 ");
		try {
			infoList = infoService.queryInfoAll("id,name",
					condition.toString(), "id");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return infoList;
	}

	public void setInfoList(List<Map<String, Object>> infoList) {
		this.infoList = infoList;
	}

	/**
	 * 添加初始化
	 * 
	 * @return
	 */
	public String addInfoContentInit() {
		return SUCCESS;
	}

	public String addInfoContent() throws Exception {
		String title = request("title");
		int infoId = Convert.strToInt(request("infoId"), -1);
		String content = request("content");
		String linkPath = request("linkPath");
		String imgUrl=request("imgUrl");
		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		int status = Convert.strToInt(request("status"), -1);

		JSONObject obj = new JSONObject();

		obj.putAll(infoContentService.addInfoContent(title, infoId, content,
				linkPath,imgUrl, sortIndex, status));

		JSONUtils.printObject(obj);

		return null;
	}

	/**
	 * 修改初始化
	 * 
	 * @return
	 * @throws Exception
	 */
	public String updateInfoContentInit() throws Exception {
		Long id = Convert.strToLong(request("id"), -1);
		paramMap = infoContentService.queryInfoContentById(id);
		return SUCCESS;
	}

	public String updateInfoContent() throws Exception {
		Long id = Convert.strToLong(request("id"), -1);
		String title = request("title");
		int infoId = Convert.strToInt(request("infoId"), -1);
		String content = request("content");
		String linkPath = request("linkPath");
		String imgUrl=request("imgUrl");
		int sortIndex = Convert.strToInt(request("sortIndex"), -1);
		int status = Convert.strToInt(request("status"), -1);

		JSONObject obj = new JSONObject();

		obj.putAll(infoContentService.updateInfoContent(id, title, infoId,
				content, linkPath,imgUrl, sortIndex, status));

		JSONUtils.printObject(obj);

		return null;
	}

	/**
	 * 列表初始化
	 * 
	 * @return
	 */
	public String queryInfoContentInit() {
		return SUCCESS;
	}

	public String queryInfoContent() throws Exception {
		StringBuffer condition = new StringBuffer();
		String title = request("title");
		int infoId = Convert.strToInt(request("infoId"), -1);
		int status = Convert.strToInt(request("status"), -1);
		if (StringUtils.isNotBlank(title)) {
			condition.append(" AND title LIKE CONCAT('%','" + title + "','%')");
		}
		if (infoId > 0) {
			condition.append(" AND infoId=" + infoId);
		}
		if (status > 0) {
			condition.append(" AND status=" + status);
		}
		infoContentService.queryInfoContentPage(pageBean, "*", condition, "",
				"v_t_info_content");
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}

	/**
	 * 删除底部信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public String deleteInfoContent() throws Exception {
		String ids = request("id");
		Long result = infoContentService.deleteInfoContent(ids);
		if (result < 0) {
			this.addFieldError("errorMessage", "删除失败");
			return INPUT;
		}
		return SUCCESS;
	}

	public void setInfoContentService(InfoContentService infoContentService) {
		this.infoContentService = infoContentService;
	}

	public void setInfoService(InfoService infoService) {
		this.infoService = infoService;
	}

}
