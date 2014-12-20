<%@page import="com.sun.org.apache.xml.internal.serialize.Printer"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/taglib.jsp"%>
<link rel="stylesheet" href="css/screen.css" media="screen" />
	<script type="text/javascript" language="javascript">
		$(function(){
			//提交表单
			$("#b_send").click(function(){
				var even = $(this);
				even.hide();
				param["paramMap.cName"] = $("#cName").val();
				param["paramMap.cTelephone"]=$("#cTelephone").val();
				param["paramMap.address"] = $("#address").val();
				param["paramMap.needId"] = $("#needId").val();
				param["paramMap.needContent"] = $("#needContent").val();
				$.shovePost("sendToUs.do",param,function(data){
					if(data.returnId>0){
					   	even.show();
					   	alert("恭喜发送成功，我们将会及时的为你提出解决方案！");
						return;					
					}
					alert(data.error);
					even.show();						
				});
				return false;
			});				
		});
	</script>
	<form id="form3" action="sendToUs.do" method="post">
		<h3>
			<span>联系我们</span>
		</h3>
		<fieldset>
			<p class="first">
				<label for="cName">姓名/公司名：</label> <input type="text" name="cName"
					id="cName" size="30" />
			</p>
			<p>
				<label for="cTelephone">手机号：</label> <input type="text"
					name="cTelephone" id="cTelephone" size="30" />
			</p>
			<p>
				<label for="address">地址：</label> <input type="text" name="address"
					id="address" size="30" />
			</p>
			<p>
				<label for=“needId”>需求类型：</label>
				<%--<s:select list="needId" name="paramMap.needId" listKey="id" listValue="needs_name" headerKey="-2" headerValue="--请选择--"></s:select>
		--%>
				<s:select name="needId" id="needId" theme="simple"
					list="#{-1:'-请选择-',1:'O2O网站',2:'O2O商城','3':'App','4':'其他'}"
					value="-1">
				</s:select>
			</p>
			<p>
				<label for="needContent">需求描述：</label>
				<textarea name="needContent" id="needContent" cols="30" rows="10"></textarea>
			</p>
			<p class="submit">
				<button id="b_send" type="button">
					<img src="images/form3/form_button.gif" />
				</button>
			</p>
		</fieldset>

	</form>