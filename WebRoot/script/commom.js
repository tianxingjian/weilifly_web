// JavaScript Document


$(function(){
	$(window).scroll(function() {
		if($(window).scrollTop()>=50){
			$('.back-top').show();
			 $('.suspend-box').show();
		}else{
			$('.back-top').hide();
			$('.suspend-box').hide();
		} 
 	 });
    bools=true;
  	$(".back-top").click(function(){
	 	$('html,body').animate({scrollTop:0},'slow'); 
	});
	$("#jt").click(function(){
	    if(bools){
	      $('.suspend-box').animate({'right':-88},'slow'); 
	        bools=false;
	 	}else{
	 	   $('.suspend-box').animate({'right':0},'slow'); 
	        bools=true;
	 	}
	});
  
	 function Iphone(){ 
var roul=$('.phone-inner ul'), 
roula=$('.h3-4-box ul'), 
roulb=$('.p-n-box ul'), 
speed=800, 
s1='swing', 
s2='easeOutBounce', 
s3='easeOutBack'; 

	$('.nav-bottom .wx').hover(function(){
		$(this).parents('.nav-bottom').find('.ewm-box').show();
	},function(){	
		$(this).parents('.nav-bottom').find('.ewm-box').hide();	
	});	
	
$('.zn-hu-box .pre').click(function(){ 
roul.prepend(roul.find('li:last')).css('left',-194); 
roul.stop().animate({left:0},speed); 
roula.prepend(roula.find('li:last')).css('left',-167); 
roula.stop().animate({left:0},speed); 
roulb.prepend(roulb.find('li:last')).css('left',-200); 
roulb.stop().animate({left:0},speed); 
}); 

$('.zn-hu-box .next').click(function(){ 
roul.stop().animate({left:-194},speed,function(){ 
$(this).append(roul.find('li:first')).css('left',0);	
}); 
roula.stop().animate({left:-167},speed,function(){ 
$(this).append(roula.find('li:first')).css('left',0);	
}); 
roulb.stop().animate({left:-200},speed,function(){ 
$(this).append(roulb.find('li:first')).css('left',0);	
}); 
}); 
} 
Iphone();
var objimg=$('#imgess li');			
function cp_tab(ies){//产品列表 自动淡入淡出
objimg.stop(true,false).animate({opacity:0},1000,'easeInSine').eq(ies)
.stop(true,false).animate({opacity:1},1000,'easeInSine');	
}
objimg.css({"opacity":0}).eq(0).css({"opacity":1});
var ies=0,len=objimg.length;
setInterval(function(){
	ies++;
	if(len==ies)ies=0;
	cp_tab(ies)
}, 4000);

$('.cp-pic-tab li').click(function(){//产品列表 诊断提升
    $(this).addClass('cur').siblings().removeClass('cur');
	$('.cp-tab-content li').eq(
	$('.cp-pic-tab li').index(this)
	).show().siblings().hide();
});

$('.cp-pic-tab2 li').click(function(){//产品列表 真人在线
     $(this).addClass('cur').siblings().removeClass('cur');
	$('.cp-pic-tab2-content li').eq(
	$('.cp-pic-tab2 li').index(this)
	).show().siblings().hide();
});


	

	$('.search input').focus(function(){//搜索栏
	
	if($(this).val()==this.defaultValue){
	$(this).val("");
	}
	}).blur(function(){
	if($(this).val()==""){
	$(this).val(this.defaultValue);
	}  
	});
	
	
	$('.inner-search input').focus(function(){//搜索栏
	
	if($(this).val()==this.defaultValue){
	$(this).val("");
	}
	}).blur(function(){
	if($(this).val()==""){
	$(this).val(this.defaultValue);
	}  
	});
	
	$('.a-search input').focus(function(){//搜索栏
	
	if($(this).val()==this.defaultValue){
	$(this).val("");
	}
	}).blur(function(){
	if($(this).val()==""){
	$(this).val(this.defaultValue);
	}  
	});		

	

//去掉末尾的边	
$('.down-list li:last').css('border','none');
$('.right-box .down-item-list:last').css('border-bottom','3px solid #e1e1e1');	
$('.right-box .down-item:last').css('border-bottom','3px solid #e1e1e1');	
$('.right-box .ad-video:last').css('border-bottom','3px solid #e1e1e1');	
$('.Update-box:last').css('margin-bottom','40px');
$('.cp-dp li:last').css('border','none');
$('.web-map:last').css('border','none');	

//全选的
$('.dd-list .check').click(function(){
	
	$(this).toggleClass('cur0');

	
	});
	
$('.handle dt span').click(function(){
	
	$(this).toggleClass('cur1');
	});	


$('.map-tab span').click(function(){
	
  $(this).addClass('cur').siblings().removeClass('cur');	
	$('.map-content .t-map-c').eq(
	$('.map-tab span').index(this)
	).show().siblings().hide();
});


$('.news-box li').hover(function(){//华普报淡入淡出

$(this).find('.shade-bg').stop().animate({opacity:0.5},1000);	   
$(this).find('.txt').show();   

},function(){
	
$(this).find('.shade-bg').stop().animate({opacity:0},1000);	   
$(this).find('.txt').hide();   
});
	     




$('.wrap-arrows .arrows').each(function(){//素材列表
	
	var H=$('.fodder-list').outerHeight();	
	var Ha=$('.tit-block').outerHeight();
	var Hao=$('.fodder-box .time').outerHeight();
	var AllHeight=H+Ha+Hao;
	var ac=true;
	
	$(this).bind('click',function(){
		
		if(ac){
	$(this).parents('.wrap-arrows').find('.fodder-box').animate({height:AllHeight},800);
	ac=false;
	}else{
	ac=true;
	$(this).parents('.wrap-arrows').find('.fodder-box').animate({height:248},800);
	}

	});
	
});

$('.right-raea .fodder-list .pic').each(function(){//素材图片弹出
	var newsrc=$(this).find('img').attr('src');
	//alert(newsrc)
	$(this).click(function(){
		$('.img-bg').show();
		$('.img-bg').show()
		$('.img-bg').before("<div class='shade-bg'></div>");
		$('.img-bg').find('img').attr('src',newsrc)
	
		});
	
});

$('.img-bg .close').click(function(){
	
	$(this).parents('.img-bg').hide();
	$(this).parents('.img-bg').prev('.shade-bg').remove();

	});

//$(window).scroll(function(){
//if($(".img-bg").css("display")!="none"){//弹出窗口时不允许滚动条滚动
//     $(window).scrollTop(0);
//    }
//    });




$('.fodder-list .check').click(function(){//选中的
	
	$(this).toggleClass('cur');
	
	});


var alicc=$('.nav-item .check');
	alicc.each(function(){
		$(this).click(function(){
			$(this).parent('li').addClass('cur').siblings().removeClass('cur');
			$(this).parent('li').find('.s2-nav-item').stop().slideDown(600).end().siblings().find('.s2-nav-item').slideUp(600);
			});
		});


	
	
	
	$.extend({
 		sideLi:function(obj,cur,m){
 		var sula=$(obj);
 		var slia=sula.find("li");
 		var sblock=$(cur);
 		
 		var curobj=sula.find(".cur");
 		var s_curW=curobj.outerWidth();
 		var curLeft=curobj.position().left;
	    sblock.css({"width":s_curW,"left":curLeft});
	    if(m=="click"){
		  slia.click(function(){
			 var s_w=$(this).find("a").outerWidth();
			    sblock.css('width',s_w);
				position=$(this).position().left;
			    sblock.css({"width":s_w}).stop(true,false).animate({left:position},300);
			    $(this).addClass('cur').siblings().removeClass();
			});
		}else{
			slia.hover(function(){
			    var s_w=$(this).find("a").outerWidth();
				    sblock.css('width',s_w);
					position=$(this).position().left;
					sblock.stop(true,false).animate({left:position},300);
			},function(){
			    var s_w=$(this).find("a").outerWidth(),
			       position=$(this).position().left;
			      // sblock.css({left:position});
				  sblock.css({"width":s_curW}).stop(true,false).animate({left:curLeft},300);
			});
		    slia.click(function(){
			  $(this).addClass('cur').siblings().removeClass();
			});
		}
        
    	}
 		
 	});

			$(function(){
			  $.sideLi(".nav",".sliding-block");
			});
		
		  $(function(){
		   //$.sideLi(".n-s-nav",".s-block")//下载
		  });
		  $(function(){
		    // $.sideLi(".second-nav",".s-block1")//品牌
		  });
		
		
	
 
    $('.zp-nav span').click(function(){//校园招聘，社会招聘
	 $(this).addClass('cur').siblings().removeClass();	
	 $('.zp-list-box .zp-c-wrap').eq(
	  $('.zp-nav span').index(this)
	 ).show().siblings().hide();	
		
		});
     
 
 

 
 
 $('.cp-syn li').click(function(){//产品综合页面tab切换
	 $(this).addClass('cur').siblings().removeClass();
	$('.tab-con .cp-info-txt').eq(
	$('.cp-syn li').index(this)
	).show().siblings().hide(); 
});
 
 
 
 //代理商专区 质检报告
 $('.zp-nav-1 span').click(function(){
	 
  $(this).addClass('cur').siblings().removeClass();	 
  $('.m-zjbg-box table').eq(
      $('.zp-nav-1 span').index(this)
  ).show().siblings().hide();	 
	 
	 
});
 
 


});

 	var Jobsmore=function(obj){
 		var parli=$(obj).parents('.zp-list-box li');
			$(obj).toggleClass('cur');  
			parli.find('.txt-box').slideToggle();
			parli.toggleClass('cur');
			parli.find('.close').toggleClass('cur');
 		
 	};
