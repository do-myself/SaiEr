<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.net.InetAddress"%>
<%@ page import="com.demo.entity.User" %>
<html>
<head>
    <title>管理系统</title>
    <style type="text/css">
        h4{
            text-align: center;
        }
        .panel-heading{
            background: #dff0d8;
        }
        th{
            text-align: center;
        }
        #emp_table{
            text-align: center;
        }
    </style>
    <script>
        <%User user = (User) session.getAttribute("userInfo");%>
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/attackDetectionPage.js" charset="UTF-8"></script>
</head>
<body>
<%
    //		Date d = new Date();
//		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String now = df.format(d);
    InetAddress addr = InetAddress.getLocalHost();
    String s=addr.getHostAddress();
//
//		String path="E:\\JavaCode\\example\\src\\main\\resources\\detectionFile\\detectionfile.txt";
//		File file=new File(path);
//		FileReader fr=new FileReader(file);
//		BufferedReader br=new BufferedReader(fr);
//		StringBuffer sbStr=new StringBuffer();
//		String str=br.readLine();
//		while(str!=null){
//			sbStr.append(str).append("<br>");
//			str=br.readLine();
//		}
//		br.close();
%>
<div class="hrms_container">
    <!-- 导航条 -->
    <%@ include file="./common/top.jsp"%>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div class="hrms_body" style="position:relative; top:-15px;">

        <!-- 左侧栏 -->
        <%@ include file="./common/left.jsp"%>

        <!-- 中间内容 -->
        <div class="hrms_main_ad col-sm-10">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h2 style="text-align: center;">Welcome to the interface of Administer Information</h2>
                    <h5 style="text-align: right;">登录地IP地址：<%=s%></h5>
                    <div id="time" align="right">
                        <h3>当前时间：</h3>
                        <script>
                            document.getElementById('time').innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());
                            setInterval("document.getElementById('time').innerHTML=new Date().toLocaleString()+' 星期'+'日一二三四五六'.charAt(new Date().getDay());",1000);
                        </script>
                    </div>
                </div>
            </div><!-- /.panel -->

            <div class="panel-heading">
                <h4>管理员基本信息</h4>
            </div>

            <br>

            <!-- Table -->
            <table class="table table-bordered table-hover" id="emp_table">

                <thead>
                </thead>

                <tbody>
                <tr>
                    <td>管理员编码</td>
                    <td><%=user.getUserCode()%></td>
                </tr>
                <tr>
                    <td>管理员密码</td>
                    <td>******</td>
                </tr>
                <tr>
                    <td>管理员名称</td>
                    <td><%=user.getUserName()%></td>
                </tr>
                <tr>
                    <td>电话号码</td>
                    <td><%=user.getPhoneNum()%></td>
                </tr>
                <tr>
                    <td>年龄</td>
                    <td><%=user.getAge()%></td>
                </tr>
                <tr>
                    <td>性别</td>
                    <td><%=user.getSex()%></td>
                </tr>
            </table>

        </div><!-- /.hrms_main_ad -->

    </div><!-- /.hrms_body -->
</div><!-- /.hrms_container -->
</body>
</html>
