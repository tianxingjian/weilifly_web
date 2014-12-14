package com.shove.web.util;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.shove.security.Encrypt;

/**
 * 自定义加解密算法
 * 
 * @author
 */
public class CryptionUtil {
	
	private static HttpServletRequest request;
	
	/**
	 * MD5加密密码
	 * 
	 * @param pwd
	 * @return
	 */
	public static String md5(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
		try {
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			return null;
		}
	}
	
	 /** 
	* 加密比对字符串 
	* @param one 网站加密字符840eaa66f50cf106b1267a01b9606e99 
	* @param two 传输接值字符24401397f26757da3a88ba3cd29b84b4 
	* @return 
	 * @throws Exception 
	*/ 
	public static long compareKey(Map<String, Object> params,String mKey) throws Exception{
		String one = getSignData(params);
		if (!one.equals(mKey)) {
			return -1;
		}
		return 1; 
	}
	

	/**
	 * 参数排序签名
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	private static String getSignData(Map<String, Object> params)throws Exception {
		StringBuffer content = new StringBuffer();
		// 按照key做排序
		List<String> keys = new ArrayList<String>(params.keySet());
		Collections.sort(keys);

		for (int i = 0; i < keys.size(); i++) {
			String key = (String) keys.get(i);
			System.out.println(keys);
			if ("mKey".equals(key)) {
				continue;
			}
			String[] values = (String[]) params.get(key);
			String valueStr = "";
			for (int j = 0; j < values.length; j++) {
				valueStr = (j == values.length - 1) ? valueStr + values[j]: valueStr + values[j] + ",";
			}
			// 具体逻辑修改下面的路径进行拼接
			content.append(valueStr);

		}
		return md5(content.toString());
	}
}