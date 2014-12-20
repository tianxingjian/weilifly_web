<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${paramMap.seoTitle }</title>
		<meta name="keywords" content="${paramMap.seoKeywords }" />
		<meta name="description" content="${paramMap.seoDescription }" />
		<link href="/css/Common.css" type="text/css" rel="stylesheet" />
		<link href="/css/site.css" type="text/css" rel="stylesheet" />
		<script src="script/easing.js"></script>
		<script type="text/javascript" src="/script/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="/script/jquery.shove-1.0.js"></script>
		<script type="text/javascript" src="/kindeditor/plugins/jwplayer/jwplayer.js" ></script>
		<link href="/script/X-Scrollbar/scroll_bar.css" type="text/css" rel="stylesheet"/>
		<script src="/script/X-Scrollbar/jquery.Scrollbar.js"></script>
		<script type="text/javascript">
			var thePlayer;
			$(function(){
				//swfInit();
				 videoInit("${reportList[0].path}","${reportList[0].image}");
			      
			     $(".video-pic").click(function(){
			     	var even = $(this);
			     	$("td div").removeClass("cur");
			     	even.parent().addClass("cur");
			     	param["id"] = even.attr("reportId");
			     	$.shovePost("kydReport.do",param,function(data){
						var path = data.path;
				     	var content = data.content;
				     	var title = data.title;
				     	var views = data.views;
				     	var img = data.image;
				     	videoInit(path,img);
				     	$("#title").html(title);
				     	$("#path").attr("href",path);
				     	$("#content").html(content);
				     	$("#views").html(views+"次");
					});
			     	
			     });
			     
			     $('#roll-warp').mCustomScrollbar({horizontalScroll:true,scrollInertia:600,autoDraggerLength:false});
			     
			});
			
			function swfInit(){
				var swfVersionStr = "9.0.0";
		        var xiSwfUrlStr = "flash/expressInstall.swf";
			    var flashvars = {id:"${reportList[0].id}"};
		            var params = {};
		            params.quality = "high";
		            params.bgcolor = "#ffffff";
		            params.allowscriptaccess = "sameDomain";
		            params.allowfullscreen = "true";
		            var attributes = {};
		            attributes.id = "HpEdit";
		            attributes.name = "HpEdit";
		            attributes.align = "middle";
		            swfobject.embedSWF(
		                "system/shovePlayerLayout.swf", "flashContent", 
		               "958", "497", 
		                swfVersionStr, xiSwfUrlStr, 
	                flashvars, params, attributes);	
	        } 
	        
	        function videoInit(videoPath,videoImg){
	        	if(videoPath!=''){
			        thePlayer = jwplayer('flashContent').setup({  
			            flashplayer: 'kindeditor/plugins/jwplayer/player.swf',  
			            file: videoPath,  
			            width: 958,  
			            height: 497,
			            image:videoImg,
			            dock: false  
			      });
			    }
	        }
		</script>
	</head>
	<body>
		<jsp:include page="/include/top.jsp" ></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content">
				<div class="head2 bdnone">
					<div class="s-block1"></div>
					<ul class="second-nav">
						<s:iterator value="brandList" var="bean" status="st">
							<li <s:if test="#bean.id==2">class="cur"</s:if>>
								<a href="brandDetail.do?id=${bean.id}">${bean.name}</a>
							</li>
						</s:iterator>
					</ul>
					<span>${paramMap.name }</span>
				</div>
				<!--内页头部导航结束--->
				<div class="nav2">
					<s:iterator value="#request.list" var="bean" status="st">
						<a href="brandDetail.do?id=${bean.id}" <s:if test="#bean.id==paramMap.id">class="cur"</s:if>>${bean.name}</a>
					</s:iterator>
				</div>
				<div class="kyd-report">
					<h1 class="title" id="title">
						${reportList[0].title }
					</h1>
					<div style="margin-left: 20px;margin-right: 20px;">
					<div class="video" id="flashContent">
						
					</div>
					</div>
					<div class="play-info">
						<a href="${reportList[0].path}" class="down" id="path">下载</a>
						<div class="num" id="views">
							${reportList[0].views }次
						</div>
						<div class="share-code"> 
						<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div> 
						<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":["mshare","qzone","tsina","weixin","renren","tqq","kaixin001","tqf","tieba","douban","tsohu","sqq","t163","isohu","ty","fbook","copy"],"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script> 
	
						</div>
						
					</div>
					<!--<div class="video-item-box">
						<div class="video-item">
							<ul class="v-list">
								<s:iterator value="#request.reportList" var="bean" status="st">
									<li <s:if test="#st.index==0">class="cur"</s:if> >
										<a href="javascript:;" class="v-item" reportId="${bean.id}" ><img src="${bean.image }" width="180px" height="105px"/>
										</a>
										<div class="p-bg"></div>
										<div class="font">
											正在播放
										</div>
										<div class="tit">
											${bean.title }
										</div>
									</li>
								</s:iterator>
							</ul>
						</div>
					</div>-->

					<div class="roll-warp" id="roll-warp">
						<!----------------------------滚动部分在此-------------------------------------------------->
						<div class="roll-inner">
							<table>
								<tr>
									<s:iterator value="#request.reportList" var="bean" status="st">
										<td>
											<div <s:if test="#st.index==0">class="contact_1 cur"</s:if> <s:else>class="contact_1"</s:else> >
												<a href="javascript:;" reportId="${bean.id}" class="video-pic"><img src="${bean.image }" />
												</a>
												<div class="p-bg"></div>
												<div class="font">
													正在播放
												</div>
												<div class="tit" title="${bean.title}">
													<shove:sub value="#bean.title" size="30" suffix=""/>
													
												</div>
											</div>
										</td>
									</s:iterator>
								</tr>

							</table>

						</div>
						<!-------------滚动部分在此----------------------------------------------------------------->


					</div>
					<!---包围滚动条的外层盒子---->

					<div class="kyd-info" >
						<h3>微力科技报道内容介绍</h3>
						<div id="content" style="font-size:14px;line-height:24px;">${reportList[0].content}</div>
					</div>

				</div>
				<!---微力科技报道结束--->
			</div>
			<!---main-content结束---->
		</div>
		<!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
	<script src="script/commom.js"></script>
		<script type="text/javascript">
		  $(function(){
		  		$.sideLi(".second-nav",".s-block1");
		  })
		</script>
	</body>
</html>
