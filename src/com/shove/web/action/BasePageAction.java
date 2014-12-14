package com.shove.web.action;

import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.shove.vo.PageBean;


/**
 * @author 杨程
 * @date:Oct 15, 2010 8:32:16 AM
 * @category
 * @version :
 */
public class BasePageAction<T> extends BaseAction {

	private static final long serialVersionUID = 1L;
	private static final Pattern regex = Pattern.compile("^([1-9]{1}[0-9]{0,})$");//验证每页显示的条数
	@SuppressWarnings("unchecked")
	public PageBean<T> pageBean;//存放分页信息
	
	public BasePageAction() {		
		this.pageBean = new PageBean<T>(10);
	}

	public PageBean<T> getPageBean() {
		String curPage = request().getParameter("curPage");//当前页
		String pageSize = request().getParameter("pageSize");//每页的条数
		if(StringUtils.isNotBlank(curPage)){
			pageBean.setPageNum(curPage);
		}
		
		if(StringUtils.isNotBlank(pageSize) && regex.matcher(pageSize).matches()){
			pageBean.setPageSize(Integer.parseInt(pageSize));
		}
		return pageBean;
	}

	public void setPageBean(PageBean<T> pageBean) {
		this.pageBean = pageBean;
	}
}
