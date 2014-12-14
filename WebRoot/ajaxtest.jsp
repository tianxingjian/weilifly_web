<%--
  Created by IntelliJ IDEA.
  User: Anyx
  Date: 12-4-15
  Time: 下午3:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="script/jquery.js"></script>
    <script type="text/javascript" src="script/myJs.js"></script>
</head>
<body>
    <div>
        请输入用户：
    </div>
    <div>
        <form id="subUserForm">
        <input type="text" name="userInfo.id" id="id"/>
        <input type="text" name="userInfo.name" id="name"/>
        </form>
    </div>
    <div>
        <input id="addUser" type="button" value="添加"/>
        &nbsp;<input id="users" type="button" value="所有用户"/>
        &nbsp;<a href="navigationBar.do">所有用户：非异步方式</a>
        &nbsp;<input id="msg" type="button" value="hello"/>
        &nbsp;<input id="msgUserInfo" type="button" value="userInfo"/>
        &nbsp;<input id="msgUserInfoList" type="button" value="userInfoList"/>
    </div>
<div id="allUser">
input_user:
</div>
</body>
</html>