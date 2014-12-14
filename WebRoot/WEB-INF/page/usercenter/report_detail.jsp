<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<div class="h3" style="margin: 0;">
	质检报告
</div>
<div class="h4">
	<a href="javascript:checkItem('','','${paramMap.categoryId}',1)"
		class="fh-btn">&nbsp;</a>${paramMap.name}
</div>

<dl class="zj-list">
	<dt>
		<a href="#"><img src="${paramMap.image}" />
		</a>
	</dt>
	<dd>
		<a href="#" class="tit">${paramMap.title }</a>
		<div>
			${paramMap.author }
		</div>
		<div>
			${paramMap.addTime }
		</div>
		<a href="downloadFiles.do?fileName=re.txt&id=${paramMap.id}" class="down-btn">下载</a>
	</dd>
</dl>
