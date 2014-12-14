<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base target="_self" />
		<title>${fileCommon.title}</title>
		<link href="../css/jquery/jquery.ui.base.css" rel="stylesheet" />
		<link href="../css/jquery/jquery.ui.theme.css" rel="stylesheet" />
		<link href="../css/uploadFileCss.css" rel="stylesheet" />
		<script type="text/javascript" src="../script/jquery-1.4.2.min.js"></script>
		<link href="css/jquery/jquery.ui.base.css" rel="stylesheet" />
		<link href="css/jquery/jquery.ui.theme.css" rel="stylesheet" />
		<link href="css/uploadFileCss.css" rel="stylesheet" />
		<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
		<%
			if (request.getAttribute("errorMng") == null) {
				request.setAttribute("errorMng", " ");
			}
		%>
		<script type="text/javascript">
		
			//事件注册
			$(function(){
			    //上传完成后返回的上传调用的页面,取出文件名，路径调用页面有存储，不用传输
				if('${mark}' == 'success'){
				    var fileName = "${fileCommon.fileName}";
				    var fileRemark = "${files.filesRemark}";
				    var parentWin = window.dialogArguments;
				    var basePath = "${fileCommon.fileSource}";
				    if(parentWin==null){  
		        		parentWin  = opener.window;             
		     		}  
					var callBackParamsString = "${fileCommon.callBackParamsString}";
					if(callBackParamsString=="undefined"){
						callBackParamsString = null;
					}
					if(parentWin.showFileParam){
						parentWin.showFileParam(["${fileCommon.fileName}"] ,callBackParamsString);
					}
					var callBackFunctionName = "${fileCommon.callBackFunctionName}";
					if(callBackFunctionName!="undefined" || parentWin[callBackFunctionName]){
						parentWin[callBackFunctionName](basePath , ["${fileCommon.fileName}"] ,callBackParamsString);	
					}
		      		window.close();
				}
		
			    //提交前验证是否选取了文件
				$("#sub").click(function(){
					var f=$("#filepath").val();
					  if(!f){
					  	alert("请选取文件后再上传!");
					  }else{//选取文件完成，检查文件名不存在后开始上传
						$("#main").show();
						$("#div1").hide();
						$("#form1").submit();
						return;
				      }
				});
				$("#main").hide();
			});
		</script>
		<style type="text/css">
			div {
				border: solid 0px red;
			}
		</style>
	</head>

	<body>
		<div id="main" style="text-align: center">
			<div id="contentPart1">
				<img src="../images/load.gif" />
			</div>
			<div id="contentPart2">
				<span style="color: red;">文件正在上传，请您稍等！</span>
			</div>
		</div>
		<div
			style="width: 100%; text-align: center; padding-bottom: 0px; vertical-align: bottom;">
			<div id="div1" style="margin-left: auto; margin-right: auto; padding-bottom: 0px; vertical-align: bottom;">
				<form id="form1" action="uploadFiles.do"  enctype="multipart/form-data" method="post">
					<s:hidden value="%{fileCommon.fileName}" name="fileCommon.fileName" id="f_name"/>
					<s:hidden value="%{fileCommon.fileType}" name="fileCommon.fileType" id="f_type"/>
					<s:hidden value="%{fileCommon.notAllowFileType}" name="fileCommon.notAllowFileType"/>
					<s:hidden value="%{fileCommon.fileSource}" name="fileCommon.fileSource" id="f_source"/>
					<s:hidden value="%{fileCommon.fileLimitSize}" name="fileCommon.fileLimitSize" id="f_limit"/>
					<s:hidden value="%{fileCommon.sizeUnit}" name="fileCommon.sizeUnit"/>
					<s:hidden value="%{fileCommon.fileCount}" name="fileCommon.fileCount" id="f_count"/>
					<s:hidden value="%{fileCommon.fileRemark}" name="fileCommon.fileRemark" id="fileRemark"/>
					<s:hidden value="%{fileCommon.callBackFunctionName}" name="fileCommon.callBackFunctionName"/>
					<s:hidden value="%{fileCommon.callBackParamsString}" name="fileCommon.callBackParamsString"/>
					<table width="100%" border="0">
						<tr>
							<td align="center" colspan="2">
								浏览：<s:file theme="simple"  name="files.files" size="45" id="filepath"></s:file>
							</td>
						</tr>
						<s:if test="#request.fileRemark">
							<tr>
								<td align="center" colspan="2">
									<s:textarea label="文件描述" name="files.filesRemark" cols="45" rows="10" />
								</td>
							</tr>
						</s:if>
						<tr>
							<td align="center" colspan="2">
								<input id="sub" type="button" value="上   传" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<table align="center" style="margin-top: 2px;">
			<tr align="center">
				<td>
					您上传的文件大小必须小于
					<span class="warnMess">${fileCommon.fileLimitSize}</span>${fileCommon.sizeUnit}
				</td>
			</tr>
			<tr align="center">
				<td>
					您可以上传
					<c:if
						test="${empty fileCommon.fileType || fileCommon.fileType eq ''}"
						var="type">
					 		任意类型的文件
					 	</c:if>
					<c:if test="${!type}">
						<span class="warnMess">${fileCommon.fileType}</span>类型的文件
					 	</c:if>
				</td>
			</tr>
			<c:if
				test="${fileCommon.notAllowFileType != null && fileCommon.notAllowFileType != ''}"
				var="type">
				<tr align="center">
					<td>
						您不可以上传
						<span class="warnMess">${fileCommon.notAllowFileType }</span>等类型的文件
					</td>
				</tr>
			</c:if>
		</table>

	</body>
</html>
