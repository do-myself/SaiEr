<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
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
                    <h2 style="text-align: center;">Welcome to the interface of attack detection</h2>
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
                <h4>攻击检测信息</h4>
            </div>

            <br>

            <!-- Table -->
            <table class="table table-bordered table-hover" id="emp_table">

                <thead>
                </thead>

                <tbody>
                    <tr>
                        <td>攻击流信息</td>
                        <c:forEach items="${attackInfoList}" var="attackInfo">
                            <td>攻击实时检测值</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td>交换机ID</td>
                        <c:forEach items="${attackInfoList}" var="attackInfo">
                            <td>${attackInfo.switchId}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td>入端口号</td>
                        <c:forEach items="${attackInfoList}" var="attackInfo">
                            <td>${attackInfo.inPort}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td>源MAC地址</td>
                        <c:forEach items="${attackInfoList}" var="attackInfo">
                            <td>${attackInfo.srcMac}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td>目的MAC地址</td>
                        <c:forEach items="${attackInfoList}" var="attackInfo">
                            <td>${attackInfo.dstMac}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td>源IP地址</td>
                        <c:forEach items="${attackInfoList}" var="attackInfo">
                            <td>${attackInfo.srcIp}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td>目的IP地址</td>
                        <c:forEach items="${attackInfoList}" var="attackInfo">
                            <td>${attackInfo.dstIp}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td>攻击时间</td>
                        <c:forEach items="${attackInfoList}" var="attackInfo">
                            <td>${attackInfo.attackTime}</td>
                        </c:forEach>
                    </tr>
                </tbody>
            </table>
            <a href="${pageContext.request.contextPath}/attackDetection" role="button" class="btn btn-primary emp_edit_btn"
               data-target=".emp-update-modal">进行攻击检测</a>
       
        </div><!-- /.hrms_main_ad -->
        
    </div><!-- /.hrms_body -->
</div><!-- /.hrms_container -->
</body>
</html>
