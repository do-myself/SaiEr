<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.net.InetAddress"%>
<%@ page import="com.demo.entity.User" %>
<html>
<head>
    <title>管理系统</title>
	<script>
		<%User user = (User) session.getAttribute("userInfo");%>
	</script>
</head>
<body>
<%
		Date d = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = df.format(d);
		InetAddress addr = InetAddress.getLocalHost();
		String s=addr.getHostAddress();
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
                    <h2 style="text-align: center;"><%=user.getUserCode()%>, Welocme To SDN Manager System</h2>
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
            <table class="table table-border table-bordered table-bg mt-20">
		<thead>
			<tr>
				<th colspan="2" scope="col">系统基本信息</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th width="30%">控制器版本</th>
				<td><span id="lbServerName">Ryu</span></td>
			</tr>
			<tr>
				<td>SDN网络协议</td>
				<td>OpenFlow v1.2</td>
			</tr>
			<tr>
				<td>数据库</td>
				<td>MySQL5.7</td>
			</tr>
			<tr>
				<td>服务器端口 </td>
				<td>8080</td>
			</tr>
			<tr>
				<td>服务器版本 </td>
				<td>Tomcat9</td>
			</tr>
			<tr>
				<td>服务器操作系统 </td>
				<td>Ubuntu 16.04.1 LTS</td>
			</tr>
			<tr>
				<td>系统所在路径</td>
				<td>/home/example</td>
			</tr>
			<tr>
				<td>服务器的语言种类 </td>
				<td>Chinese (People's Republic of China)</td>
			</tr>
			<tr>
				<td>JAVA版本 </td>
				<td>jdk1.8</td>
			</tr>
			<tr>
				<td>系统框架</td>
				<td>Spring MyBatis Bootstarp</td>
			</tr>
		</tbody>
	</table>
        </div><!-- /.hrms_main_ad -->
        
    </div><!-- /.hrms_body -->
</div><!-- /.hrms_container -->
</body>
</html>
