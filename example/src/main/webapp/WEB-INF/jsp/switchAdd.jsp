<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加交换机</title>
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
            <span>软件定义网络信息与防御后台管理-添加交换机</span>
        </h1>
    </div>

    <div class="container">
        <form class="contact" action="${pageContext.request.contextPath}/addSwitch" method="post" id="form">
            <div class="row clearfix">
                <div class="lbl">
                    <label for="mac">交换机MAC地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="mac" name="mac" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:00:00:00:00:00:00:00:01" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="version">交换机版本</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="version" name="version" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:OF_12" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="ipv4">IPV4地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="ipv4" name="ipv4" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:192.168.10.1">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="ipv6">IPV6地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="ipv6" name="ipv6" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:2001:db08:acad:1::2/64" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="ports">端口数量</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="ports" name="ports" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:4" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="flows">流表项数量</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="flows" name="flows" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:9" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="role">角色</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="role" name="role" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:master" required>
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
