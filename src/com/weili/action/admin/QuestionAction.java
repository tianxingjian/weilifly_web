package com.weili.action.admin;

import java.util.Map;
import com.shove.Convert;
import com.shove.web.action.BasePageAction;
import com.weili.service.QuestionService;

public class QuestionAction extends BasePageAction<Map<String, Object>> {

	private QuestionService questionService; // 常见问题

	/**
	 * 添加初始化
	 * 
	 * @return
	 */
	public String addQuestionInit() {
		return SUCCESS;
	}

	/**
	 * 添加常见问题
	 * 
	 * @return
	 * @throws Exception
	 */
	public String addQuestion() throws Exception {
		String name = paramMap.get("name");
		String solution = paramMap.get("solution");
		String addTime = paramMap.get("addTime");
		Long sortIndex = Convert.strToLong(paramMap.get("sortIndex"), -1);
		Long status = Convert.strToLong(paramMap.get("status"), -1);

		long result = questionService.addQuestion(name, solution, sortIndex,
				status,addTime);
		if (result < 0) {
			this.addFieldError("errorMessage", "添加失败");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 修改常见问题初始化
	 * 
	 * @return
	 * @throws Exception
	 */
	public String updateQuestionInit() throws Exception {
		Long id = Convert.strToLong(request("id"), -1);
		paramMap = questionService.queryQuestionById(id);
		return SUCCESS;
	}

	/**
	 * 修改常见问题
	 * 
	 * @return
	 * @throws Exception
	 */
	public String updateQuestion() throws Exception {
		Long id = Convert.strToLong(paramMap.get("id"), -1);
		String name = paramMap.get("name");
		String solution = paramMap.get("solution");
		String addTime = paramMap.get("addTime");
		int sortIndex = Convert.strToInt(paramMap.get("sortIndex"), -1);
		int status=Convert.strToInt(paramMap.get("status"), -1);
		Long result = questionService.updateQuestion(id, name, solution,
				sortIndex,status,addTime);
		if (result < 0) {
			this.addFieldError("errorMessage", "修改失败");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 常见问题列表初始化
	 * 
	 * @return
	 */
	public String queryQuestionListInit() {
		return SUCCESS;
	}

	/**
	 * 常见问题列表
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryQuestionList() throws Exception {
		String name = request("name");
		Long status = Convert.strToLong(request("status"), -1);
		questionService.queryQuestionPage(name, status, pageBean);
		System.out.println(pageBean.pageNum);
		return SUCCESS;
	}

	/**
	 * 删除常见问题
	 * 
	 * @return
	 * @throws Exception
	 */
	public String deleteQuestion() throws Exception {
		String id = request("id");
		Long result = questionService.deleteQuestion(id);
		if (result < 0) {
			this.addFieldError("errorMessage", "删除失败");
			return INPUT;
		}
		return SUCCESS;
	}

	public void setQuestionService(QuestionService questionService) {
		this.questionService = questionService;
	}

}
