<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${paramMap.seoTitle }</title>
		<meta name="keywords" content="${paramMap.seoKeywords }" />
		<meta name="description" content="${paramMap.seoDescription }" />
		<link href="css/Common.css" type="text/css" rel="stylesheet" />
		<link href="css/site.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="script/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="script/jquery.slider.js"></script>
		<script type="text/javascript"
			src="kindeditor/plugins/jwplayer/jwplayer.js"></script>
		<script src="script/easing.js"></script>
		<script src="script/commom.js"></script>
		<script>
		var thePlayer;
		$(function(){
			$("#imgul-box").Slider({
				   preid:"pre",
				   nextid:"next",
				   moveparent:"#ul-wrap",
				   m:6
				})
		})
		
		function videoInit(videoPath,videoImg){
	        	if(videoPath!=''){
			        thePlayer = jwplayer('flashContent').setup({  
			            flashplayer: 'kindeditor/plugins/jwplayer/player.swf',  
			            file: videoPath,  
			            width: 440,  
			            height: 366,
			            image:videoImg,
			            dock: false  
			      });
			    }
	        }
	</script>
	</head>

	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-contents3 main-content-2">

				<div class="n-s-nav1">
					<s:if test="paramMap.isShow==1">
						<a href="${paramMap.url}" class="buy-btn" target="_blank">点击购买</a>
					</s:if>
					<div class="s-block"></div>
					<div class="l">
						<ul>
							<s:iterator value="#request.productList" var="bean">
								<li <s:if test="#bean.id==paramMap.id">class="cur"</s:if>>
									<a href="productDetail.do?id=${paramMap.categoryId}&pid=${bean.id}"
										style="font-size: 16px;">${bean.name}</a>
								</li>
							</s:iterator>
							
						</ul>
						<div class="cp-more">
							<s:if test="#request.productMoreList!=null&&#request.productMoreList.size>0">
								<a href="javascript:void(0);">更多产品</a>
							</s:if>
							<div class="cp-m-list">
								<s:iterator value="#request.productMoreList" var="beans">
									<a href="productDetail.do?id=${paramMap.categoryId}&pid=${beans.id}">${beans.name}</a>
								</s:iterator>
							</div>
						</div>
					</div>
					
				</div>
				<!---产品导航结束--->



				<div class="text-editing">
					<div class="cp-main-box">
						${paramMap.details}
					</div>
					<s:iterator value="#request.productDetailList.{?#this.parentId<0}"
						var="bean" status="st">
						<s:if
							test="#bean.type==1||#bean.type==2||#bean.type==6||#bean.type==11">
							<div class="cp-main-box">
						</s:if>
						<s:else>
							<div class="cp-main-box clearfix">
						</s:else>
						<s:if test="#bean.type==1">
							<!-- 图文详情 -->
							<div class="clearfix cp-bk-box"
								style="background: url(${bean.backImage}) no-repeat center top; padding: 130px 0 0 0">
								<div class="bk-wp">
									${bean.content}
								</div>
							</div>
						</s:if>
						<s:if test="#bean.type==2">
							<!-- 手机滑动效果 -->
							<div class="bk-wp">
								<div class="zn-hu-box cp-bk-box pd50"
									style="background: url(${bean.backImage}) no-repeat center top; padding: 130px 0 0 0">
									<div class="phone-box">
										<div class="phone-inner">
											<ul>
												<s:iterator
													value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==12}"
													var="sBean">
													<li>
														<img src="${sBean.image}" />
													</li>
												</s:iterator>
											</ul>
										</div>
									</div>
									<!--手机结束-->
									<div class="font-inner">
										<div class="h3-4-box">
											<ul>
												<s:iterator
													value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==12}"
													var="sBean">
													<li>
														${sBean.name}
													</li>
												</s:iterator>
											</ul>
										</div>
										<div class="p-n-box">
											<ul>
												<s:iterator
													value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==12}"
													var="sBean">
													<li>
														${sBean.introduction}
													</li>
												</s:iterator>
											</ul>
										</div>
									</div>
									<div class="aw pre"></div>
									<div class="aw next"></div>
								</div>
							</div>
						</s:if>
						<s:if test="#bean.type==3">
							<!-- 图片切换效果 -->
							<div class="bk-wp">
								<div class="cp-bk-box"
									style="background: url(${bean.backImage}) no-repeat center top; padding: 130px 0 0 0">
									<ul class="cp-tab-pic" id="imgess">
										<s:iterator value="#bean.images" var="sBean">
											<li>
												<img src="${sBean}" />
											</li>
										</s:iterator>
									</ul>
									<div class="cp-txt-info">
										${bean.content}
									</div>
								</div>
							</div>
						</s:if>
						<s:if test="#bean.type==4">
							<!-- 视频播放 -->
							<div class="bk-wp">
								<div class="cp-bk-box"
									style="background: url(${bean.backImage}) no-repeat center top; padding: 130px 0 0 0">
									<div
										style="width: 440px; height: 366px; float: left; margin: 0 0 86px 75px;">
										<div class="cp-video-box" id="flashContent"
											path="${bean.introduction}" images="${bean.image}">
										</div>
										<script type="text/javascript">
							videoInit($("#flashContent").attr("path"),$("#flashContent").attr("images"));
						</script>
									</div>
									<div class="cp-txt-info cp-txt-info-1 clearfix">
										${bean.content}
									</div>
								</div>
							</div>
						</s:if>
						<s:if test="#bean.type==5">
							<!-- 诊断提升 -->
							<div class="bk-wp">
								<div class="cp-bk-box pd130"
									style="background: url(${bean.backImage}) no-repeat center top">
									<ul class="cp-pic-tab">
										<s:iterator
											value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==8}"
											var="sBean" status="st">
											<li <s:if test="#st.index==0">class="cur"</s:if>>
												<em>${sBean.name}</em>
											</li>
										</s:iterator>
									</ul>
									<ul class="cp-tab-content">
										<s:iterator
											value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==8}"
											var="sBean" status="st">
											<li <s:if test="#st.index>0">style="display: none;"</s:if>>
												${sBean.content}
											</li>
										</s:iterator>
									</ul>
								</div>
							</div>
						</s:if>
						<s:if test="#bean.type==6">
							<!-- 真人老师在线 -->
							<div class="bk-wp">
								<div class="cp-bk-box"
									style="background: url(${bean.backImage}) no-repeat center top; padding: 130px 0 0 0">
									<ul class="cp-pic-tab2">
										<s:iterator
											value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==9}"
											var="sBean" status="st">
											<li <s:if test="#st.index==0">class="cur"</s:if>>
												<em>${sBean.name}</em>
											</li>
										</s:iterator>
									</ul>
									<ul class="cp-pic-tab2-content">
										<s:iterator
											value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==9}"
											var="sBean" status="st">
											<li <s:if test="#st.index>0">style="display: none;"</s:if>>
												${sBean.content}
											</li>
										</s:iterator>

									</ul>
								</div>
							</div>
						</s:if>
						<s:if test="#bean.type==11">
							<!-- 放大镜  -->
							<div class="cp-bk-box"
								style="background: url(${bean.backImage}) no-repeat center top; padding: 130px 0 0 0">
								<div class="xueba-txt">
									${bean.content}
								</div>
								<!--<div class="kyd-box">
		                <div id="webpage">
		                <img src="${bean.image}" width="819" height="410" alt="Web Page"/>
		                <div id="retina" class="chrome" style="background: url(${bean.image}) no-repeat center center white;"></div>
		                </div>
		            </div>-->
								<div class="zoomPan" id="zoomPan">
									<div class="img">
										<img src="${bean.image}" alt="" />
									</div>
									<div id="zoom" class="zoom">
										<img src="${bean.image}" alt="" />
									</div>
								</div>
							</div>
							<script type="text/javascript">
					//<![CDATA[
					function zoomBox() {
					    this.index.apply(this, arguments)
					}
					zoomBox.prototype = {
					    index: function(win,zoom) {
					        var win=document.getElementById(win);
					        var box=document.getElementById(zoom);
					        var img=box.getElementsByTagName('IMG')[0];
					        var zoom=img.width/win.getElementsByTagName('IMG')[0].width;
					        var z=Math.round(box.offsetWidth/2);
					        win.onmousemove=function (e){
					            e = e || window.event;
					            var x=e.clientX,y=e.clientY, ori=win.getBoundingClientRect();
					            if (x>ori.right+20||y>ori.bottom+20||x<ori.left-20||y<ori.top-20)box.style.display='none';
					            x-=ori.left;
					            y-=ori.top;
					            box.style.left=x-z+'px';
					            box.style.top=y-z+'px';
					            img.style.left=-x*zoom+z+'px';
					            img.style.top=-y*zoom+z+'px';
					        }
					        win.onmouseover=function (){box.style.display=''}
					    }
					};
					window.onload=function (){
					    x=new zoomBox('zoomPan','zoom')
					}
					 //]]>
					</script>
						</s:if>
						<s:if test="#bean.type==7">
							<!-- 硬件配置 -->
							<div class="bk-wp">
								<div class="Img-tab-box cp-bk-box pd"
									style="background: url(${bean.backImage}) no-repeat center top; padding: 130px 0 0 0">
									<div class="IMG-BOX">
										<img src="images/IMG/001.png" id="image" />
									</div>
									<div class="imgul-box clearfix" id="imgul-box">
										<div class="pre qh" id="pre"></div>
										<div class="next qh" id="next"></div>
										<div class="ul-wrap">
											<ul class="clearfix" id="ul-wrap">
												<s:iterator
													value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==10}"
													var="sBean" status="st">
													<li <s:if test="#st.index==0">class="ssa cur"</s:if>
														<s:else>class="ssa"</s:else> index="${st.index}">
														<div class="pic">
															<img src="${sBean.image}" id="pic_${st.index}" />
														</div>
													</li>
													<div id="content_${st.index}" style="display: none;">
														${sBean.content}
													</div>
												</s:iterator>
											</ul>
										</div>
										<script type="text/javascript">
								$("#image").attr("src",$("#pic_0").attr("src"));
							</script>
									</div>
									<!--imgul-box 结束-->
									<div class="cpinfo-main">
										<s:iterator
											value="#request.productDetailList.{?#this.parentId==#bean.id&&#this.type==10}"
											var="sBean" status="st">
											<s:if test="#st.index==0">
									${sBean.content}
								</s:if>
										</s:iterator>
									</div>
									<!--产品参数--->
								</div>
								<!--硬件配置结束-->
							</div>
						</s:if>
				</div>
				<!--单个展示页盒子-->
				</s:iterator>
				<s:if test="paramMap.isShow==1">
					<div class="text-bi">
						<a href="productCompare.do?id=${categoryMap.id}" class="bi">对比所有${categoryMap.name}</a>
					</div>
				</s:if>
			</div>
			<!--内容区域main-content 结束-->

			<ul class="cpdb-ul" style="overflow: hidden;">
				<li>
					<a href="queryWebDistributeListInit.do" class="s1">售点分布</a>
				</li>
				<li>
					<a href="#" class="s2">电话咨询<span>400-678-0315</span>
					</a>
				</li>
				<li>
					<a href="#" class="s3"
						style="line-height: 20px; padding: 19px 0 0 117px;">在线咨询<span>${paramNumOneServiceMap.name
							}</span>
					</a>
				</li>
				<li>
					<a href="${categoryMap.url}" class="s4" target="_blank">产品综合讨论区</a>
				</li>
			</ul>
		</div>
	</div>
		<!--内容区域content 结束-->

		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
		<script type="text/javascript">
			$('.ul-wrap ul li').click(function(){//产品列表 硬件配置
			var smallsrc=$(this).find('.pic img').attr('src');
			$(this).addClass('cur').siblings().removeClass('cur');	
		    $('.IMG-BOX').find('img').attr('src',smallsrc);
		    var index = $(this).attr("index");
		    $(".cpinfo-main").html($("#content_"+index).html());
			});	
			$(function(){
			    $(".nav li:eq(1)").attr("class","cur");
			    $.sideLi(".n-s-nav1",".s-block");
			})
		</script>

	</body>
</html>
