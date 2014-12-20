<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<script type="text/javascript">
    function changeShow() {
              $("#slider1").children(".i-t").each(function () {
                  $(this).click(function () {
                     $(this).siblings(".i-c").hide();
                     $(this).next().slideToggle("slow");
                  });
              });
    }
	changeShow();
</script>
<div class="map-list">
	<div class="hd">
		<span class="s1">售后店铺</span>
		<span class="s2">服务电话</span>
		<span class="s3">详细地址</span>
	</div>
	<div id="slider1">
		<s:if test="pageBean.page==null || pageBean.page.size==0">
			<tr align="center" class="gvItem">
				<td colspan="8">
					暂无数据
				</td>
			</tr>
		</s:if>
		<s:else>
			<s:iterator value="pageBean.page" var="bean" status="st">
				<div class="i-t open">
					<span class="s1" onclick="GetMap(${st.index+1 },'${bean.storeName }')">${bean.storeName }</span>
					<span class="s2" onclick="GetMap(${st.index+1 },'${bean.storeName }')">${bean.phone }</span>
					<span class="s3" onclick="GetMap(${st.index+1 },'${bean.storeName }')"><em class="address-btn" onclick="GetMap(${st.index+1 },'${bean.storeName }')"></em> </span>
				</div>
				<div class="i-c">
					${bean.provinceName }${bean.cityName }${bean.areaName
					}${bean.address }
				</div>

			</s:iterator>
		</s:else>
	</div>	
</div>
<div class="page" style="margin-top:30px;">
		<shove:page url="queryWebDistributeListInit.do"
			curPage="${pageBean.pageNum}" showPageCount="5"
			pageSize="${pageBean.pageSize }" theme="jsNumberThree"
			totalCount="${pageBean.totalNum}">
		</shove:page>
</div>
