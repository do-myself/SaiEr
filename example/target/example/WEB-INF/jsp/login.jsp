<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>欢迎登录后台管理系统</title>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
    <script language="JavaScript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/cloud.js" type="text/javascript"></script>
    <style type="text/css">
        .info{
            padding-top: 5px;
            padding-bottom: 5px;
            color: red;
        }
    </style>

    <script language="javascript">
        $(function(){
            $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
            $(window).resize(function(){
                $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
            })
        });
    </script>
</head>
<body style="background-color:#0464c3; background-image:url(../../images/light.png); background-repeat:no-repeat; background-position: center top; overflow:hidden;">

<div id="mainBody">
    <div id="cloud1" class="cloud"></div>
    <div id="cloud2" class="cloud"></div>
</div>

<div class="logintop">
    <span>欢迎登录后台管理系统平台</span>
    <ul>
        <li><a href="#">回首页</a></li>
        <li><a href="#">帮助</a></li>
        <li><a href="https://www.sdnlab.com/">关于</a></li>
    </ul>
</div>

<div class="loginbody">
    <span class="systemlogo"></span>

    <div class="loginbox">
        <form action="login.action" method="post">
            <ul>
                <div class="info">${error}</div>
                <li><input type="text" name="userCode" class="loginuser" placeholder="用户名" required/></li>
                <li><input type="password" name="password" class="loginpwd" placeholder="密码" required/></li>
                <li><input type="submit" class="loginbtn" value="登录"/>
                    <label><input name="" type="checkbox" value="" checked="checked" />记住密码</label>
                    <label><a href="${basePath}forget">忘记密码？</a></label>
                </li>
            </ul>
        </form>
    </div>

</div>

<div class="loginbm">版权所有Copyright@2019.重庆邮电大学|赛尔网络科技有限公司</div>

</body>
</html>