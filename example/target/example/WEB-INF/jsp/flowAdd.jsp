<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加流表</title>
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
                <span>软件定义网络信息与防御后台管理-添加流表</span>
            </h1>
        </div>
        
        <div class="container">
            <form class="contact" action="${pageContext.request.contextPath}/addFlow" method="post" id="form">
            <div class="row clearfix">
                <div class="lbl">
                    <label for="switchID">交换机ID</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="switchID" name="switchID" data-required="true" data-validation="text"
                        data-msg="Invalid Name" placeholder="Ex:00:00:00:00:00:00:00:01" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="priority">优先级</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="priority" name="priority" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:110" required>
                 </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="srcMac">源MAC地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="srcMac" name="srcMac" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:00:00:00:00:00:01" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="dstMac">目的MAC地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="dstMac" name="dstMac" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:00:00:00:00:00:01" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="srcIp">源IP地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="srcIp" name="srcIp" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex: ::10.0.0.1" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="dstIp">目的IP地址</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="dstIp" name="dstIp" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex: ::10.0.0.1" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="inPort">入端口</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="inPort" name="inPort" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:1" required>
                </div>
            </div>
             <div class="row clearfix">
                <div class="lbl">
                    <label for="outPort">出端口</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="outPort" name="outPort" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:1" required>
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="action">执行动作</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="action" name="action" data-required="true" data-validation="text"
                           data-msg="Invalid Name" placeholder="Ex:1" required>
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
