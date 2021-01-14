<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/11/8
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台管理系统</title>
    <style type="text/css">
        .d1{
            margin: 180px auto;
            height: 280px;
            width: 680px;
            background: #0e90d2;
        }
        h1{
            text-align: center;
            font-size: 25px;
            padding-top: 100px;
        }
        a{
            font-size: 30px;
            color: #c5063f;
        }
    </style>
</head>
<body>
<div class="d1">
        <h1>对不起，你没有权限访问,请回到 <a href="${pageContext.request.contextPath}/toLogin">登录页面</a></h1>
</div>
</body>
</html>
