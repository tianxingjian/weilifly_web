<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>右侧浮动块网店</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
	<meta http-equiv="description" content="This is my page"/>
	<link href="../css/admin/admin_css.css" rel="stylesheet"
			type="text/css" />

		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>

		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		<script type="text/javascript" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
	<script type="text/javascript" language="javascript">
	
      	
			//图片上传
        KindEditor.ready(function(K) {        
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
								$("#shopImg").val(url);
								$("#singImg").attr('src',"../"+url);
								editor.hideDialog();
							}
						});
					});
				});
				
            });
			//图片上传
        KindEditor.ready(function(K) {        
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
				
				K('#image2').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : false,
							clickFn : function(url, title, width, height, border, align) {
								$("#serviceImg").val(url);
								$("#singImg1").attr('src',"../"+url);
								editor.hideDialog();
							}
						});
					});
				});
				
            });
		
		
		
		
	 	   $(function(){
			//提交表单
	    	$("#btnSave").click(function(){
	    	        var even = $(this);
					even.hide();
		    		param["paramMap.shopTitle"]=$("#shopTitle").val();
		    		param["paramMap.shopImg"]= $("#shopImg").val();
		    		param["paramMap.shopUrl"]=$("#shopUrl").val();
		    		param["paramMap.shopStatus"]=$("input[name=paramMap.shopStatus]:checked").val();
		    		param["paramMap.serviceTitle"]=$("#serviceTitle").val();
		    		param["paramMap.serviceImg"]= $("#serviceImg").val();
		    		param["paramMap.serviceUrl"]=$("#serviceUrl").val();
		    		param["paramMap.serviceStatus"]=$("input[name=paramMap.serviceStatus]:checked").val();
		    		param["paramMap.id"]=$("#id").val();
		    	 if(shopTitle==null||shopTitle==""||shopTitle==undefined){
						alert("网店标题不能为空!");
						return  ;
						}
		    	 if(shopUrl==null||shopUrl==""||shopUrl==undefined){
						alert("网店链接地址不能为空!");
						return  ;
						}
		    	 if(shopImg==null||shopImg==""||shopImg==undefined){
						alert("网店图片不能为空!");
						return  ;
						}
		    	 if(serviceTitle==null||serviceTitle==""||serviceTitle==undefined){
						alert("客服标题不能为空!");
						return  ;
						}
		    	 if(serviceUrl==null||serviceUrl==""||serviceUrl==undefined){
						alert("客服链接地址不能为空!");
						return  ;
						}
		    	 if(serviceImg==null||serviceImg==""||serviceImg==undefined){
						alert("客服图片不能为空!");
						return  ;
						}
		    		$.shovePost("updateShop.do",param,function(data){
							if(data.msg == 1){
							 	alert("保存成功");
								window.location.href="queryShopInit.do";
								return;
							}else{
							alert(data.msg);
							even.show();
							return false;
							}
						});
						 });
						   });
						
						   
	</script>
</head>
<body>
 <s:hidden name="paramMap.id" id="id" />
        <div id="right" style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top;  background-repeat: repeat-x;">
            <div style="padding: 15px 10px 0px 10px;">
              <div>
			
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="150" align="center" height="28"  bgcolor="#CC0000" class="white12">
							右侧浮动块
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>

                <div style="border-top: #C00 2px solid;">
                </div>
                <div style="width: auto; background-color: #FFF; padding: 10px;">
                    <table width="100%" border="0" cellspacing="1" cellpadding="3">
               		<tr>
               		  <td style="width: 100px; height: 25px;" align="right" class="blue12">
                               网店标题：</td>
               			<td>
               			<s:textfield name="paramMap.shopTitle" theme="simple" id="shopTitle"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.shopTitle" /> </span>
               			</td>
						
               		</tr>
                        <tr>
                            <td style="width: 100px; height: 25px;" align="right" class="blue12">
                              网店链接地址：</td>
                            <td align="left" class="f66">
                           <s:textfield name="paramMap.shopUrl" theme="simple" id="shopUrl"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.shopUrl" /> </span>
                            </td>
       					</tr>

                       	<tr>
								<td style="height: 25px;" align="right" class="blue12">
							图片：
								</td>
								<td align="left" class="f66">
									<!-- 图片 -->
									<s:if test="paramMap.shopImg==null||paramMap.shopImg==''">
										<img id="singImg" src="../images/admin/NoImg.GIF"
											style="width: 150px; height: 150px;" />
									</s:if>
									<s:else>
										<img id="singImg" style="width: 150px; height: 150px" src="../${paramMap.shopImg}" />
									</s:else>
									<input id="image1" value="上传" type="button" />
									<span class="require-field"> <s:textfield type="text"
											class="in_text_25" style="width: 150px" readOnly="true"
											id="shopImg" name="paramMap.shopImg" />(最佳分辨率 76X83px) <s:fielderror
											fieldName="paramMap.shopImg"></s:fielderror> </span>
								</td>
								</tr>
								  <tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.shopStatus" id="shopStatus" theme="simple" 
										list="#{1:'是',2:'否'}"/>
									<span class="require-field">*<s:fielderror fieldName="paramMap.shopStatus"></s:fielderror></span>
								</td>
							</tr>
							<tr>
                            <td height="200px" align="right" class="blue12">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        
                        
                        
                        <tr>
               		  <td style="width: 100px; height: 25px;" align="right" class="blue12">
                              客服标题：</td>
               			<td>
               			<s:textfield name="paramMap.serviceTitle" theme="simple" id="serviceTitle"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*<s:fielderror
											fieldName="paramMap.serviceTitle" /> </span>
               			</td>
						
               		</tr>
                        <tr>
                            <td style="width: 100px; height: 25px;" align="right" class="blue12">
                               客服链接QQ：</td>
                            <td align="left" class="f66">
                           <s:textfield name="paramMap.serviceUrl" theme="simple" id="serviceUrl"
										cssStyle="width: 350px; height:23px;" />
									<span style="color: red;">*只能修改sid=""里面的内容：http://webchat.b.qq.com/webchat.htm?sid=""<s:fielderror
											fieldName="paramMap.serviceUrl" /> </span>
                            </td>
       					</tr>

                       	<tr>
								<td style="height: 25px;" align="right" class="blue12">
							客服图片：
								</td>
								<td align="left" class="f66">
									<!-- 图片 -->
									<s:if test="paramMap.serviceImg==null||paramMap.serviceImg==''">
										<img id="singImg1" src="../images/admin/NoImg.GIF"
											style="width: 150px; height: 150px;" />
									</s:if>
									<s:else>
										<img id="singImg1" style="width: 150px; height: 150px" src="../${paramMap.serviceImg}" />
									</s:else>
									<input id="image2" value="上传" type="button" />
									<span class="require-field"> <s:textfield type="text"
											class="in_text_25" style="width: 150px" readOnly="true"
											id="serviceImg" name="paramMap.serviceImg" />(最佳分辨率 76X83px) <s:fielderror
											fieldName="paramMap.serviceImg"></s:fielderror> </span>
								</td>
							</tr>
							<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									是否显示：
								</td>
								<td align="left" class="f66">
									<s:radio name="paramMap.serviceStatus" id="serviceStatus" theme="simple" 
										list="#{1:'是',2:'否'}"/>
									<span class="require-field">*<s:fielderror fieldName="paramMap.serviceStatus"></s:fielderror></span>
								</td>
							</tr>
                            <td height="25" align="right" class="blue12">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td height="36" align="right" class="blue12">
                                &nbsp;</td>
                            <td>
                                  <button  id="btnSave" type="button" style="background-image: url('../images/admin/btn_queding.jpg');width: 70px;border: 0;height: 26px" onclick="return false;" ></button>
                                  &nbsp;
                                  <button type="reset" style="background-image: url('../images/admin/btn_chongtian.jpg');width: 70px;height: 26px;border: 0px"></button>
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>
            </div>
        </div>
        </div>
</body>
</html>
