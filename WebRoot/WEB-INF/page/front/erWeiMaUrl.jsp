<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<script>
var pc_style = ""
var browser = {
versions: function () {
var u = navigator.userAgent, app = navigator.appVersion;
return {
trident: u.indexOf('Trident') > -1,
presto: u.indexOf('Presto') > -1,
webKit: u.indexOf('AppleWebKit') > -1,
gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,
mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/) && u.indexOf('QIHU') && u.indexOf('QIHU') > -1 && u.indexOf('Chrome') < 0,
ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1,
iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1,
iPad: u.indexOf('iPad') > -1,
webApp: u.indexOf('Safari') == -1,
ua: u
};
}(),
language: (navigator.browserLanguage || navigator.language).toLowerCase()
}

if (browser.versions.mobile && !browser.versions.iPad) {
  this.location = "苹果ipad下载页面";
}
if (browser.versions.mobile && !browser.versions.iPhone) {
  this.location = "苹果iphone下载页面";
}
if (browser.versions.mobile && !browser.versions.android) {
  this.location = "android下载页面";
}
</script>
