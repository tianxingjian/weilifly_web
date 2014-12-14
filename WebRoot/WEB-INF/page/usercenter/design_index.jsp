<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${seoMap.seoTitle}</title>
<link href="css/Common.css" type="text/css" rel="stylesheet"/>
<link href="css/site.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="script/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="script/jquery.shove-1.0.js"></script>
<script src="script/easing.js"></script>
<script type="text/javascript">



  var param = {} ;
  var item_type = 1 ;
  var categoryId;
      $(function(){
                 $("#reportck").attr("class","cur");
		 		 param["pageBean.pageNum"] = 1;
				 initListInfo(param);
       });
	function initListInfo(param){
			param["paramMap.item_type"] = item_type;
			param["paramMap.categoryId"] = categoryId;
	             $.shovePost( "queryFrontReportInfo.do" ,param,function(data){
	                 $("#dataInfo").show().html(data);
	               });
		 	}
    	function initCallBack(data){
				$("#dataInfo").html(data);
			}
	
   function checkItem(obj,id,catId,type){
       item_type  = type ;
       categoryId = catId;
       if(type==1){
           $(".s2-nav-item").hide();
           $("#reportck").attr("class","cur");
           $("#desginck").removeAttr("class");
           var  param  =  {} ;
           param["paramMap.categoryId"] = catId ;
           param["paramMap.item_type"] = type ;
           initListInfo(param);
            $("#desiginUl").children().each(function(i,n){
               $(n).removeAttr("class");
           });
       }
       if(type==2){
           var  param  =  {} ;
           $(".s2-nav-item").show();
           $("#desginck").attr("class","cur");
           $("#reportck").removeAttr("class");
           var firstCat  = "${firstCatMap.id}" ;
           if(firstCat==catId){
              $("#cat"+catId+"").attr("class","cur");
           }
           $(obj).prevAll().each(function(i,n){
               $(n).removeAttr("class");
           });
            $(obj).nextAll().each(function(i,n){
               $(n).removeAttr("class");
           });
           $(obj).attr("class","cur");
           param["paramMap.categoryId"] = catId ;
           param["paramMap.item_type"] = type ;
           initListInfo(param);
       }
       if(type==3){
           var  param  =  {} ;
           param["paramMap.item_type"] = type ;
            param["paramMap.id"] = id ;
           initListInfo(param);
       }
       
   }
</script>
<style type=text/css>
.nav-item  .cur a{color:#23ac38; border-left:3px solid #23ac38;}
</style>
</head>
<div class="img-bg">
<div class="close">&nbsp;</div>
 <img src="images/cp1.jpg"/>
</div>
<body>
<jsp:include page="/include/top.jsp"></jsp:include>
<!--头部外围盒子结束 head-box-->
<input type="hidden" id="itemId" />
<input type="hidden" id="catId" />
<input type="hidden" id="itemUrl" />
<div class="content" style="background:#fff;">
    <div class="main-content clearfix" style="border:none;">
        <div class="left-raea">
            <div class="h3">代理商专区</div>
            <div class="left-nav ">
                <ul class="nav-item">
                 <li id="reportck" onclick="checkItem('','1','',1)"><a href="javascript:">质检报告</a>
                 </li>
                 <li id="desginck" ><a onclick="checkItem('','${firstCatMap.id}','${firstCatMap.id}',2)" href="javascript:"  class="check">设计素材</a>
                     <ul id="desiginUl" class="s2-nav-item"   >
                     <s:iterator  value="#request.queryDesignCategoryList" var="beans" status="sta">
                       <li id="cat${beans.id}" onclick="checkItem(this,'${beans.id}','${beans.id}',2);"  ><a  href="javascript:">${beans.name}</a></li>
                      </s:iterator>
                     </ul> 
                 </li>
                </ul>    
            </div>
        </div>
        <!--左侧导航结束--->
        <div class="right-raea" >
             <div id="dataInfo"></div>
        </div><!--右侧导航结束---> 
    </div>
    <!--内容区域main-content 结束--> 
</div>
<!--内容区域content 结束-->
<jsp:include page="/include/footer.jsp"></jsp:include>
<script src="script/commom.js"></script>
<!--底部结束-->
</body>
</html>
