<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
<script src="script/easing.js"></script>
<script>
  function makeUrl(id){
     var imgUrls =  [] ;
     $(".check").each(function(i,n){
          var  bid  = $(n).attr("bid") ;
          var ckClass = $(n).attr("class")  ;
           var imgIndex = $(n).attr("imgIndex")  ;
          if(id==bid&&ckClass=="check cur"){
             imgUrls.push(imgIndex);
          }
     });
     var imgStr = imgUrls.join(",");
     $("#batchFile"+id).attr("href","downloadBatchFile.do?fileName=re.txt&id="+id+"&imgUrls="+imgStr);
  }
</script>
<s:if test="pageBean.page==null || pageBean.page.size==0">
</s:if>
<s:else>
	<s:iterator value="pageBean.page" var="bean" status="st">
		<div class="wrap-arrows">
			<em class="arrows"></em>
			<div class="fodder-box">
				<div class="tit-block">
					<a id="batchFile${bean.id}" 
						href="downloadBatchFile.do?fileName=re.txt&id=${bean.id}&imgUrls="
						class="p-down">&nbsp;</a><a href="#" class="tit">${bean.title}</a>
				</div>
				<div class="time">
					<span>作者：${bean.author}</span><span>日期：<s:date
							name="#bean.addTime" format="yyyy-MM-dd " />
					</span>
				</div>
				<ul id="batchFileUl${bean.id}" class="fodder-list">
					<s:if test="#bean.imgList!=null&&#bean.imgList.size()>0">
						<s:iterator value="#bean.imgList" var="imgbean" status="imgst">
							<li>
								<a href="#" class="pic"><img src="${imgbean}">
								</a>
								<a  href="javascript:makeUrl('${bean.id}');"><span bid="${bean.id}" imgIndex="${imgst.count}"  class="check"></span></a>
							</li>
						</s:iterator>
					</s:if>
				</ul>
			</div>
		</div>
		<script src="script/commom.js"></script>
	</s:iterator>
</s:else>
<div class="page">
	   <td colspan="4">
		       <shove:page 
		            curPage="${pageBean.pageNum}" showPageCount="9"
					pageSize="${pageBean.pageSize}" theme="jsNumberThree"
					totalCount="${pageBean.totalNum}">
				</shove:page> 
         </td>
</div>



