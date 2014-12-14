<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<html>
	<head>
	 <title>儿童类应用隐私协议管理</title>
  
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
			<link href="../css/admin/admin_css.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="../kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="../kindeditor/plugins/code/prettify.css" />
		
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../script/jquery.shove-1.0.js"></script>
		<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
		<script charset="utf-8" src="../kindeditor/plugins/code/prettify.js"></script>
		
		<script type="text/javascript" language="javascript">
		
	    	var editor_content;
			KindEditor.ready(function(K) {
				editor_content = K.create('textarea[name="paramMap.var"]', {
					cssPath : '../kindeditor/plugins/code/prettify.css',
						uploadJson : 'kindEditorUpload.do?p=<%=des.encrypt("0,3,4,2," + ((Admin)session.getAttribute(IConstants.SESSION_ADMIN)).getId()) %>',
                    fileManagerJson : 'kindEditorManager.do?p=<%=des.encrypt("0,3,8,1," + ((Admin) session.getAttribute(IConstants.SESSION_ADMIN)).getId())%>' ,
					allowFileManager : true
				});
			});
	   $(function(){
				//提交表单
				$("#btn_save").click(function(){
				  $("#vars").val(editor_content.html());
					var vars = editor_content.html();
					var id = $("#id").val(); 
				  if(vars==null||vars==""||vars==undefined){
						alert("儿童类应用隐私协议不能为空!");
						return  ;
				  }else{
				    var even = $(this);
					 even.hide();
					 param["paramMap.vars"] = vars;
					 param["paramMap.id"]= id  ;
					 $.shovePost("updateGabalnara.do",param,function(data){
							if(data.msg == 1){
							 	alert("保存成功");
							 	even.show();
								return;
							}else{
							  alert(data.msg);
							  even.show();
							  return ;
							}	
					});		
				 }
			  });		
					
	  });		
			  
		</script>
		
	</head>
	<body>
			<s:hidden name="paramMap.id" id="id"></s:hidden>
			<div id="right"
				style="background-image: url(../images/admin/right_bg_top.jpg); background-position: top; background-repeat: repeat-x;">
				<div style="padding: 15px 10px 0px 10px;">
					<div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="150" height="28" align="center" bgcolor="#CC0000"
									class="white12">
								儿童类应用隐私协议
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
								<td style="width: 150px; height: 80px;" align="right"
									class="blue12">
							链接地址：
								</td>
								<td align="left" class="f66">
									http://www.kyd2002.com/privacy.do
								</td>
							</tr>
							
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
									儿童类应用隐私协议：
								</td>
								<td align="left" class="f66">
									<textarea id="vars" name="paramMap.var" rows="20" class="textareash" style="width:700px;height:500px;">
										<s:property value="paramMap.var"/>
									</textarea>
									<span class="require-field"><s:fielderror fieldName="paramMap.var"></s:fielderror></span>
								</td>
							</tr>
                       		
							<tr>
								<td style="height: 25px;" align="right" class="blue12">
								</td>
								<td align="left" class="f66">
									<span style="color: red;"></span>
								</td>
							</tr>
							
							<tr>
								<td height="36" align="right" class="blue12">
									&nbsp;
								</td>
								<td>
                                <button id="btn_save" style="background-image: url('../images/admin/btn_queding.jpg');width: 70px;border: 0;height: 26px"  ></button>
                                &nbsp;<button type="reset" style="background-image: url('../images/admin/btn_chongtian.jpg');width: 70px;height: 26px;border: 0px"></button>&nbsp;
                                &nbsp;
                                <span style="color: red;">
                             	  <s:fielderror fieldName="actionMsg" theme="simple"></s:fielderror>
                                </span>
                            </td>
							</tr>
						</table>
					</div>
				</div>
			</div>
	</body>
</html>
