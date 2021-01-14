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
                <span>软件定义网络信息与防御后台管理-删除防御策略</span>
            </h1>
        </div>
        
        <div class="container">
            <form class="contact" action="deleteaccess" method="post" id="form">
            <div class="row clearfix">
                <div class="lbl">
                    <label for="id">防御策略编号</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="id" name="id" data-required="id" data-validation="id"
                        data-msg="Invalid Name" placeholder="01">
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
