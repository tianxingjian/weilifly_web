/*
*弹窗插件
*作者：Jun
*   model:''                      Iframe,DIV两种方式，默认是以div方式弹出
*   effect: ''                    显示方式为left,right,top,bottom,默认为空
*   BoxID: ''                     弹出层ID
*   Widht:420                     弹出层宽度
*   Height:400                    弹出层高度
*   Shade:true                    是否开启遮罩层
*	ShadeBackground:"#000"        遮罩层背景色
*	CloseId:"close"               关闭按钮Class,此功能用于不同关闭按钮样式
*   Palytime:500                  弹出层时间，数值越小，弹出越快，反之
*   Move:false                    盒子移动

*   备注：live方法貌似在jquery-1.9中已经移除.所以大伙在用的时候请注意你的版本！否则点击出来后是关闭不了的
*/


;(function($){
	$.fn.extend({
		Junalert:function(O){
			O = $.extend({
			    model: 'DIV',
				effect:"",
                BoxID:'boxContent',			
				Widht:600,
				Height:420,
				Shade:true,
				Padding:8,
				ShadeBackground:"#000",
				CloseId:"close",
				Palytime:400,
				Move:true
			}, O);
			var J ={
			   boxAlart:function(url,F){
			    if(F=="I"){
					var box="<div class='JunalertBox' style='width:100%;height:100%'>";
					if(O.Shade)box +="<div class='shade_bg'></div>";		
					box+= "<div id='"+O.BoxID+"'><div class='box' style='position:relative;z-index:999;'>";
					box += "<Iframe src='"+url+"' width='"+O.Widht+"' height='"+O.Height+"'></iframe>";
					box += "<div id='close' class='"+O.CloseId+"'></div></div></div></div>";
					$(document.body).append(box);
			   }else if(F=="D"){
			       $("#"+O.BoxID).wrapAll("<div class='JunalertBox' style='width:100%;height:100%' />");
			       if(O.Shade)$("<div class='shade_bg'></div>").appendTo(".JunalertBox");
			       $("<div id='close' class='"+O.CloseId+"'></div>").appendTo("#"+O.BoxID);
			   }
				var W=O.Widht-O.Padding,
					H=O.Height-O.Padding;
			    switch (O.effect){
					case "left":
					  var left=0,
						  top=($(window).height() - H)/2;
					  break;  
					case "right":
					  var left=($(window).width() + W)/2,
						  top=($(window).height() - H)/2;  
					  break;
					case "top":
					  var left=($(window).width() - W)/2,
						  top=($(window).height() - H)/2,
						  top=-top;
					  break;
					case "bottom":
					  var left=($(window).width() - W)/2,
						  top=($(window).height() + H)/2;
					  break;
					default:
					  var left=($(window).width() - W)/2,
						  top=($(window).height() - H)/2; 
					}
				
				$('.shade_bg').css({"position":"fixed","_position":"absolute","top":0,"left":0,"width":"100%","height":"100%","background":O.ShadeBackground,"opacity":0.6,"z-index":99999,"-ms-filter:progid":"DXImageTransform.Microsoft.Alpha(Opacity=60)","filter":"alpha(opacity=60)"});
				$("#"+O.BoxID).css({"position":"fixed","_position":"absolute","top":top,"left":left,"width":O.Widht,"height":O.Height,"padding":O.Padding,"z-index":999999});
			},
			    AnimateTl:function(){
					var left=($(window).width() - O.Widht-O.Padding)/2,
					    top=($(window).height() - O.Height-O.Padding)/2; 
					if(O.effect!=0){
						 $("#"+O.BoxID).animate({"opacity":1,"top":top,"left":left},O.Palytime);
					 }else{
						$("#"+O.BoxID).animate({"opacity":1},O.Palytime);
					}
		    },
			  MoveBox:function(){
                      $("#"+O.BoxID).mousedown(function(e){
					    var x,y;
						$(this).css("cursor","move"); 
						x=e.pageX-parseInt($("#"+O.BoxID).css("left"));
						y=e.pageY-parseInt($("#"+O.BoxID).css("top"));
					    $(document).mousemove(function(en){
						   var _x=en.pageX-x;
						   var _y=en.pageY-y;
							$("#"+O.BoxID).css({top:_y,left:_x});
						});
					 });
					 $(document).mouseup(function()  
					  {  
						$(this).unbind("mousemove");  
					 })  
			     }
			}
		   
		   if(O.model=='Iframe'){
				$(this).bind("click",function(){
					var url=null;
					url = $(this).attr("v_url");
					J.boxAlart(url,"I");
			     	J.AnimateTl();
			   });
			}else if(O.model=='DIV'){
			    if(O.Move)J.MoveBox();
				$(this).bind("click",function(){
					var url=null;
					$("#"+O.BoxID).css({"display":"block"});
					J.boxAlart(url,"D");
					J.AnimateTl();
			    });
			
			}
			
		   $("#"+O.CloseId).live("click",function(){
		        if(O.model=='Iframe'){
				  $(".JunalertBox").fadeOut(function (){
						 $(this).remove();
				  });
				}else if(O.model=='DIV'){
				    $(".JunalertBox .shade_bg").fadeOut(function(){
					  $(this).remove();
					});
					$("#"+O.BoxID).unwrap().removeAttr("style").css({"display":"none"}).find("#"+O.CloseId).remove();
				}
			
			});
		}
	});
})(jQuery);