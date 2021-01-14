<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>jQuery Contact Form Plugin: FFForm</title>
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
                <span>软件定义网络信息与防御后台管理-密码找回</span>
            </h1>
        </div>
        
        <div class="container">
            <form class="contact" action="lkup" method="post" id="form">
            <div class="row clearfix">
                <div class="lbl">
                    <label for="username">用户名</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="username" name="username" data-required="true" data-validation="text"
                        data-msg="Invalid Name" placeholder="Jhon harden">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="usm">再次确认用户</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="usm" name="usm" data-required="true" data-validation="usm"
                        data-msg="Invalid E-Mail" placeholder="John harden">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="eamil">E-mail</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="eamil" name="priority" data-required="true" data-validation="email"
                        data-msg="Invalid Phone #" placeholder="123456@163.com">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="idcard">管理编号</label>
                </div>
                <div class="ctrl">
                    <input type="text" name="idcard" id="idcard" placeholder="1001">
                </div>
            </div>         
            <div class="row  clearfix">
                <div class="span10 offset2">
                    <input type="submit" name="submit" id="submit" class="submit" value="提交">
                </div>
            </div>              
            </form>
        </div>
    </section>
</body>
</html>
