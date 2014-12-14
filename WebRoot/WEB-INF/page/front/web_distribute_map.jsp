<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
}
.winLeft {
	width: 100px;
	float: left;
	display: inline;
}

.winRight {
	margin-left: 10px;
	width: 240px;
	display: inline;
	float: left;
	line-height: 24px;
}

.iw_poi_title {
	color: #CC5522;
	font-size: 14px;
	font-weight: bold;
	overflow: hidden;
	padding-right: 13px;
	white-space: nowrap;
	padding-bottom: 40px;
}

.iw_poi_phone {
	font: 12px arial, sans-serif;
	white-space: -moz-pre-wrap;
	word-wrap: break-word;
}

.iw_poi_content {
	font: 12px arial, sans-serif;
	overflow: visible;
	padding-top: 4px;
	white-space: -moz-pre-wrap;
	word-wrap: break-word;
}

</style>
<div id="allmap" style="width: 100%; height: 519px;"></div>

<script type="text/javascript">

                          //创建和初始化地图函数：
                 function initMap() {
                     createMap(); //创建地图
                     setMapEvent(); //设置地图事件
                     addMapControl(); //向地图添加控件
                     addMarker(); //向地图中添加marker
                 }
				
				   //创建和初始化地图函数(2)：
                    function initMap2(title) {
                        createMap2(); //创建地图
                        setMapEvent(); //设置地图事件
                        addMapControl(); //向地图添加控件
                        addMarker2(title); //向地图中添加marker
                    }

					

                 //创建地图函数：
                 function createMap() {
                     var map = new BMap.Map("allmap"); //在百度地图容器中创建一个地图
                     
                     var addrName= $.evalJSON('${addressName}');
					 var joinZoom=$.evalJSON('${joinCenter}');
			
                     if(addrName==""){
                     	map.centerAndZoom(new BMap.Point(114.055018, 22.560809),4);  //初始化时，即可设置中心点和地图缩放级别。设定地图的中心点和坐标并将地图显示在地图容器中
                     }else{
                     	if(addrName=="广东揭阳"){
                     		addrName=addrName+"市";
                     	}
                     	map.centerAndZoom(addrName +"" ,Number(joinZoom));
                     }
                     alert(addrName+" 省份");
                     window.map = map; //将map变量存储在全局
                 }

				
                     //创建地图函数(2)：
                    function createMap2() {
                        var map = new BMap.Map("allmap"); //在百度地图容器中创建一个地图
                        var point = new BMap.Point(113.927364, 22.54434); //定义一个中心点坐标
                        map.centerAndZoom(point,15); //设定地图的中心点和坐标并将地图显示在地图容器中
                        window.map = map; //将map变量存储在全局
                    }
				

                 //地图事件设置函数：
                 function setMapEvent() {
                     map.enableDragging(); //启用地图拖拽事件，默认启用(可不写)
                     map.enableScrollWheelZoom(); //启用地图滚轮放大缩小
                     map.enableDoubleClickZoom(); //启用鼠标双击放大，默认启用(可不写)
                     map.enableKeyboard(); //启用键盘上下左右键移动地图
                 }

                 //地图控件添加函数：                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                 function addMapControl() {
                     //向地图中添加缩放控件
                     var ctrl_nav = new BMap.NavigationControl({ anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE });
                     map.addControl(ctrl_nav);
                     //向地图中添加缩略图控件
                     var ctrl_ove = new BMap.OverviewMapControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 1 });
                     map.addControl(ctrl_ove);
                     //向地图中添加比例尺控件
                     var ctrl_sca = new BMap.ScaleControl({ anchor: BMAP_ANCHOR_BOTTOM_LEFT });
                     map.addControl(ctrl_sca);
                 }

                 //标注点数组
                 var markerArr ;


                 //创建marker
                 function addMarker() {
                   markerArr = $.evalJSON('${strInfo}'); 
                     for (var i = 0; i < markerArr.length; i++) {
                         var json = markerArr[i];
                         var p0 = json.point.split("|")[0];
                         var p1 = json.point.split("|")[1];
                         var point = new BMap.Point(p0, p1);
                         var iconImg = createIcon(json.icon);
                         var marker = new BMap.Marker(point, { icon: iconImg });
                         var iw = createInfoWindow(i);
                         var label = new BMap.Label(json.title, { "offset": new BMap.Size(json.icon.lb - json.icon.xlocation + 10, -20) });
                         marker.setLabel(label);
                         map.addOverlay(marker);
                         label.setStyle({
                             borderColor: "#808080",
                             color: "#333",
                             cursor: "pointer"
                         });

                         (function () {
                             var index = i;
                             var _iw = createInfoWindow(i);
                             var _marker = marker;
                             _marker.addEventListener("click", function () {
                                 this.openInfoWindow(_iw);
                             });
                             _iw.addEventListener("open", function () {
                                 _marker.getLabel().hide();
                             })
                             _iw.addEventListener("close", function () {
                                 _marker.getLabel().show();
                             })
                             label.addEventListener("click", function () {
                                 _marker.openInfoWindow(_iw);
                             })
                             if (!!json.isOpen) {
                               
                                 label.hide();
                                 _marker.openInfoWindow(_iw);
                             }
                         })()
                     }
                 }
                 
                   //创建marker
                 function addMarker2(title) {
                   markerArr = $.evalJSON('${strInfo}'); 
                     for (var i = 0; i < markerArr.length; i++) {
                         var json = markerArr[i];
                         var p0 = json.point.split("|")[0];
                         var p1 = json.point.split("|")[1];
                         var point = new BMap.Point(p0, p1);
                         var iconImg = createIcon(json.icon);
                         var marker = new BMap.Marker(point, { icon: iconImg });
                         var iw = createInfoWindow(i);
                         var label = new BMap.Label(json.title, { "offset": new BMap.Size(json.icon.lb - json.icon.xlocation + 10, -20) });
                         marker.setLabel(label);
                         map.addOverlay(marker);
                         label.setStyle({
                             borderColor: "#808080",
                             color: "#333",
                             cursor: "pointer"
                         });

                          (function () {
                             var index = i;
                             var _iw = createInfoWindow(i);
                             var _marker = marker; 
                              _marker.addEventListener("click", function () {
                                 this.openInfoWindow(_iw);
                             });
                             _iw.addEventListener("open", function () {
                                 _marker.getLabel().hide();
                             })
                             _iw.addEventListener("close", function () {
                                 _marker.getLabel().show();
                             })
                             label.addEventListener("click", function () {
                                 _marker.openInfoWindow(_iw);
                             })
                              if(title!=""&&title==json.title) {
                                label.hide();
                                 _marker.openInfoWindow(_iw);
                              }
                                 
                         })()
                     }
                 }
                 
                 //创建InfoWindow
                 function createInfoWindow(i) {
                     var json = markerArr[i];
                     var iw = new BMap.InfoWindow("<div class='winLeft'><img src='images/shopimg.png' style='max-height:100px;max-width:100px'></div><div class='winRight'><b class='iw_poi_title'  title='" + json.title + "'>" + json.title + "</b><br/><div class='iw_poi_phone'>"+json.phone+"</div><div class='iw_poi_content'>" + json.content + "</div></div>");
                     return iw;
                 }
                 //创建一个Icon
                 function createIcon(json) {
                     var icon = new BMap.Icon("images/marker_red_sprite.png", new BMap.Size(json.width, json.height), { imageOffset: new BMap.Size(-json.location, -json.tor), infoWindowOffset: new BMap.Size(json.lb + 5, 1), offset: new BMap.Size(json.xlocation, json.height) })
                     return icon;
                 }
                 
     		 initMap();
             function GetMap(id,title)
             {   
                initMap2(title);
             }
     		
	</script>