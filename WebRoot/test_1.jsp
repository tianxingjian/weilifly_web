<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.shove.web.util.DesSecurityUtil" %>
<%@page import="com.weili.constants.IConstants" %>
<%@ page import="com.weili.entity.User" %>
<%@ page import="com.weili.entity.Admin" %>
<% 
	//加密/解密 工具类
	DesSecurityUtil des = new DesSecurityUtil();
	
	//测试数据，在实际项目中则按照项目流程来
	//用到的只是ID
	User user = new User();
	user.setId(1L);
	session.setAttribute(IConstants.SESSION_USER,user);
	
	Admin admin = new Admin();
	admin.setId(1L);
	session.setAttribute(IConstants.SESSION_ADMIN,admin);
	
 %>
<html>
	<head>
		<title>管理首页</title>
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		
		<link rel="stylesheet" href="kindeditor/themes/default/default.css" />
		
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="kindeditor/kindeditor.js"></script>
		<script type="text/javascript" src="kindeditor/lang/zh_CN.js"></script>
		
		<script type="text/javascript">
			$(function(){
				$("input[type=text]").width(500);
				$("input[type=text]").height(30);
			});
		
		
			//上传功能都有版本问题，主要的上传功能都是可以实现的，但是一些页面展示细节问题就不能达到演示的效果了。
			
			KindEditor.ready(function(K) {
			
				//单个上传 dir：上传类型	---start
				var uploadbutton = K.uploadbutton({
					button : K('#uploadButton')[0],
					fieldName : 'imgFile',
					url : 'myFileUpload.do?p=<%=des.encrypt("3,2,8,1,"+((User)session.getAttribute(IConstants.SESSION_USER)).getId()) %>',
					afterUpload : function(data) {
						if (data.error === 0) {
							var url = K.formatUrl(data.url, 'absolute');
							K('#url').val(url);
						} else {
							alert(data.message);
						}
					},
					afterError : function(str) {
						alert('自定义错误信息: ' + str);
					}
				});
			
				uploadbutton.fileBox.change(function(e) {
					uploadbutton.submit();
				});
				//单个文件上传				---end
				
				//图片上传弹出框			---start		1,需要设置编码：kindeditor/lang/zh_CN.js
				
				var editor = K.editor({
					uploadJson : 'myFileUpload.do?p=<%=des.encrypt("0,2,8,1,"+((User)session.getAttribute(IConstants.SESSION_USER)).getId()) %>',
					fileManagerJson : 'myKindEditorManager.do?p=<%=des.encrypt("0,2,8,1,"+((User)session.getAttribute(IConstants.SESSION_USER)).getId()) %>',
					imageSizeLimit : "2MB",
					allowFileManager : true,
					imageUploadLimit : 5
				});
				K('#image1').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#url1').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#url1').val(url);
								editor.hideDialog();
							}
						});
					});
				});
				K('#image2').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showLocal : false,
							imageUrl : K('#url2').val(),
							clickFn : function(url, title, width, height, border, align) {//返回图片相关信息，有则返回没有则不返回
								K('#url2').val(url);
								editor.hideDialog();
							}
						});
					});
				});
				K('#image3').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : false,
							imageUrl : K('#url3').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#url3').val(url);
								editor.hideDialog();
							}
						});
					});
				});
				//图片上传弹出框			---end
				
				//批量上传图片				---start
				
				K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {//返回所有上传图片的路径
								var div = K('#J_imageView');
								div.html('');
								K.each(urlList, function(i, data) {
									div.append('<img src="' + data.url + '">');
								});
								editor.hideDialog();
							}
						});
					});
				});
				//批量上传图片				---end
				
				//上传文件弹出框			---start
				K('#insertfile').click(function() {
					editor.loadPlugin('insertfile', function() {
						editor.plugin.fileDialog({
							fileUrl : K('#url').val(),
							clickFn : function(url, title) {
								K('#url').val(url);
								editor.hideDialog();
							}
						});
					});
				});
				//上传文件弹出框			---end
				
			});
		</script>
		
		</head>
		
		<div class="upload">
			<input class="ke-input-text" id="url" readonly="readonly" type="text" style="width: 500px;height: 30px;">
			<input style="display: none;" id="uploadButton" value="Upload" type="button"> 单个上传文件<br/>
			<hr/>
			
			<p><input id="url1" type="text"> <input id="image1" value="选择图片" type="button">（网络图片 + 本地上传）</p>
			<p><input id="url2" type="text"> <input id="image2" value="选择图片" type="button">（网络图片）</p>
			<p><input id="url3" type="text"> <input id="image3" value="选择图片" type="button">（本地上传）</p>
			<hr/>
			<input id="J_selectImage" value="批量上传" type="button">
			<div id="J_imageView"></div>
			<hr/>
			<input type="text" id="url" value="" /> <input type="button" id="insertfile" value="选择文件" />
			<hr/>
			
		</div>
		
		
		
		上传最终效果：
		可以控制上传大小，并进行扩展
		可以控制文件类型，并进行扩展
		会员可以管理自己的文件（是否需要考虑其安全性？）
		
		
		
		
		
		<body>
		
		
		
		
		
		
		
		
		
		</body>
</html>
		