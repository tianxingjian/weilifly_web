package com.weili.action.front;

import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.sf.json.JSONObject;

import com.shove.Convert;
import com.shove.web.util.JSONUtils;
import com.weili.constants.IConstants;
import com.weili.service.BrandAdvertiseService;
import com.weili.service.BrandService;
import com.weili.service.ConsumerService;
import com.weili.service.DevelopmentService;
import com.weili.service.DownloadService;
import com.weili.service.KydReportService;
import com.weili.service.NewspaperService;
import com.weili.service.WeiliDisplayService;

public class FrontDisplayAction extends BaseFrontAction {

	private static final long serialVersionUID = 1L;
	private BrandService brandService;
	private NewspaperService newspaperService;
	private WeiliDisplayService weiliDisplayService;
	private KydReportService kydReportService;
	private BrandAdvertiseService brandAdvertiseService;
	private DevelopmentService developmentService;
	private ConsumerService consumerService;
	
	private List<Map<String,Object>> brandList;
	public static Log log = LogFactory.getLog(FrontDisplayAction.class);
	
	
	/**
	 *  前台查询展示内容父模块所有内容
	 * */
	public String queryWeiliDisplayes() throws Exception{
		//参数中获取内容父类型id
		Integer id = Convert.strToInt(request("id"), -1);
		
		paramMap = weiliDisplayService.queryDisplayTypeByTypeId(id);
		
//		log.info(paramMap);
		//通过父id查找子类型，再通过子类型查询内容
		List<Map<String, Object>> typeList = weiliDisplayService.queryDisplayIndex(id);
		
		StringBuffer type = new StringBuffer();
		for(Map<String,Object> map:typeList){
			type.append(map.get("id")+",");
		}
		type.deleteCharAt(type.length()-1);
		
		//设置页面显示列表
		pageBean.setPageSize(15);
		int pageNum = Convert.strToInt(request("curPage"), 1);
		pageBean.setPageNum(pageNum);
		
		//通过子类型查询内容,点击more+时候显示
		 weiliDisplayService.queryDisplayByStringId(pageBean,type);
		
		//more之后显示的第一个推荐的内容
		StringBuffer condition = new StringBuffer();
		condition.append(" 1=1 and typeId in ("+type+") and isIndex = 1 ");
		Map<String, String> singleRecommendMap = weiliDisplayService.queryDisplayRecommendById(condition);
		request().setAttribute("singleRecommendMap", singleRecommendMap);
		
		return SUCCESS;
	}

	
	/**
	 * 前台查询展示内容子模块详情
	 * */
	public String queryWeiliDisplay() throws Exception{
		//参数中获取内容类型id
		Integer id = Convert.strToInt(request("typeId"), -1);
		
		//通过typeId获取该类型的信息<层级名称>
		paramMap = weiliDisplayService.queryDisplayTypeByTypeId(id);
		//查找父类信息(上一级)
		Map<String,String> parentMap = weiliDisplayService.queryDisplayTypeByTypeId(Convert.strToInt(paramMap.get("parentId"), -1));
		request("parentMap",parentMap);
		
		
		//weiliDisplayService.queryWeiliDisplayPageFront(pageBean, IConstants.STATUS_ON);
		pageBean.setPageSize(15);
		int pageNum = Convert.strToInt(request("curPage"), 1);
		pageBean.setPageNum(pageNum);
		
		//分页查询typeId的内容
		weiliDisplayService.queryWeiliDisplayPageFront(pageBean, IConstants.STATUS_ON,id);
		
		//根据typeId查询推荐的内容
		Map<String,String> newMap = weiliDisplayService.queryRecommendedDisplayByTypeId(IConstants.RECOMMEND_ON,id);
		request("newMap",newMap);
		
		return SUCCESS;
	}
	
	
	/**
	 * 前台展示内容子模块内容详情
	 * */
	public String weiliDisplayDetail() throws Exception{
		
		//weiliDisplayDetail.do?id=${singleRecommendMap.id }&typeId=${paramMap.id}
		
		Integer typeId = Convert.strToInt(request("typeId"),-1);
		//通过typeId获取该类型的信息
		paramMap = weiliDisplayService.queryDisplayTypeByTypeId(typeId);
		
		//查找父类信息(上一级)
		Map<String,String> parentMap = weiliDisplayService.queryDisplayTypeByTypeId(Convert.strToInt(paramMap.get("parentId"), -1));
		request("parentMap",parentMap);
		
		
		Long id = Convert.strToLong(request("id"), -1);
		weiliDisplayService.updateDisplay(id);//增加浏览数
		
		Map<String,String> displayDetail = weiliDisplayService.queryDisplayById(id);
		
		
		Map<String,String> newMap = weiliDisplayService.queryRecommendedDisplay(IConstants.RECOMMEND_ON);
		request("newMap",newMap);
		
//		paramMap = brandService.queryBrandById(IConstants.BRAND_ID_NEWS);
		
		Map<String,String> nextMap = weiliDisplayService.queryWeiliResearchesNextId(id,typeId);
		
		//内容详情
		request("displayDetail",displayDetail);
		
		//
		request("nextMap",nextMap);
		
		return SUCCESS;
	}
	
	
	
	/**
	 * 最新动态二级目录列表
	 * */
	public String queryNewest() throws Exception{
		
		//推荐查询
		Map<String,String> NewestMap = weiliDisplayService.queryRecommendedNewest(IConstants.RECOMMEND_ON);
		request("NewestMap",NewestMap);
		
		
		//详细列表查询
		pageBean.setPageSize(15);
		int pageNum = Convert.strToInt(request("curPage"), 1);
		pageBean.setPageNum(pageNum);
		
		this.weiliDisplayService.queryNewest(this.pageBean);
		
		return SUCCESS;
	}
	
	/**
	 * 最新动态三级目录内容详情
	 * */
	public String NewestDetail() throws Exception{
		
		Long id = Convert.strToLong(request("id"), -1);
		weiliDisplayService.updateNewest(id);//增加浏览数
		
		Map<String,String> displayDetail = weiliDisplayService.queryNewest(id);
		
		request("displayDetail",displayDetail);
		return SUCCESS;
	}
	
	public String brandDetail() throws Exception{
		List<Map<String,Object>> bList = getBrandList();
		Long bId = (Long) bList.get(0).get("id");
		Long id = Convert.strToLong(request("id"), bId);
		
		paramMap = brandService.queryBrandById(id);
		
		Integer type = Convert.strToInt(paramMap.get("type"), -1);//////
		Integer isLevel = Convert.strToInt(paramMap.get("isLevel"), -1);//////
		Long parentId = Convert.strToLong(paramMap.get("parentId"), -1);
		if(type == -1&&isLevel==IConstants.ISLEVEL_OFF&&parentId==-1){//品牌理念
			return "idea";
		}
		if(type == -1&&isLevel==IConstants.ISLEVEL_ON&&parentId==-1){//品牌文化
			List<Map<String,Object>> list = brandService.queryBrandAll("*", "1=1 and `status` = 1 and parentId = "+IConstants.BRAND_ID_CULTURE, "sortIndex asc");
			Long bandId = (Long) list.get(0).get("id");
			paramMap = brandService.queryBrandById(bandId);
			Integer mType = Convert.strToInt(paramMap.get("type"), -1);
			if(mType == 4){//华普报
				pageBean.setPageSize(12);
				int pageNum = Convert.strToInt(request("curPage"), 1);
				pageBean.setPageNum(pageNum);
				newspaperService.queryNewspaperPageFront(pageBean, IConstants.STATUS_ON);
				request("list",list);
				return "culture";
			}else if(mType == -1){//品牌文化二级详情
				request("list",list);
				return "childDetail";
			}else if(mType == 5){//微力科技报道
				List<Map<String,Object>> reportList = kydReportService.queryKydReportAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " addTime desc");
				request("list",list);
				request("reportList",reportList);
				return "report";
			}
		}
		if(type == IConstants.BRAND_TYPE_NEWS&&isLevel == IConstants.ISLEVEL_OFF&&parentId==-1){//品牌资讯
			pageBean.setPageSize(12);
			int pageNum = Convert.strToInt(request("curPage"), 1);
			pageBean.setPageNum(pageNum);
			weiliDisplayService.queryWeiliDisplayPageFront(pageBean, IConstants.STATUS_ON,-1);
			Map<String,String> newMap = weiliDisplayService.queryRecommendedDisplay(IConstants.RECOMMEND_ON);
			String regEx_html = "<[^>]+>";
			String content = newMap.get("content");
			Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
	        Matcher m_html = p_html.matcher(content);
	        content = m_html.replaceAll(""); // 过滤html标签
	        newMap.put("content", content);
			request("newMap",newMap);
			return "news";
		}
		if(id == IConstants.BRAND_ID_NEWSPAPER){//华普报
			List<Map<String,Object>> list = brandService.queryBrandAll("*", "1=1 and `status` = 1 and parentId = "+IConstants.BRAND_ID_CULTURE, "sortIndex asc");
			pageBean.setPageSize(12);
			int pageNum = Convert.strToInt(request("curPage"), 1);
			pageBean.setPageNum(pageNum);
			newspaperService.queryNewspaperPageFront(pageBean, IConstants.STATUS_ON);

			request("list",list);
			return "culture";
		}
		if(id == IConstants.BRAND_ID_REPORT){//微力科技报道
			List<Map<String,Object>> reportList = kydReportService.queryKydReportAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " addTime desc");
			List<Map<String,Object>> list = brandService.queryBrandAll("*", "1=1 and `status` = 1 and parentId = "+IConstants.BRAND_ID_CULTURE, "sortIndex asc");
			
			request("list",list);
			request("reportList",reportList);
			return "report";
		}
		if(id == IConstants.BRAND_ID_ADVERTISE){//品牌广告
			List<Map<String,Object>> advertiseList = brandAdvertiseService.queryBrandAdvertiseAll("*", "1=1 and `status` = "+IConstants.STATUS_ON, " addTime desc");
//			List<Map<String,Object>> list = brandService.queryBrandAll("*", "1=1 and `status` = 1 and parentId = "+IConstants.BRAND_ID_CULTURE, "sortIndex asc");
			
//			request("list",list);
			request("advertiseList",advertiseList);
			return "advertise";
		}
		if(type == -1&&isLevel==IConstants.ISLEVEL_OFF&&parentId==IConstants.BRAND_ID_CULTURE){//品牌文化二级详情
			List<Map<String,Object>> list = brandService.queryBrandAll("*", "1=1 and `status` = 1 and parentId = "+IConstants.BRAND_ID_CULTURE, "sortIndex asc");
			
			request("list",list);
			return "childDetail";
		}
		
		if(type == IConstants.BRAND_TYPE_TIME&&isLevel==IConstants.ISLEVEL_OFF&&parentId==-1){//发展历程
			List<Map<String,Object>> developmentList = developmentService.queryDevelopmentAll("*", "1=1 and status = "+IConstants.STATUS_ON, "sortIndex asc");
			
			request("developmentList",developmentList);
			return "development";
		}
		
		return "idea";
	}
	
	
	public String kydReport() throws Exception{
		JSONObject obj = new JSONObject();
		Long id = Convert.strToLong(request("id"), -1);
		
		kydReportService.addReportViews(id);//增加浏览数
		
		obj.putAll(kydReportService.queryKydReportById(id));
		
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String brandAdvertise() throws Exception{
		JSONObject obj = new JSONObject();
		Long id = Convert.strToLong(request("id"), -1);
		
		brandAdvertiseService.addAdvertiseViews(id);//增加浏览数
		
		obj.putAll(brandAdvertiseService.queryBrandAdvertiseById(id));
		
		JSONUtils.printObject(obj);
		
		return null;
	}
	
	public String sendToUsInit(){
		return SUCCESS;
	}
	
	/*
	 * sendToUs
	 * */
	public String sendToUs() throws Exception{
		String cName = paramMap.get("cName");
		String cTelephone = paramMap.get("cTelephone");
		String address = paramMap.get("address");
		String needContent = paramMap.get("needContent");
		int needId = Convert.strToInt(paramMap.get("needId"),-1);
		
		JSONObject obj = new JSONObject();
		obj.putAll(consumerService.addConsumers(cName,cTelephone,address,needContent,needId));		
		JSONUtils.printObject(obj);
		return null;
	}

	public void setBrandService(BrandService brandService) {
		this.brandService = brandService;
	}

	
	
	public void setConsumerService(ConsumerService consumerService) {
		this.consumerService = consumerService;
	}

	public void setNewspaperService(NewspaperService newspaperService) {
		this.newspaperService = newspaperService;
	}


	public void setWeiliDisplayService(WeiliDisplayService weiliDisplayService) {
		this.weiliDisplayService = weiliDisplayService;
	}

	public void setKydReportService(KydReportService kydReportService) {
		this.kydReportService = kydReportService;
	}

	public void setBrandAdvertiseService(BrandAdvertiseService brandAdvertiseService) {
		this.brandAdvertiseService = brandAdvertiseService;
	}

	public void setDevelopmentService(DevelopmentService developmentService) {
		this.developmentService = developmentService;
	}

	public List<Map<String, Object>> getBrandList() throws Exception {
		if(brandList == null){
			brandList = brandService.queryBrandAll("*", "1=1 and `status` = 1 and parentId = -1", "sortIndex asc");
		}
		return brandList;
	}
	
}
