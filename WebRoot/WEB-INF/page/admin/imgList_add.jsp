<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  		<title>管理首页</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		<link type="text/css" rel="stylesheet" href="../common/Skins/GreyBlue/jbox.css"/>
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script type="text/javascript" src="../common/jquery.jBox-2.3.min.js"></script>
		<script type="text/javascript" src="../common/i18n/jquery.jBox-zh-CN.js"></script>
		<script type="text/javascript" language="javascript">
		
			KindEditor.ready(function(K) {
								
				//单个上传 dir：上传类型	---start
				var uploadbutton = K.uploadbutton({
					button : K('#uploadFileButton'),
					fieldName : 'imgFile',
					url : '../myFileUpload.do?p=<%=des.encrypt("3,1,7,1,"+((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
					afterUpload : function(data) {
						if (data.error === 0) {
							K('#downUrl').val(data.url);
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
					uploadJson : '../myFileUpload.do?p=<%=des.encrypt("0,1,4,1,"
							+ ((Admin) session
									.getAttribute(IConstants.SESSION_ADMIN))
									.getId())%>',
					fileManagerJson : '../myKindEditorManager.do?p=<%=des.encrypt("0,1,4,1,"
							+ ((Admin) session
									.getAttribute(IConstants.SESSION_ADMIN))
									.getId())%>',
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
								$("#imgUrl").val(url);
								$("#singImg").attr('src',"../"+url);
								editor.hideDialog();
							}
						});
					});
				});
			});
		
		
	    	$(function(){
				//提交表单
				$("#btn_save").click(function(){
					var even = $(this);
					even.hide();
					param["tid"]=$("#designId").val();
					param["sortIndex"] = $("#sortIndex").val();
					param["status"] = $("input[name=paramMap.status]:checked").val();
					param["downUrl"] = $("#downUrl").val();
					param["imgUrl"]=$("#imgUrl").val();
					$.shovePost("addImgList.do",param,function(data){
						alert(data.error);
						if(data.returnId>0){
							window.location.href = "queryImgListInit.do";
							return;							
						}
						even.show();
					});
					return false;
				});	
				
				$("#bt_design").click(function(){
				$.jBox.open("iframe:queryDesignInit2.do", "选择设计素材", 800, 520, { buttons: { '关闭': true} });
			});
						
			});
			
			
		function joxCallBack(designInfo){
			$.jBox.close(true);
			$("#designInfo").html(designInfo["title"]);
			$("#designId").val(designInfo["id"]);
		}
		
		</script>
  </head>
  
  <body>
    <form id="addImgList" action="addImgList.do" method="post">
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" height="28" align="center" bgcolor="#8594A9"
									class="white12">
									<a href="queryImgListInit.do">设计素材图片列表管理</a>
								</td>
								<td width="2">
									&nbsp;
								</td>
								<td width="100" align="center" bgcolor="#CC0000" class="white12">
									<a href="addImgListInit.do">添加图片</a>
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
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									排序：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.sortIndex" id="sortIndex"
										theme="simple" cssClass="in_text_2"
										cssStyle="width: 250px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.sortIndex" /> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									<input type="button" id="bt_design" value="关联设计素材..." />
								</td>
								<td align="left" class="f66">
									<s:hidden id="designId" name="paramMap.tid" />
									<span id="designInfo">
										<s:if test="#request.paramMap.id!=null&&#request.paramMap.id!=''&&#request.paramMap.id>0" >${paramMap.title}</s:if>
										<s:else>请点击关联设计素材。</s:else>
									</span>
									<span class="require-field">*<s:fielderror fieldName="paramMap.designInfo"></s:fielderror></span>
								</td>
							</tr>
							<tr id="trImg">
								<td style="height: 25px;" align="right" class="blue12">
									图片：
								</td>
								<td align="left" class="f66">
									<!-- 图片 -->
									<s:if test="paramMap.imgUrl==null||paramMap.imgUrl==''">
										<img id="singImg" src="../images/admin/NoImg.GIF"
											style="width: 150px; height: 150px;" />
									</s:if>
									<s:else>
										<img id="singImg" style="width: 150px; height: 150px" />
									</s:else>
									<input id="image1" value="上传" type="button" />
									<span class="require-field"> <s:textfield type="text"
											class="in_text_25" style="width: 150px" readonly="true"
											id="imgUrl" />(最佳分辨率 470X470px) <s:fielderror
											fieldName="paramMap.imgUrl"></s:fielderror> </span>
								</td>
							</tr>
							<tr id="trLink" >
								<td style="height: 25px;" align="right" class="blue12">
									下载地址：
								</td>
								<td align="left" class="f66">
									<input class="in_text_2" id="downUrl" name="paramMap.downUrl"
										type="text" style="width: 350px; height:23px;" />
									<input id="uploadFileButton" style="display: none;"  value="浏览"
										type="button" />
									<span class="require-field">*<s:fielderror
											fieldName="paramMap.downUrl"></s:fielderror> </span>
								</td>
							</tr>
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.status" id="status" theme="simple"
										list="#{1:'是',2:'否'}" value="1" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.status" /> </span>
								</td>

							</tr>
							<tr>
								<td height="25">
								</td>
								<td align="left" class="f66" style="color: Red;">
									<s:fielderror fieldName="paramMap.allError" />
								</td>
							</tr>
							<tr>
								<td height="36" align="right" class="blue12">
									&nbsp;
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<td height="36" align="right" class="blue12">
									&nbsp;
								</td>
								<td>
									<button id="btn_save"
										style="background-image: url('../images/admin/btn_queding.jpg'); width: 70px; border: 0; height: 26px"></button>
									&nbsp;
									<button type="reset"
										style="background-image: url('../images/admin/btn_chongtian.jpg'); width: 70px; height: 26px; border: 0px"></button>
									&nbsp; &nbsp;
									<span style="color: red;"> <s:fielderror
											fieldName="actionMsg" theme="simple"></s:fielderror> </span>
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
