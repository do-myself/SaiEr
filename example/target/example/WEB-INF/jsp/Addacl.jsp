<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>管理系统</title>
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
            <h2>
                <span>软件定义网络防御系统-添加防御策略</span>
            </h2>
        </div>
        
        <div class="container">
            <form class="contact" action="addaccess" method="post" id="form">
            <div class="row clearfix">
                <div class="lbl">
                    <label for="category1">策略类别</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="category1" name="category1" data-required="id" data-validation="text"
                        data-msg="Invalid Name" placeholder=" A、B、C、D">
                </div>
            </div>   
            <div class="row clearfix">
                <div class="lbl">
                    <label for="id">防御策略编号</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="id" name="id" data-required="id" data-validation="text" data-msg="Invalid Name" placeholder="strategy_mod_1">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="sport">交换机端口</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="sport" name="sport" data-required="id" data-validation="text" data-msg="Invalid Name" placeholder="s1-eth1">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="ipsrc">源目标IP(网段)</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="ipsrc" name="ipsrc" data-required="true" data-validation="ipsrc" data-msg="Invalid E-Mail" placeholder="::10.0.0.1">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="ipdst">目的服务器IP(网段)</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="ipdst" name="ipdst" data-required="true" data-validation="ipdst" data-msg="Invalid Phone #" placeholder="::10.0.0.3">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="action">防御指令</label>
                </div>
                <div class="ctrl">
                    <input type="text" name="action" id="action" placeholder="allow/deny/drop">
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
