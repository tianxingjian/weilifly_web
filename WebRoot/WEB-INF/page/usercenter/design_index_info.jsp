<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<script type="text/javascript" src="script/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
<script src="script/easing.js"></script>
<script>
  function makeUrl(id,tid){
     var imgUrls =  [] ;
     $(".check").each(function(i,n){
          var  bid  = $(n).attr("bid") ;
          var  btid  = $(n).attr("tid") ;
          var ckClass = $(n).attr("class")  ;
          if(tid==btid&&ckClass=="check cur"){
             imgUrls.push(bid);
          }
     });
     var imgStr = imgUrls.join(",");
     $("#batchFile"+tid).attr("href","downloadBatchFile.do?fileName=re.txt&tid="+tid+"&ids="+imgStr);
  }
  
  var t = true;
  $(function(){
  	$(".check").click(function(){
  		if(t){
  			$(this).addClass("cur");
  			t = false;
  		}else{
  			$(this).removeClass("cur");
  			t = true;
  		}
  		
  	});
  });
</script>
<div class="right-raea" style="border:1px solid #e1e1e1">
<div class="h3 h3-1">设计素材</div>
  <div class="sort">图片专区</div>
 
<s:if test="pageBean.page==null || pageBean.page.size==0">
</s:if>
<s:else>
	<s:iterator value="pageBean.page" var="bean" status="st">
		<div class="wrap-arrows">
			<em class="arrows"></em>
			<div class="fodder-box">
				<div class="tit-block">
					<a id="batchFile${bean.id}" href="downloadBatchFile.do?fileName=${bean.title}&tid=${bean.id}&ids=" class="p-down">&nbsp;</a>
					<a href="#" class="tit">${bean.title}</a>
				</div>
				<div class="time">
					<span>作者：${bean.author}</span><span>日期：<s:date
							name="#bean.addTime" format="yyyy-MM-dd " />
					</span>
				</div>
				<ul id="batchFileUl${bean.id}" class="fodder-list">
					
						<s:iterator value="#request.queryImageList" var="ben" status="st">
						<s:if test="#bean.id==#ben.tid">
							<li>
								<a href="#" class="pic"><img src="${ben.imgUrl}">
								</a>
								<a  href="javascript:makeUrl('${ben.id}','${ben.tid}');"><span bid="${ben.id}" tid="${ben.tid}" imgIndex="${imgst.count}"  class="check"></span></a>
							</li></s:if>
						</s:iterator>
					
				</ul>
			</div>
		</div>
     
		<script src="script/commom.js"></script>
	</s:iterator>
	
</s:else>
<div class="page">
		       <shove:page 
		            curPage="${pageBean.pageNum}" showPageCount="9"
					pageSize="${pageBean.pageSize}" theme="jsNumberThree"
					totalCount="${pageBean.totalNum}">
				</shove:page> 
</div>
</div>


