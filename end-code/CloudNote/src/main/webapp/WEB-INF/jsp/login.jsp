<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/global/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title></title>
    <%-- Required meta tags always come first --%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <%-- Bootstrap CSS --%>
    <link rel="stylesheet" href="${ctx}/css/bootstrap.css">
    <link rel="stylesheet" href="${ctx}/css/toastr.css">
    <%-- jQuery first, then Bootstrap JS. --%>
    <script src="${ctx}/js/jquery-3.2.1.min.js"></script>
    <script src="${ctx}/js/bootstrap.js"></script>
    <script src="${ctx}/js/toastr.js"></script>
    <script src="${ctx}/js/http.js"></script>
    <style type="text/css">
        *{
            margin: 0;
            padding: 0;
        }
        body{
            background: #fbfcfe;
        }
        header{
            background: lightskyblue;
            width:100%;
            height:50px;
        }
        #main{
            width:900px;
            background: white;
            margin:0 auto;
            margin-top: 100px;
            position: relative;
            box-shadow:0px 0px  10px 5px #f4e6ff;
        }
        #main .left{
            margin-left: 15px;
            /*border:1px solid red;*/
            float: left;
        }
        #main .right{
            margin-left:10px ;
            /*border:1px solid red;*/
            float:left;
        }
        #main .right a{
            border-radius: 8px;
            width: 70%;
            height:50px;
            padding:13px;
            margin-left:60px;
            margin-top: 35px;
            background: white;
            color: lightskyblue;
            font-size: 18px;
            border: 1px solid lightskyblue;
        }
        #main .left button{
            width:130px;
            height: 45px;
            display: block;
            border-radius: 8px;
            font-size: 18px;
        }
        #login_btn{
            color: white;
            background: lightskyblue;
            font-size: 18px;
            float: left;
            margin-top: 18px;
            margin-left: 70px;
        }
        #register_btn{
            color: lightskyblue;
            font-size: 18px;
            background: white;
            margin-top: 18px;
            margin-right: 45px;
            float: right;
        }
    </style>
</head>

<body>
<div id="main" style="height:490px;" >
    <p style="font-size: 30px;text-align: center;padding-top: 15px;font-family: Serif;">欢迎使用无道云笔记</p>
    <div class="left " style="width: 420px;height: 420px;">
        <p style="font-size: 18px;text-align: center;margin-top: 30px;font-family: Serif;">手机号登录</p>
        <form method="post" action="${ctx}/login" onsubmit="return httpPost()">
            <div class="form-group" style="width: 307px;height: 50px;margin: 0 auto;margin-top: 45px;margin-left: 70px">
                <input style="width: 307px;height: 45px;" id="tel" class="form-control" type="text" name="tel" maxlength="11"  placeholder="手机号" >
            </div>
            <div class="form-group" style="width: 307px;height: 50px;margin: 0 auto;margin-top: 20px;margin-left: 70px">
                <input style="width: 307px;height: 45px;"id="password" class="form-control" type="password" name="password" placeholder="密码">
            </div>
            <div style="width:100px ;height: 40px;margin-left:313px;margin-top: 10px">
                <a href="${ctx}/foundPassword">忘记密码？</a>
            </div>

            <button id="login_btn" type="submit"  class="btn btn-default" >登录</button>
            <button id="register_btn" type="button" class="btn btn-default" onclick="window.location='${ctx}/register'">注册</button>
        </form>
    </div>
    <div class="center" style="height: 340px;margin-left:20px;margin-top: 20px;background: #f4e6ff;width: 1px;float: left;"></div>
    <div class="right " style="width: 420px;height: 420px;">
        <p style="font-size: 18px;text-align: center;margin-top: 30px;font-family: Serif;">其他账号登录</p>
        <a class="btn" style="padding-left: 33px" onclick="window.location.href='${ctx}/qqLogin'"><img src="${ctx}/images/qq.png">  使用QQ登录</a>
        <a style="margin-top: 40px;padding-left: 40px" class="btn"   onclick="loginWchat()"><img src="${ctx}/images/weixin.png">  使用微信登录</a>
        <a style="margin-top: 40px;padding-left: 55px"class="btn"   onclick="window.location.href='${ctx}/githubLogin'"><img src="${ctx}/images/github.png">  使用Github登录</a>
    </div>
</div>

<script>
    function httpPost() {
        var flag;
        var tel = $("#tel").val();
        var password = $("#password").val();
        var re=/^1\d{10}$/;
        if (!re.test(tel)) {
            toastr.warning("手机号不符合规范");
            return false;
        }
        sendPost('${ctx}/loginCheck',{'tel': tel,'password': password},false,function (msg) {
            if (!msg.status) {
                toastr.error(msg.info);
               flag = false;
            } else {
                flag = true;
            }
        },function (error) {
            toastr.error("系统错误");
            flag = false;
        });
        return flag;
    }
</script>
</body>

</html>