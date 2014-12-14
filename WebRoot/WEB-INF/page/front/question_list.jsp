<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<ul>
	<s:if test="pageBean.page==null || pageBean.page.size==0">
		<tr align="center" class="gvItem">
			<td colspan="8">
				暂无数据
			</td>
		</tr>
	</s:if>
	<s:else>
		<s:iterator value="pageBean.page" var="bean" status="st">
			<li>
				<div class="qa-1 clearfix">
					<h3>
						${bean.name }
					</h3>
				</div>
				<div class="txt-box clearfix">
					<span class="close"></span>
					<div class="txt">
						${bean.solution }
					</div>
				</div>
			</li>
		</s:iterator>
	</s:else>
</ul>
<div class="page">
	<shove:page url="queryQuestionListInit.do"
		curPage="${pageBean.pageNum}" showPageCount="10"
		pageSize="${pageBean.pageSize }" theme="jsNumberThree"
		totalCount="${pageBean.totalNum}">
	</shove:page>
</div>
<!--qa-box结束  -->
		<script type="text/javascript">
		  $(function(){
		      $(".qa-box li").each(function(i){
		          var qa= $(this).find(".qa-1");
		            qa.bind("click",function(){
		               var box=$(this).siblings(),h=box.height(),w=box.width(),
		                   left=($(window).width()-w)/2,
		                   top=($(window).height()-h)/2;
		               $("body").append("<div class='shade_bg'></div>");
		                box.css({"display":"block","left":left,"top":top});
		           })
		            $(".close").bind("click",function(){
		               var _this=$(this);
		               _this.parents(".txt-box").fadeOut(function(){
		                  $(".shade_bg").remove();
		                  _this.parents(".txt-box").removeAttr('style').css({"display":"none"})
		               })
		           })
		      })
		  })
		</script>
<script type="text/javascript" src="script/commom.js"></script>
<script type="text/javascript" src="script/easing.js"></script>
