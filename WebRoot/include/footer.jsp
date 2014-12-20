<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/taglib.jsp"%>
<link href="css/Common.css" type="text/css" rel="stylesheet"/>
<link href="css/site.css" type="text/css" rel="stylesheet"/>
<style>
.bd_weixin_popup {
	height: 314px;
}
</style>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js" charset="utf-8"></script>
<script type="text/javascript" src="http://v1.ujian.cc/code/ujian.js"></script>
<div class="footer-box">
	  <div class="footer">
			<s:iterator value="infoList" var="bean" status="st">
				<div class="nav-bottom">
					<h3>
						${bean.name }
					</h3>
					<ul>
					<s:iterator value="list.{?#this.infoId==#bean.id}" var="beans" status="st">
								<li <s:if test="#bean.id==3&&#beans.title=='微信'">class="wx-ewm"</s:if>>
								<s:if test="#bean.id==5||#bean.id==1">
									<s:if test="#bean.id==5&&#beans.title=='官方商城'">
										<a href="${beans.linkPath }" target="_blank">${beans.title}</a>
									</s:if>
									<s:else>
											<a href="queryInfoContent.do?id=${beans.id }&a=${bean.id }">${beans.title}</a>
									</s:else>
								</s:if>
								<s:elseif test="#bean.id==3&&#beans.title!='微信'">
									<a href="${beans.linkPath }" target="_blank"
										style="background: url(${beans.imgUrl }) no-repeat 0 2px; padding: 0 0 2px 29px;">
										${beans.title}</a>
								</s:elseif>
								<s:elseif test="#bean.id==3&&#beans.title=='微信'">
									<a href="${beans.linkPath }" class="wx"	style="background: url(${beans.imgUrl }) no-repeat 0 2px; padding: 0 0 2px 29px;">${beans.title}</a>
									<div class="ewm-box">
										<img src="${configWeiXinMap.var }" />
									</div>
								</s:elseif>
								<s:else>
									<a href="${beans.linkPath }" target="_blank">${beans.title}</a>
								</s:else>
							</li>
						</s:iterator>
						
						<%--
						<s:if test="#bean.id==5">
							<li>
								<a href="queryRecruitInit.do">人才招聘</a>
							</li>
						</s:if>
						--%>
						<s:if test="#bean.id==3">
								<li id="bdShare" class="bdsharebuttonbox">
									<a href="#" class="bds_more share" data-cmd="more"
										style="color: #fff; font-size: 14px; line-height: 20px;">分享</a>
								</li>
						</s:if>
					</ul>
				</div>
			</s:iterator>
		  <div class="nav-bottom">
		  <%--
          <dl class="line-kf">
            <dt class="line-icon"><a href="javascript:;"><img src="images/new-qq.png"/></a></dt>
            <dd>
              <h3>在线客服</h3>
              <p><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&Uin=${paramOnLineOneMap.name }&Site=qq&Menu=yes">客服1：${paramOnLineOneMap.name }</a></p>
              <p><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&Uin=${paramOnLineTwoMap.name}&Site=qq&Menu=yes">客服2：${paramOnLineTwoMap.name }</a></p>
            </dd>
          </dl> 
          --%>
          <%--
            <dl class="line-kf">
            <dt class="line-icon"><a href="javascript:;"><img src="images/new-phone.png"/></a></dt>
            <dd>
              <h3>电话咨询</h3>
              <p>${configPhoneMap.name }</p>
            </dd>
          	</dl>
          --%>
           
        </div>
	</div>
	
	
	<div class="bottom">
		<span>深圳微力科技有限公司</span>
		<span>版权所有</span>
		<span>粤ICP备1409693号</span>
		<a href="mapInit.do?a=3a">网站地图</a>
		<script src="http://s19.cnzz.com/z_stat.php?id=1253090651&web_id=1253090651" language="JavaScript"></script>
		<s:iterator value="copyrightList" var="beanCopyRight" status="st">
			<a href="queryInfoContent.do?id=${beanCopyRight.id }&a=${beanCopyRight.infoId }">${beanCopyRight.title }</a>
		</s:iterator>
	</div>
</div>
<script>
window._bd_share_config = {
     "common": {
         "bdSnsKey": {},
         "bdText":"让老板不再被概念弄晕，让企业不再被技术牵制，让技术落地为生意所用，让技术升级保利润增长，为企业插上微翅膀，让生意更轻松！",
         "bdMini": "2",
         "bdMiniList": false,
         "bdPic": "",
         "bdStyle": "0",
         "bdSize": "22"
     },
     "share": {},
};  
with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];     
</script>
<!--底部结束-->