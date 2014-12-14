$(document).ready(function () {
	$.ajax({
        url:'navigationBar.do',
        type:'POST',
        data:"{}",
        dataType:'json',
        success:function (data) {
            $("#allUser").append("输出了：id:" + data.hello);
        }
    });
    $("#msg").click(function () {
        $.ajax({
            url:'navigationBar.do',
            type:'POST',
            data:"{}",
            dataType:'json',
            success:function (data) {
                $("#allUser").append("输出了：id:" + data.hello);
            }
        });
        /*$.getJSON("/test/input_user!queryHello", function (data) {
         //通过.操作符可以从data.hello中获得Action中hello的值
         $("#allUser").html("输出了: " + data.hello);
         });*/
    });

    $("#msgUserInfo").click(function () {
        $.ajax({
            url:'navigationBar.do',
            type:'post',
            data:"{}",
            dataType:'json',
            success:function (data) {
                $("#allUser").append("<div>输出了：id:" + data.userInfo.id + ", name: " + data.userInfo.name + "</div>");
            }
        });
    });

    $("#msgUserInfoList").click(function () {
        $.ajax({
            url:'navigationBar.do',
            type:'post',
            data:"{}",
            dataType:'json',
            success:function (data) {
                /*$.each(data.userList, function(i, value){
                 $("#allUser").append("<div>输出了：id:"+value.id+", name: "+value.name+"</div>");
                 });*/
                $(data.userList).each(function (i, value) {
                    $("#allUser").append("<div>输出了：id:" + value.id + ", name: " + value.name + "</div>");
                });

            }
        });
    });

    $("#addUser").click(function () {
        //必须先对提交表单数据数据进行序列化，采用jQuery的serialize()方法
        var params = $("#subUserForm").serialize();
        $.ajax({
            url:'navigationBar.do',
            type:'post',
            data:params,
            dataType:'json',
            success:function (data) {
                /*$.each(data.userList, function(i, value){
                 $("#allUser").append("<div>输出了：id:"+value.id+", name: "+value.name+"</div>");
                 });*/
                $(data.userList).each(function (i, value) {
                    $("#allUser").append("<div>输出了：id:" + value.id + ", name: " + value.name + "</div>");
                });

            }
        });
    });

    $("#users").click(function () {
        $.ajax({
            url:'navigationBar.do',
            type:'post',
            data:"{}",
            dataType:'json',
            success:function (data) {
                /*$.each(data.userList, function (i, value) {
                 $("#allUser").append("<div>输出了：id:" + value.id + ", name: " + value.name + "</div>");
                 });*/
                $(data.userList).each(function (i, value) {
                    $("#allUser").append("<div>输出了：id:" + value.id + ", name: " + value.name + "</div>");
                });

            }
        });
    });
});