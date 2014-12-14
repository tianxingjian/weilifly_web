<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>弹出广告图片管理</title>
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
								$("#shopImg2").val(url);
								$("#singImg2").attr('src',"../"+url);
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
		    		param["paramMap.img"]= $("#shopImg").val();
		    		param["paramMap.gImg"]= $("#shopImg2").val();
		    		param["paramMap.url"]= $("#url").val();
		    		param["paramMap.gUrl"]= $("#gUrl").val();
		    		param["paramMap.status"]= $("input[name=paramMap.status]:checked").val();
		    		param["paramMap.id"]=$("#id").val();
		    	 if(shopImg==null||shopImg==""||shopImg==undefined){
						alert("图片不能为空!");
						return  ;
						}
		    	 if(shopImg2==null||shopImg2==""||shopImg2==undefined){
						alert("图片不能为空!");
						return  ;
						}
						if(url==null||url==""||url==undefined){
						alert("链接地址不能为空!");
						return;
						}
						if(gUrl==null||gUrl==""||gUrl==undefined){
						alert("链接地址不能为空!");
						return;
						}
		    		$.shovePost("updateAdvert.do",param,function(data){
							if(data.msg == 1){
							 	alert("保存成功");
								window.location.href="queryAdvertInit.do";
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
							弹出广告图片管理
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
								<td style="height: 25px;" align="right" class="blue12">
							图片：
								</td>
								<td align="left" class="f66">
									<!-- 图片 -->
									<s:if test="paramMap.img==null||paramMap.img==''">
										<img id="singImg" src="../images/admin/NoImg.GIF"
											style="width: 150px; height: 150px;" />
									</s:if>
									<s:else>
										<img id="singImg" style="width: 150px; height: 150px" src="../${paramMap.img}" />
									</s:else>
									<input id="image1" value="上传" type="button" />
									<span class="require-field"> <s:textfield type="text"
											class="in_text_25" style="width: 150px" readOnly="true"
											id="shopImg" name="paramMap.img" /> <s:fielderror
											fieldName="paramMap.img"></s:fielderror> </span>
								</td>
								</tr>
									<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									链接地址：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.url" id="url"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.url"></s:fielderror></span>
								</td>
							</tr>
							
							<tr style="height: 100px;"></tr>
							
							 	<tr>
								<td style="height: 25px;" align="right" class="blue12">
							图片：
								</td>
								<td align="left" class="f66">
									<!-- 图片 -->
									<s:if test="paramMap.gImg==null||paramMap.gImg==''">
										<img id="singImg2" src="../images/admin/NoImg.GIF"
											style="width: 150px; height: 150px;" />
									</s:if>
									<s:else>
										<img id="singImg2" style="width: 150px; height: 150px" src="../${paramMap.gImg}" />
									</s:else>
									<input id="image2" value="上传" type="button" />
									<span class="require-field"> <s:textfield type="text"
											class="in_text_25" style="width: 150px" readOnly="true"
											id="shopImg2" name="paramMap.gImg" /> <s:fielderror
											fieldName="paramMap.gImg"></s:fielderror> </span>
								</td>
								</tr>
								
									<tr>
								<td style="width: 100px; height: 25px;" align="right"
									class="blue12">
									链接地址：
								</td>
								<td align="left" class="f66">
									<s:textfield name="paramMap.gUrl" id="gUrl"
										cssClass="in_text_250" theme="simple"></s:textfield>
									<span class="require-field">*<s:fielderror fieldName="paramMap.gUrl"></s:fielderror></span>
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
