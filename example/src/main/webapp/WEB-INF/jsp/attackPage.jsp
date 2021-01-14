<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理系统</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/page.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/attackpage.js" charset="UTF-8"></script>
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
                        <li><a href="#">网络系统信息</a></li>
                        <li class="active">历史攻击记录</li>
                    </ol>
                </div>

                <!-- Table -->
                <table class="table table-bordered table-hover" id="emp_table">
                    <thead>
                    <th>id</th>
                    <th>交换机ID</th>
                    <th>入端口号</th>
                    <th>源MAC地址</th>
                    <th>目的MAC地址</th>
                    <th>源IP</th>
                    <th>目的IP</th>
                    <th>攻击时间</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${pageInfo.list}" var="attack">
                        <tr>
                            <td>${attack.id}</td>
                            <td>${attack.switchId}</td>
                            <td>${attack.inPort}</td>
                            <td>${attack.srcMac}</td>
                            <td>${attack.dstMac}</td>
                            <td>${attack.srcIp}</td>
                            <td>${attack.dstIp}</td>
                            <td>${attack.attackTime}</td>
                            <td>
                                <a href="javascript:;" role="button" class="btn btn-danger emp_delete_btn"
                                   onclick="f4(${attack.id})">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <c:import url="attackRollPage.jsp">
                    <c:param name="totalCount" value="${pageInfo.total}"/>
                    <c:param name="currentPageNo" value="${pageInfo.pageNum}"/>
                    <c:param name="totalPageCount" value="${pageInfo.pages}"/>
                </c:import>


            </div><!-- /.panel panel-success -->
        </div><!-- /.emp_info -->

    </div><!-- /.hrms_body -->
</div><!-- /.container -->
<div class="zhezhao"></div>
<div class="remove" id="removeAttackInfo">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该攻击记录吗？</p>
            <a href="#" id="yes" onclick="deleteAttackInfo()">确定</a>
            <a href="#" id="no" onclick="cancelBtn()">取消</a>
        </div>
    </div>
</div>
</body>
</html>
