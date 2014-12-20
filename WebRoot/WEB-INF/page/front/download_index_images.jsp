<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${seoMap.seoTitle}</title>
		<meta name="keywords" content="${seoMap.seoKeyWord}"/>
		<meta name="description" content="${seoMap.seoDescription}" />
		<link href="css/Common.css" type="text/css" rel="stylesheet"/>
		<link href="css/site.css" type="text/css" rel="stylesheet"/>
		<script src="script/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
		<script src="script/jquery.slider.js"></script>
		<script src="script/easing.js"></script> 

		<script type="text/javascript">
			$(function(){
				//$('#pic-list-s').Slider();
				$(".path").click(function(){
					window.location.href = "downloadProgram.do?filePath="+$(this).attr("path");
				});
				
				$("li[name=li]").click(function(){
					$("li[name=li]").removeClass("cur");
					$(this).addClass("cur");
				});
				   $("#pic-list-s").Slider(); 
			});
			function productTab(pcId){
				$("li[name ^= divCategory_]").hide();
				$("li[name=divCategory_"+pcId+"]").show();
			}

			    

		</script>
	</head>
	<body>
		<jsp:include page="/include/top.jsp"></jsp:include>
		<!--头部外围盒子结束 head-box-->
		<div class="content">
			<div class="main-content3 clearfix" style="border: 0; width: 1000px;">
				<div class="left-box left-box-1">
					<div class="m-s-ban1">
						资料下载
					</div>
					<div class="n-s-nav n-s-nav-1">
						<div class="s-block"></div>
						<ul>
							<s:iterator value="#request.categoryList" var="bean" status="st">
								<li <s:if test="#st.index==0">class="cur"</s:if> name="li">
									<a href="javascript:productTab(${bean.id});" class="pcp" pcId="${bean.id}">${bean.name}</a>
								</li>
							</s:iterator>
						</ul>
					</div>

					<div class="pic-list-s" id="pic-list-s">
						<em class="left" id="lefta"></em>
						<em class="right" id="righta"></em>
						 <div class="roll-box">
						<ul class="roll-list">
							<s:iterator value="#request.categoryList" var="bean" status="st">
								<s:iterator value="#request.productList.{?#this.categoryId==#bean.id}" var="beans" status="sta">
									<s:if test="#st.index==0"><li style="display: block;" name="divCategory_${bean.id }" class="ssa"></s:if>
									<s:else><li style="display: none;" name="divCategory_${bean.id }" class="ssa"></s:else>
										<a href="materialsIndex.do?id=${beans.id}" class="pic"><img src="${beans.image}" />
										</a>
										<div class="title">
											<a href="materialsIndex.do?id=${beans.id}">${beans.name}</a>
										</div>
										</li>
								</s:iterator>
							</s:iterator>
						</ul>
						</div>
					</div>
					<div class="m-s-ban m-s-ban-1">
						<a href="preDownloadIndex.do">more+</a>升级程序
					</div>
					<ul class="down-list">
						<s:iterator value="#request.coursewareList" var="bean" status="st">
							<li>
								<a href="javascript:;" class="tit">${bean.name}</a>
								<div class="other">
									<span><s:date name="#bean.addTime" format="yyyy-MM-dd HH:mm:ss" /></span><a href="javascript:;" class="path" path="${bean.path}">下载</a>
								</div>
							</li>
						</s:iterator>
					</ul>


				</div>
				<!---左侧列表结束--->
				<div class="right-box">
					<div class="m-s-ban" style="border: 1px solid #e1e1e1;">
						<a href="queryDownloadHelpInit.do">more+</a>下载帮助
					</div>
					<s:iterator value="#request.downloadHelpList" var="bean" status="st">
						<div class="down-item-list">
							<!-- <dt>
								<a href="queryDownloadHelpInit.do?id=${bean.id}"><img src="${bean.image }" alt="${bean.title}" style="width:57px;height:57px;" /></a>
							</dt>
							<dd>
								适用机型：
								<span title="${bean.fit}">${bean.fit}</span>
							</dd> -->
							<a href="queryDownloadHelpInit.do?id=${bean.id}"><img src="${bean.image }" alt="${bean.title}" style="width:264px;height:73px;" /></a>
						</div>
					</s:iterator>
					<div class="m-s-ban m-s-ban-1">
						<a href="advertiseIndex.do">more+</a>App专区
					</div>
					<s:iterator value="#request.advertiseList" var="bean" status="st">
						<div class="ad-video">
							<a href="#" class="pic"><img src="${bean.image}" /><span
								class="play">播放</span>
							</a>
							<!--downloadAndroidMaterials.do?id=${bean.id }   downloadIosMaterials.do?id=${bean.id}
							 -->
							<div class="bk-btn"><a target="_blank" href="${bean.androidPath}"  class="Android">安卓</a>
							<a  target="_blank" href="${bean.iosPath}" class="ios">IOS</a>
							<span class="wx"><em class="img">
							<img src="${maMap.var}"/>
							</em></span></div>
							</div>

					</s:iterator>

				</div>


			</div>
			<!--内容区域main-content 结束-->
		</div>
		<!--内容区域结束-->
		<jsp:include page="/include/footer.jsp"></jsp:include>
		<!--底部结束-->
	    <script src="script/commom.js"></script>
		<script type="text/javascript">
		  $(function(){
		  		$(".nav li:eq(2)").addClass("cur");
		  		$.sideLi(".nav",".sliding-block");
		  		$.sideLi(".n-s-nav-1",".s-block","click");
		  })
		</script>
	    <script >
$(function(){
    $(".nav li:eq(2)").addClass("cur");
    $.sideLi(".nav",".sliding-block");
    $.sideLi(".n-s-nav",".s-block");
})

</script>



	</body>
</html>
