package com.weili.action.front;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.shove.Convert;
import com.weili.service.AdvertisementService;
import com.weili.service.BrandService;
import com.weili.service.DownloadHelpService;
import com.weili.service.InfoContentService;
import com.weili.service.KydReportService;
import com.weili.service.NewspaperService;
import com.weili.service.ProductCategoryService;
import com.weili.service.QuestionService;
import com.weili.service.RecruitService;
import com.weili.service.DownloadService;
import com.weili.service.WebDistributeService;
import com.weili.service.WeiliDisplayService;

public class SearchAction extends BaseFrontAction {
	private WeiliDisplayService WeiliResearchesService;  //品牌资讯
	private QuestionService questionService; //常见问题
	private BrandService brandService;  //品牌
	private ProductCategoryService productCategoryService;  //产品类型
	private DownloadHelpService downloadHelpService; //下载帮助
	private DownloadService downloadService;  //升级程序
	private AdvertisementService advertisementService; //广告片
	private WebDistributeService webDistributeService;  //网点分布
	private NewspaperService newspaperService; //华普报
	private KydReportService kydReportService; //微力科技报道
	private RecruitService recruitService; //人才招聘
	
	public String querySearch() throws Exception {
		Map<String,String> seoMap = getSeoMap("querySearch.do");//seo
		request("seoMap",seoMap);
		String keyWords= paramMap.get("keyWord");
		paramMap.put("keyWord", paramMap.get("keyWord")) ;
		if(StringUtils.isNotBlank(keyWords)){
			keyWords  = URLDecoder.decode(keyWords, "utf-8");
			
			List<Map<String, Object>> questionList=questionService.queryQuestionList(keyWords);//常见问题
			List<Map<String, Object>> bnList=WeiliResearchesService.queryWeiliResearchList(keyWords); //品牌资讯
			List<Map<String, Object>> brandList=brandService.queryBrandList(keyWords); //品牌
			List<Map<String, Object>> productCategoryList=productCategoryService.queryProductCategoryList(keyWords);  //产品类型
			List<Map<String, Object>> downHelpList=downloadHelpService.queryDownloadHelpList(keyWords);  //下载帮助
			List<Map<String, Object>> coursewareList=downloadService.queryCoursewareList(keyWords);  //升级程序
			List<Map<String, Object>> advertiseList=advertisementService.queryAdvertisementerList(keyWords);//广告片
			List<Map<String, Object>> webDistributeList=webDistributeService.queryWebDistributeList(keyWords);  //网点分布
			List<Map<String, Object>> newspaperList=newspaperService.queryNewspaperList(keyWords);  //华普报
			List<Map<String, Object>> kydReportList=kydReportService.queryKydReportList(keyWords); //微力科技报道
			List<Map<String, Object>> recruitList=recruitService.queryRecruitList(keyWords); //人才招聘
			List<Map<String, Object>> infoContentList=getInfoContentService().queryInfoContentList(keyWords);  //底部信息
			
			List<Map<String,String>> allResultList = new ArrayList<Map<String,String>>();
			List<Map<String,String>> returnList = new ArrayList<Map<String,String>>();
			long totalNum =  0;
			//品牌
			if(brandList!=null&&brandList.size()>0){
				for (Map<String,Object> map: brandList) {
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("name")+"");
					rMap.put("url", "brandDetail.do?id="+map.get("id"));
					allResultList.add(rMap);
				}
			}
			//品牌资讯
			if(bnList!=null&&bnList.size()>0){
				for(Map<String,Object> map: bnList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("title")+"");
					rMap.put("url", "weiliDisplayDetail.do?id="+map.get("id"));
					allResultList.add(rMap);
				}
			}
			
			//华普报
			if (newspaperList!=null&&newspaperList.size()>0) {
				for(Map<String,Object> map: newspaperList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("name")+"");
					rMap.put("url", "brandDetail.do?id=2");
					allResultList.add(rMap);
				}
			}
			//微力科技报道
			if (kydReportList!=null&&kydReportList.size()>0) {
				for(Map<String,Object> map: kydReportList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("title")+"");
					rMap.put("url", "brandDetail.do?id=7");
					allResultList.add(rMap);
				}
			}
			//产品类型
			if (productCategoryList!=null&&productCategoryList.size()>0) {
				for(Map<String,Object> map: productCategoryList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("name")+"");
					rMap.put("url", "productIndex.do?id="+map.get("id"));
					allResultList.add(rMap);
				}
			}
			//下载帮助
			if(downHelpList!=null&&downHelpList.size()>0){
				for(Map<String,Object> map: downHelpList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("title")+"");
					rMap.put("url", "queryDownloadHelpInit.do?id="+map.get("id"));
					allResultList.add(rMap);
				}
			}
			//升级程序
			if(coursewareList!=null&&coursewareList.size()>0){
				for(Map<String,Object> map: coursewareList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("name")+"");
					rMap.put("url", "preDownloadIndex.do?a="+map.get("categoryId"));
					allResultList.add(rMap);
				}
			}
			//广告片
			if (advertiseList!=null&&advertiseList.size()>0) {
				for(Map<String,Object> map: advertiseList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("name")+"");
					rMap.put("url", "advertiseIndex.do");
					allResultList.add(rMap);
				}
			}
			//网点分布
			if (webDistributeList!=null&&webDistributeList.size()>0) {
				for(Map<String,Object> map: webDistributeList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("storeName")+"");
					rMap.put("url", "queryWebDistributeListInit.do");
					allResultList.add(rMap);
				}
			}
			//常见问题
			if(questionList!=null&&questionList.size()>0){
				for(Map<String,Object> map: questionList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("name")+"");
					rMap.put("url", "queryQuestionListInit.do");
					allResultList.add(rMap);
				}
			}
			//人才招聘
			if (recruitList!=null&&recruitList.size()>0) {
				for(Map<String,Object> map: recruitList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("name")+"");
					rMap.put("url", "queryRecruitInit.do?a=2a");
					allResultList.add(rMap);
				}
			}
			//底部信息
			if (infoContentList!=null&&infoContentList.size()>0) {
				for(Map<String,Object> map: infoContentList){
					totalNum ++ ;
					Map<String,String> rMap = new HashMap<String, String>();
					rMap.put("title", map.get("title")+"");
					rMap.put("url", "queryInfoContent.do?id="+map.get("id")+"&a="+map.get("infoId")+"");
					allResultList.add(rMap);
				}
			}
			long pageNum = 1 ;
			if(request("curPage")!=null){
				pageNum  =  Convert.strToLong(request("curPage"), 1) ;
			}
			pageBean.setTotalNum(totalNum);
			int pageSize = 10;
			pageBean.setPageSize(pageSize);
			if(totalNum<=pageSize){
				pageBean.setPage(allResultList);
			}else{
				for(long i =  (pageNum-1)*pageSize  ;i<pageNum*pageSize;i++){
					int  index = Convert.strToInt(i+"", -1);
					if(index<0){
						pageBean.setPage(returnList);
						return SUCCESS;
					}
					if(i+1>totalNum){
						pageBean.setPage(returnList);
						return SUCCESS;
					}
					returnList.add(allResultList.get(index));
				}
				pageBean.setPage(returnList);
			}
		}
		return SUCCESS;
	}

	public void setWeiliResearchesService(WeiliDisplayService WeiliResearchesService) {
		this.WeiliResearchesService = WeiliResearchesService;
	}

	public void setQuestionService(QuestionService questionService) {
		this.questionService = questionService;
	}

	public void setBrandService(BrandService brandService) {
		this.brandService = brandService;
	}

	public void setProductCategoryService(
			ProductCategoryService productCategoryService) {
		this.productCategoryService = productCategoryService;
	}

	public void setDownloadHelpService(DownloadHelpService downloadHelpService) {
		this.downloadHelpService = downloadHelpService;
	}

	public void setDownloadService(DownloadService downloadService) {
		this.downloadService = downloadService;
	}

	public void setAdvertisementService(AdvertisementService advertisementService) {
		this.advertisementService = advertisementService;
	}

	public void setWebDistributeService(WebDistributeService webDistributeService) {
		this.webDistributeService = webDistributeService;
	}

	public void setNewspaperService(NewspaperService newspaperService) {
		this.newspaperService = newspaperService;
	}

	public void setKydReportService(KydReportService kydReportService) {
		this.kydReportService = kydReportService;
	}

	public void setRecruitService(RecruitService recruitService) {
		this.recruitService = recruitService;
	}

	
}
