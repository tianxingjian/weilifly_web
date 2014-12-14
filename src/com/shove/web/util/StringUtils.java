package com.shove.web.util;

import java.util.regex.Pattern;




public class StringUtils {

	public static final String[] number = new String[]{"十", "一", "二", "三", "四", "五", "六", "七", "八", "九"};
	/**
	 * 数字转换成字母
	 * @param i
	 * @return
	 */
	public static String getChar(int i){
		return (char) (64 + i) + "";
	}
	
	
	
	/**
	 * 将此字符串转换为一个新的字符数组
	 * @param answer
	 * @return
	 */
	public static String[] strToArray(String answer){
		if(org.apache.commons.lang.StringUtils.isNotBlank(answer)){
			return answer.split("");
		}
		return null;
	}
	
	/**
	 * 返回栏目题号
	 * @return
	 */
	public static String getColumnNum(String num){
		char[] cr = num.toCharArray();
		int length = cr.length;
		int[] arr = new int[length];
		for(int i = 0; i < cr.length; i ++){
			arr[i] = Integer.parseInt(cr[i]+"");
		}
		StringBuffer strBuffer = new StringBuffer();
		switch (length) {
			case 1:
				strBuffer.append(number[arr[0]]);
				break;
			case 2:
				if("10".equals(num)){
					strBuffer.append(number[arr[1]]);
					break;
				}else if(arr[0] == 1){
					strBuffer.append(number[0]).append(number[arr[1]]);
					break;
				}else if(arr[1] == 0){
					strBuffer.append(number[arr[0]]).append(number[arr[1]]);
				}else{
					strBuffer.append(number[arr[0]]).append(number[0]).append(number[arr[1]]);
				}
				break;
			default:
				break;
		}
		return strBuffer.toString();
	}
	
	/**
	 * @Description:
	 * @Author Yang Cheng
	 * @Date: Feb 9, 2012 1:57:52 AM
	 * @param inputString
	 * @return
	 * @return String
	 */
	public static String html2Text(String inputString) {

		String htmlStr = inputString; // 含html标签的字符串
		String textStr = "";
		java.util.regex.Pattern p_script;
		java.util.regex.Matcher m_script;
		java.util.regex.Pattern p_style;
		java.util.regex.Matcher m_style;
		java.util.regex.Pattern p_html;
		java.util.regex.Matcher m_html;

		java.util.regex.Pattern p_html1;
		java.util.regex.Matcher m_html1;

		try {
			String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; // 定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script>
			String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style>
			String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
			String regEx_html1 = "<[^>]+";
			p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
			m_script = p_script.matcher(htmlStr);
			htmlStr = m_script.replaceAll(""); // 过滤script标签

			p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
			m_style = p_style.matcher(htmlStr);
			htmlStr = m_style.replaceAll(""); // 过滤style标签

			p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
			m_html = p_html.matcher(htmlStr);
			htmlStr = m_html.replaceAll(""); // 过滤html标签

			p_html1 = Pattern.compile(regEx_html1, Pattern.CASE_INSENSITIVE);
			m_html1 = p_html1.matcher(htmlStr);
			htmlStr = m_html1.replaceAll(""); // 过滤html标签
			
			textStr = htmlStr;

		} catch (Exception e) {
			System.err.println("Html2Text: " + e.getMessage());
		}
		return textStr;// 返回文本字符串
	}
}
