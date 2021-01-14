<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改主机信息</title>
    <link href="css/demo.css" rel="stylesheet" type="text/css">
    <!--Framework-->
    <script src="js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui.js" type="text/javascript"></script>
    <!--End Framework-->
    <script src="js/jquery.ffform.js" type="text/javascript"></script>
</head>
<body>
<section id="getintouch" >
    <div class="container" style="border-bottom: 0;">
        <h1>
            <span>软件定义网络信息与防御后台管理-修改主机信息</span>
        </h1>
    </div>

    <div class="container">
        <form class="contact" action="${pageContext.request.contextPath}/modifyHost" method="post" id="form">
            <input type="hidden" id="id" name="id" value="${host.id}">
            <div class="row clearfix">
                <div class="lbl">
                    <label for="name">主机名</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="name" name="name" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="${host.name}" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="ip">IP地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="ip" name="ip" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="${host.ip}">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="mac">MAC地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="mac" name="mac" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="${host.mac}" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="linkSwitch">所属交换机</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="linkSwitch" name="linkSwitch" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="${host.linkSwitch}" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="linkPort">连接端口</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="linkPort" name="linkPort" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="${host.linkPort}" required>
                </div>
            </div>
            <div class="row  clearfix">
                <div class="span10 offset2" align="right">
                    <input type="submit" name="submit" id="submit" class="submit" value="提交">
                </div>
            </div>
        </form>
    </div>
</section>
</body>
</html>
