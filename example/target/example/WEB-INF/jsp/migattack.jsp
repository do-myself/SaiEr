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
    <style type="text/css">
        .remind{
            text-align: center;
        }
    </style>
</head>
<body>  
    <section id="getintouch" >
        <div class="container" style="border-bottom: 0;">
            <h2>
                <span>软件定义网络信息与防御后台管理：攻击迁移策略-主机隔离</span>
            </h2>
        </div>
        
        <div class="container">
            <form class="contact" action="/addmig" method="post" id="form">
           <div class="row clearfix">
                <div class="lbl">
                    <label for="category">策略类别</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="category" name="category" data-required="id" data-validation="text"
                        data-msg="Invalid Name" placeholder="A、B、C、D">
                </div>
            </div>           
            <div class="row clearfix">
                <div class="lbl">
                    <label for="migid">交换机编号</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="migid" name="migid" data-required="id" data-validation="text"
                        data-msg="Invalid Name" placeholder="00:00:00:00:00:00:00:01">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="migname">名称编号</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="migname" name="migname" data-required="true" data-validation="ipsrc"
                        data-msg="Invalid E-Mail" placeholder="请勿输入中文字符与特殊字符">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="mignum">优先级编号</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="mignum" name="mignum" data-required="true" data-validation="ipdst"
                        data-msg="Invalid Phone #" placeholder=" 0~65535 ">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="migInPort">入端口编号</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="migInPort" name="migInPort" data-required="true" data-validation="ipdst"
                        data-msg="Invalid Phone #" placeholder=" 请查阅交换机信息 ">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="migAction">操作指令</label>
                </div>
                <div class="ctrl">
                    <input type="text" name="migAction" id="migAction" placeholder="set-field">
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
