$(document).ready(function () {
	var temp = false;//加载sortIndex排最前的一级菜单项
	var hasFirst = false;//二级菜单
	var hasSecond = false;//二级菜单
	var htmlContent = "";
	if(null != $("#menu").data('menuBar')){
		$("#menu").append($("#menu").data('menuBar'));//加载缓存内容
		return ;
	}
	$(document).ready(function () {
		//alert('ok');
	//alert($.hasData(menu));
	$.ajax({
        url:'frontNavigationBar.do',
        type:'POST',
        data:'',
        cache:true,
        dataType:'json',
        success:function (data) {
        	if(null!=data && data.length>0){
	        	$.each(data,function(i){
	        		var sortIndex = data[i].sortIndex;
	        		var id = data[i].id;
	        		var parentId = data[i].parentId;
	        		var name = data[i].name;
	        		var orderName = data[i].orderName;
	        		var url = data[i].url;
	        		//alert(name);
	        		//第一级
	        		if(orderName == '一级'){
	        			if(hasFirst){//连续第二个一级
	        				//$('#menu').append("</li>");
	        				htmlContent += "</li>";
	        			}
	        			if(!temp){
	        				htmlContent += "<li class=\"selected dropdown\"><a href=\""+url+"\">"+name+"</a>";
	        				//$('#menu').append(htmlContent);
	        				temp = true;
	        			}
	        			else{
	        				if(hasSecond){//进入下一个一级项
	        					//$('#menu').append("</ul></li>");
	        					htmlContent += "</ul></li>";
	        					hasSecond = false;
	        				}
	        				htmlContent += "<li><a href=\""+url+"\">"+name+"</a>";
	        				//$('#menu').append(htmlContent);
	        			}
	        			hasFirst = true;//一级结束
	        		}
	        		else if(orderName == '二级'){
	        			if(!hasSecond){
		        			//$('#menu').append("<ul>");
		        			htmlContent += "<ul>";
		        			hasSecond = true;
	        			}
	        			htmlContent += "<li><a href=\""+url+"\">"+name+"</a></li>";
	        			//alert(htmlContent);
		        		//$('#menu').append(htmlContent);
	        			hasFirst = false;
	        		}
	        	});
	        	//菜单项显示
	        	//alert($.hasData('menuBar'));
				$("#menu").append(htmlContent);
				//缓存元素数据
				$("#menu").data('menuBar',htmlContent);
				//alert($.hasData(menu));
				

        	}
        	else{
        		htmlContent = "导航栏无法加载，请重新刷新页面！";
        		//菜单项显示
        		$("#menu").append(htmlContent);
        	}
        },
        error:function () {
            alert('error');
        }
    });
    });
});