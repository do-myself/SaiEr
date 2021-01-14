<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理系统</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flowpage.js" charset="UTF-8"></script>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/page.css" />
</head>
<body>
<div class="hrms_container">
    <!-- 导航条 -->
    <%@ include file="./common/top.jsp"%>

    <!-- 中间部分（包括左边栏和员工/部门表单显示部分） -->
    <div class="hrms_body" style="position:relative; top:-15px;">

        <!-- 左侧栏 -->
        <%@ include file="./common/left.jsp"%>

        <!-- 中间员工表格信息展示内容 -->
        <div class="emp_info col-sm-10">

            <div class="panel panel-success">
                <!-- 路径导航 -->
                <div class="panel-heading">
                    <ol class="breadcrumb">
                        <li><a href="#">网络信息</a></li>
                        <li class="active">流表项</li>
                    </ol>
                </div>
                <!-- Table -->
                <table class="table table-bordered table-hover" id="emp_table">
                    <thead>
                    <th>id</th>
                    <th>交换机编号</th>
                    <th>流表优先级</th>
                    <th>源MAC地址</th>
                    <th>目的MAC地址</th>
                    <th>源IP地址</th>
                    <th>目的IP地址</th>
                    <th>进端口</th>
                    <th>出端口</th>
                    <th>执行动作</th>
                    </thead>
                    <tbody>
                        <c:forEach items="${pageInfo.list}" var="flow">
                            <tr>
                                <td>${flow.id}</td>
                                <td>${flow.switchID}</td>
                                <td>${flow.priority}</td>
                                <td>${flow.srcMac}</td>
                                <td>${flow.dstMac}</td>
                                <td>${flow.srcIp}</td>
                                <td>${flow.dstIp}</td>
                                <td>${flow.inPort}</td>
                                <td>${flow.outPort}</td>
                                <td>${flow.action}</td>
                                <td>
<%--                                    <a href="flowAdd" role="button" class="btn btn-primary emp_edit_btn" data-toggle="modal" data-target=".emp-update-modal">编辑</a>--%>
                                    <a id="deleteFlow" role="button" class="btn btn-danger emp_delete_btn" onclick="f(${flow.id})" href="javascript:void(0);">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:import url="flowRollPage.jsp">
                    <c:param name="totalCount" value="${pageInfo.total}"/>
                    <c:param name="currentPageNo" value="${pageInfo.pageNum}"/>
                    <c:param name="totalPageCount" value="${pageInfo.pages}"/>
                </c:import>
   
            </div><!-- /.panel panel-success -->
        </div><!-- /.emp_info --> 

    </div><!-- /.hrms_body -->
</div><!-- /.container -->


<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeFlow">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该流表项吗？</p>
            <a href="#" id="yes" onclick="deleteFlow()">确定</a>
            <a href="#" id="no" onclick="cancelBtn();">取消</a>
        </div>
    </div>
</div>
</body>
</html>
