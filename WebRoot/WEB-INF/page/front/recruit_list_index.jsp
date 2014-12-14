<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>${seoMap.seoTitle }</title>
		<meta name="keywords" content="${seoMap.seoKeywords }" />
		<meta name="description" content="${seoMap.seoDescription }" />
		<link rel="stylesheet" href="css/Common.css" type="text/css"></link>
		<link href="css/site.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="script/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>


		<script type="text/javascript">
	    $(function(){
	    		param["pageBean.pageNum"]="${pageNum}";
	    		param["type"]=1;
		    	initListInfo(param);	
		    	
		    })
		    
	    //加载留言信息
	   function initListInfo(praData) {
	   		$.shovePost("queryRecruit.do",praData,initCallBack);
   		}
   		
   		function initCallBack(data){
		 	$("#dataInfo").html(data);
		 	$("#jb-list li").each(function(){
			    var obj=$(this).find(".title h3"),obj2=$(this).find(".close"),
			    box=$(this).find(".txt-box"),bool=true;
			    obj.on("click",function(){
			      if(bool){
			         box.slideDown(600),bool=false;
			         obj2.addClass("cur")
			      }else{
			      box.slideUp(600),bool=true;
			         obj2.removeClass("cur");
			      }
			    })
			     obj2.on("click",function(){
			      if(bool){
			        box.slideDown(600),bool=false;
			        obj2.addClass("cur");
			      }else{
			        box.slideUp(600),bool=true;
			        obj2.removeClass("cur");
			     }
			    })
			})
   		}
   		
   		//分页
   		function pageInfo(pageId){
   			param["pageBean.pageNum"] = pageId;
   			initListInfo(param);
   		}
   		
   		//社会招聘
   		function xclick(id){
   			param["pageBean.pageNum"]="${pageNum}";
   			param["type"]=id;
   		    $.shovePost("queryRecruit.do",param,initCallBack); 	
   		}
   		
   		function otherClick(id){ 
   			param["type"]=id;
   		    $.shovePost("queryRecruit2.do",param,initCallBack);
   		}
		</script>
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<div class="content" style="background: #fff;">
			 <div class="main-content clearfix" style="border:none;">
				<div class="zp-nav">
					<s:iterator value="recruitTypeList" var="beanT" status="st">
						<span <s:if test="#st.index==0">class="cur"</s:if>>
						 	<s:if test="#beanT.id==1||#beanT.id==2">
								<a href="javascript:void(0)" onclick="xclick(${beanT.id })">${beanT.title}</a>
							</s:if> 
							<s:else>
								<a href="javascript:void(0)" onclick="otherClick(${beanT.id })">${beanT.title}</a>
							</s:else> 
						</span>
					</s:iterator>
				</div>
				<div id="dataInfo"></div>
			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域content 结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
				<script type="text/javascript" src="script/commom.js"></script>
		<script type="text/javascript" src="script/easing.js"></script>
	</body>
</html>
