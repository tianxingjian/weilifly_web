<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${seoMap.seoTitle}</title>
<meta name="keywords" content="${seoMap.seoKeyWord}" />
<meta name="description" content="${seoMap.seoDescription}" />
<link href="css/Common.css" type="text/css" rel="stylesheet" />
		<script src="script/jquery.min.js"></script>
		<script src="script/slider.js"></script>
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
		<%--<script src="script/navigation.js"></script>--%>
		<script type="text/javascript" src="kindeditor/plugins/jwplayer/jwplayer.js"></script>
		<script src="script/easing.js"></script>
		<script src="script/commom.js"></script>

<script type="text/javascript">
		var thePlayer;
		$(function(){
			 videoInit("${paramMap.var}","${paramMap.image}");
		      $("#slider").slider({
		         motion:{
		            DB_1_1:{left:200,opacity:0,speed:700,delay:600},
		            DB_1_2:{left:800,opacity:0,speed:1200,delay:500},
		            DB_2_1:{left:200,opacity:0,speed:500,delay:500},
		            DB_2_2:{left:800,opacity:0,speed:1200,delay:500},
		            end:null
		          }
		    });
		    
		    $(".roll-arrows1").click(function(){
				$("html,body").animate({scrollTop:500},800);
			});
			 
			$(".roll-arrows").click(function(){
			 	$("html,body").animate({scrollTop:1290},800);
			});	
		});
		
		function videoInit(videoPath,videoImg){
        	if(videoPath!=''){
		        thePlayer = jwplayer('flashContent').setup({  
		            flashplayer: 'kindeditor/plugins/jwplayer/player.swf',  
		            file: videoPath,  
		            width: 680,  
		            height: 500,
		            image:videoImg,  
		            dock: false,
		            autostart:true  
		      });
		    }
        }
			
		$(function(){ 
				$(".sp-box span").click(function(){ 
				$(".video-popup").show(); 
				$(".video-popup").before("<div id='zz-bg'></div>"); 
			});	
			
			$(".video-popup .close a").click(function(){ 
				$(this).parents('.video-popup').hide(); 
				$(this).parents('.video-popup').prev('div').remove(); 
			}); 
			
			}) ;
	
		
</script>
<script type="text/javascript">
		function search_mybtn(){
		  var  keyWord  = $("#keyWord").val();
		  if(keyWord==null||keyWord==""||keyWord =="请输入关键字"||keyWord==undefined){
	  		   return false;
		  }
		   $("#keyWord").val(encodeURI(keyWord)) ;
		   return $("#searchFm").submit();  
		}
	
		$(function(){
	      var  top_url  =  window.location.href ;
	       $(".topUrl").each(function(i,n){
	           var url  = $(n).attr("href");
	           //alert(url);
	           if(top_url.indexOf(url)!=-1){
	               $(n).parent().attr("class","cur");
	               var Left = $(n).position().left;
	               $(".sliding-block").css({"left":Left,"width":44});
	           }
	      });
	});
	
		
</script>
		
<script type="text/javascript">	
	$(function(){
		//过两秒显示 showImage(); 内容
	    setTimeout("showImage();",2000);
	    $("#close22").click(function(){
			$("#adSmall").slideUp();
		});
	});

	function showImage(){
	    $("#adBig").slideUp(1000,function(){$("#adSmall").slideDown(1000);});
	}

</script>
</head>
<body>
	<div class="video-popup">
		<div class="close">
			<a href="javascript:;"></a>
		</div>
		<div class="v-block" id="flashContent"></div>
	</div>
	<!-- 动态包含top开始 -->
	<jsp:include page="/include/top.jsp"></jsp:include>
	<!-- 动态包含top结束 -->

	<!--头部外围盒子结束 head-box-->
	<!-- banner图开始 -->
		<div class="banner-box" style="height: 470px;">
			<div class="roll-arrows1"></div>
			<div class="banner" id="slider">
				<ul class="DB_bgSet">
					<s:iterator value="#request.bannerList" var="bean" status="st">
						<li
							style="background: url('${bean.imgPath}') no-repeat center center;">
							<a href="${bean.url}" target="_blank"
								style='display: block; height: 470px;'></a>
						</li>
					</s:iterator>
				</ul>
				<ul class="DB_imgSet">
					<s:iterator value="#request.bannerList" var="bean" status="st">
						<li>
							<a href="${bean.url}" target="_blank" 
								style='display: block; width: 600px; float: left; height: 100%'></a>
							<a href="${bean.url}" target="_blank" style='display: block;'><img
									class="DB_1_1" src="${bean.imgUrl}" />
							</a>
							<a href="${bean.urlTwo}" target="_blank"><img class="DB_1_2"
									src="${bean.imgFont}" />
							</a>
						</li>
					</s:iterator>
				</ul>
				<div class="DB_menuWrap">
					<ul class="DB_menuSet">
						<s:iterator value="#request.bannerList" var="bean" status="st">
							<li></li>
						</s:iterator>
					</ul>
				</div>
			</div>
		</div>
		<!-- banner结束 -->

	<!--3D滚动外层盒子-->
	<script src="script/jquery.roundabout2.js"></script>
	<script type="text/javascript">
			$(document).ready(function() {
				$('ul.abc').roundabout();
			});
	</script>
	<!-- 第一组模块 -->
	<div class="main-box">
		<div class="main">
			<%--<div class="roll-arrows"></div>
				--%>
			<div class="zx-box" style="height: 448px;">
				<div class="inner">
					<h3>
						<a href="queryWeiliDisplayes.do?id=2">more+</a><span>微力研究院</span>
					</h3>
					<s:iterator value="#request.researchList" var="bean" status="st">
						<dl class="zx-list">
							<dt>
								<!--内容缩略图 -->
								<a href="weiliDisplayDetail.do?id=${bean.id}&typeId=1"><img
									src="${bean.image}" /> </a>
							</dt>
							<dd>
								<div style="height: 55px; overflow: hidden;">
									<!--内容标题 -->
									<a href="weiliDisplayDetail.do?id=${bean.id}&typeId=1" class="title">${bean.title}</a>
								</div>
								<a href="weiliDisplayDetail.do?id=${bean.id}&typeId=1" class="btn"></a>
							</dd>
						</dl>
					</s:iterator>
				</div>
			</div>
			<!--O2O兵器库-->

			<div class=" zx-box rd-box" style="height: 448px;">
				<div class="inner">
					<h3>
						<a href="queryWeiliDisplayes.do?id=3">more+</a><span>O2O兵器库</span>
					</h3>
					<s:iterator value="#request.o2OList" var="bean" status="st">
						<dl class="zx-list">
							<dt>
								<!--内容缩略图 -->
								<a href="weiliDisplayDetail.do?id=${bean.id}&typeId=3"><img
									src="${bean.image}" /> </a>
							</dt>
							<dd>
								<div style="height: 55px; overflow: hidden;">
									<!--内容标题 -->
									<a href="weiliDisplayDetail.do?id=${bean.id}&typeId=3" class="title">${bean.title}</a>
								</div>
								<a href="weiliDisplayDetail.do?id=${bean.id}&typeId=3" class="btn"></a>
							</dd>
						</dl>
					</s:iterator>
				</div>
			</div>
			<!--标杆案例-->

			<div class="sp-box" style="height: 448px;">
				<div class="inner">
					<h3>
						<a href="queryWeiliDisplayes.do?id=4">more+</a><span>标杆案例</span>
					</h3>
					<s:iterator value="#request.caseList" var="bean" status="st">
								<a href="weiliDisplayDetail.do?id=${bean.id}&typeId=2" class="aj"><img src="${bean.image}" /></a>
								<div class="spjs" title="${bean.title}"><a href="weiliDisplayDetail.do?id=${bean.id}&typeId=2" class="title"> ${bean.title} </a></div>
					</s:iterator>
				</div>
			</div>
		</div>
	</div>
	<!-- 第二组模块 -->
	<div class="main-box">
		<div class="main">
			<div class="nx-box" style="height: 448px;">
				<div class="inner">
					<h3>
						<a href="queryNewest.do">more+</a><span>最新动态</span>
					</h3>
					<s:iterator value="#request.newestList" var="bean" status="st">
						<dl class="zx-list">
							<dt>
								<a href="NewestDetail.do?id=${bean.id}"><img
									src="${bean.image}" /> </a>
							</dt>
							<dd>
								<div style="height: 55px; overflow: hidden;">
									<a href="NewestDetail.do?id=${bean.id}" class="title">${bean.title}</a>
								</div>
								<a href="NewestDetail.do?id=${bean.id}" class="btn"></a>
							</dd>
						</dl>
					</s:iterator>
				</div>
			</div>
			<!--微力论坛-->

			<div class="sp-box" style="height: 448px;">
				<div class="inner">
					<h3>
						<a href="brandDetail.do?id=5">more+</a><span>微力论坛</span>
					</h3>
					<a href="javascript:;" class="aj"><img src="${paramMap.image}" /><span>播放</span>
					</a>
					<div class="spjs" title="${paramMap.title}">
						${paramMap.title}</div>
				</div>
			</div>
		</div>
	</div>
	<!--第三块锚点区域 -->

	<jsp:include page="/include/footer.jsp"></jsp:include>
	<!--底部结束-->
</body>
</html>