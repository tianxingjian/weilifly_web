<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>修改产品详情</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		<script type="text/javascript">
			var editor_details;
			var _imgArray = [];
			KindEditor.ready(function(K) {
				editor_details = K.create('textarea[id="content"]', {
					cssPath : '../kindeditor/plugins/code/prettify.css',
					uploadJson : 'kindEditorUpload.do',
					fileManagerJson : 'kindEditorManager.do',
					allowFileManager : true,
					formatUploadUrl : false
				});
				
				prettyPrint();
				
				//单个上传 dir：上传类型	---start
				var uploadbutton = K.uploadbutton({
					button : K('#uploadButton'),
					fieldName : 'imgFile',
					url : '../myFileUpload.do?p=<%=des.encrypt("2,1,7,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
					afterUpload : function(data) {
						if (data.error === 0) {
							K('#path').val(data.url);
						} else {
							alert(data.message);
						}
					},
					afterError : function(str) {
						alert('自定义提示信息: ' + str);
					}
				});
			
				uploadbutton.fileBox.change(function(e) {
					uploadbutton.submit();
				});
				//单个文件上传				---end
				
				//图片上传弹出框			---start
				var editor = K.editor({
					uploadJson : '../myFileUpload.do?p=<%=des.encrypt("0,1,4,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
					fileManagerJson : '../myKindEditorManager.do?p=<%=des.encrypt("0,1,4,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
					imageSizeLimit : "2MB",
					allowFileManager : true,
					imageUploadLimit : 5,
					formatUploadUrl : false 
				});
				
				K('#image1').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : false,
							clickFn : function(url, title, width, height, border, align) {
								$("#image").val(url);
								$("#singImg").attr('src',"../"+url);
								editor.hideDialog();
							}
						});
					});
				});
				
				K('#image2').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : false,
							clickFn : function(url, title, width, height, border, align) {
								$("#backImage").val(url);
								$("#singImg1").attr('src',"../"+url);
								editor.hideDialog();
							}
						});
					});
				});
				
				//批量上传图片				---start
				K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {//返回所有上传图片的路径
								K.each(urlList, function(i, data) {
									_imgArray.push('<div style="float:left;" class="item"><img src="../'+data.url+'" height="80px" width="80px" /><input class="images" type="hidden" value="'+data.url+'" /><span style="cursor: pointer;" onclick="deleteImage(this)">删除</span></div>');
								});
								
								$("#td_images").append(_imgArray.join(" "));
								
								_imgArray = [];
								
								editor.hideDialog();
							}
						});
					});
				});
				//批量上传图片				---end
				
			});
			
			$(function(){
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					var images = [];
					$(".images").each(function(){
						images.push($(this).val());
						
					});
					param["id"] = "${paramMap.id}";
					var type = "${paramMap.type}";
					param["type"] = type;
					param["productId"] = "${paramMap.productId}";
					param["parentId"] = "${paramMap.parentId}";
					param["name"] = $("#name").val();
					if(type == 4){
						param["introduction"] = $("#path").val();
					}else{
						param["introduction"] = $("#introduction").val();
					}
					param["image"] = $("#image").val();
					param["backImage"] = $("#backImage").val();
					param["images"] = images.join(",");
					if(type == 1||type == 3||type == 4||type == 8||type == 9||type == 10||type == 11){
						param["content"] = editor_details.html();
					}
					param["status"] = $("input[name=paramMap.status]:checked").val();
					$.shovePost("updateProductDetail.do",param,function(data){
						alert(data.error);
						if(data.returnId>0){
							//history.back(); 
							self.location=document.referrer;
							return;
							
						}
						even.show();
						
					});
					return false;
				});
				
				var type = "${paramMap.type}";
				if(type == 4){
					$(".video").show();
				}
				
			});
			
			function deleteImage(e){
				$(e).parent().remove();
			}
		</script>
	</head>
	<body>
		<form id="addDemo" name="addDemo" action="addDemo.do" method="post">
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryProductDetailList.do?id=${paramMap.productId}">产品详情列表</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									修改产品详情
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
						</table>
					</div>
					<div style="border-top: #C00 2px solid;">
					</div>
					<div style="width: auto; background-color: #FFF; padding: 10px;">
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr <s:if test="#request.paramMap.type==10">style="display: none;"</s:if>>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									名称：
								</td>
								<td align="left" class="f66">
									<s:textfield id="name" name="paramMap.name"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.name"></s:fielderror></span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.status" id="status" theme="simple" 
										list="#{1:'是',2:'否'}"/>
									<span class="require-field">*<s:fielderror fieldName="paramMap.status"></s:fielderror></span>
								</td>
							</tr>
							<s:if test="paramMap.parentId<0">
								<!-- 背景图片 -->
								<tr>
									<td style="height: 25px;" align="right" class="blue12" width="70px">
										<input id="image2" value="上传背景图片" type="button"/>
									</td>
									<td align="left" class="f66">
										<input type="hidden" id="backImage" name="paramMap.backImage" value="${paramMap.backImage}"/>
										 <span class="require-field"></span>
										 
									</td>
								</tr>
								<tr>
									<td style="height: 25px;" align="right" class="blue12">
									</td>
									<td align="left" class="f66">
										<img id="singImg1" src='<s:if test="#request.paramMap.backImage!=null&&#request.paramMap.backImage!=''">../${paramMap.backImage }</s:if><s:else>../images/NoImg.GIF</s:else>' style="height: 100px;" />
									</td>
								</tr>
							</s:if>
								<tr style="display: none;" class="video">
									<td style="width: 100px; height: 25px;" align="right"
										class="blue12">
										上传视频：
									</td>
									<td align="left" class="f66">
										<input class="in_text_2" id="path" readonly="readonly" name="paramMap.introduction" value="${paramMap.introduction}"
											type="text" style="width: 350px; height: 20px;" />
										<input style="display: none;" id="uploadButton" value="浏览"
											type="button" />
										<span class="require-field">*<s:fielderror
												fieldName="paramMap.path"></s:fielderror>
										</span>
									</td>
								</tr>
							<s:if test="paramMap.type==12">
								<tr class="amplify" >
									<td style="width: 100px; height: 25px;" align="right"
										class="blue12">
										简介：
									</td>
									<td align="left" class="f66">
										<s:textarea id="introduction" name="paramMap.introduction" rows="10"  style="width: 470px; padding:5px;"
											cssClass="textareash" theme="simple"></s:textarea>
										<span class="require-field">*<s:fielderror fieldName="paramMap.introduction"></s:fielderror></span>
									</td>
								</tr>
							 </s:if>
							 <s:if test="paramMap.type==4||paramMap.type==10||paramMap.type==11||paramMap.type==12">
								<!-- 放大镜 -->
								<tr class="amplify" >
									<td style="height: 25px;" align="right" class="blue12" width="70px">
										<input id="image1" value="上传图片" type="button"/>
									</td>
									<td align="left" class="f66">
										<input type="hidden" id="image" name="paramMap.image" value="${paramMap.image}"/>
										 <span class="require-field"></span>
										 
									</td>
								</tr>
							
								<tr class="amplify" >
									<td style="height: 25px;" align="right" class="blue12">
									</td>
									<td align="left" class="f66">
										<img id="singImg" src='<s:if test="#request.paramMap.image!=null&&#request.paramMap.image!=''">../${paramMap.image }</s:if><s:else>../images/NoImg.GIF</s:else>' style="height: 100px;" />
									</td>
								</tr>
							</s:if>
							<!-- 智能防近视图片集 -->
							<s:if test="paramMap.type==3">
								<tr>
									<td style="height: 25px;" align="right" class="blue12" width="70px">
										<s:textfield id="J_selectImage" value="产品图片集" type="button"/><br/>
										<span class="require-field">*</span>
									</td>
									<td align="left" class="f66" style="height: 100px;" id="td_images">
										<s:iterator value="#request.images" var="bean">
											<div style="float:left;" class="item"><img width="80px" height="80px" src="../${bean }" /><input type="hidden" value="${bean }" class="images"><span onclick="deleteImage(this)" style="cursor: pointer;">删除</span></div>
										</s:iterator>
									</td>
								</tr>
							</s:if>
							<s:if test="paramMap.type==1||paramMap.type==3||paramMap.type==4||paramMap.type==8||paramMap.type==9||paramMap.type==10||paramMap.type==11">
								<tr>
									<td style="width: 100px; height: 25px;" align="right"
										class="blue12">
										内容：
									</td>
									<td align="left" class="f66">
										<textarea id="content" rows="20" class="textareash" style="width: 700px; padding:5px;">${paramMap.content}</textarea>
									</td>
								</tr>
							
								<tr>
									<td style="height: 25px;" align="right" class="blue12">
									</td>
									<td align="left" class="f66">
										<span style="color: red;">*内容里面的图片宽度请控制在1000PX内</span>
									</td>
								</tr>
							</s:if>
							<tr>
								<td height="36" align="right" class="blue12">
									<s:hidden name="action"></s:hidden>
									&nbsp;
								</td>
								<td>
									<button id="btn_save"
										style="background-image: url('../images/admin/btn_queding.jpg'); width: 70px; border: 0; height: 26px"></button>
									&nbsp;
									<button type="reset"
										style="background-image: url('../images/admin/btn_chongtian.jpg'); width: 70px; height: 26px; border: 0px"></button>
									&nbsp; &nbsp;
									<span class="require-field"><s:fielderror fieldName="actionMsg" theme="simple"></s:fielderror></span>
								</td>
							</tr>
						</table>
						<br />
					</div>
				</div>
			</div>
		</form>
	</body>
</html>
