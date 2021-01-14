<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理系统</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/page.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/switchpage.js" charset="UTF-8"></script>
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
                        <li class="active">交换机</li>
                    </ol>
                </div>
                
                <!-- Table -->
                <table class="table table-bordered table-hover" id="emp_table">
                    <thead>
                    <th>id</th>
                    <th>MAC地址</th>
                    <th>交换机版本</th>
<%--                    <th>IPv4地址</th>--%>
                    <th>IPv6地址</th>
                    <th>端口数目</th>
                    <th>流表数目</th>
                    <th>角色</th>
                    <th>
                        <a href="${pageContext.request.contextPath}/toSwitchAdd" role="button" class="btn btn-primary emp_edit_btn" data-target=".emp-update-modal">添加</a>
                    </th>
                    </thead>
                    <tbody>
                        <c:forEach items="${pageInfo.list}" var="emp">
                            <tr>
                                <td>${emp.id}</td>
                                <td>${emp.mac}</td>
                                <td>${emp.version}</td>
<%--                                <td>${emp.ipv4}</td>--%>
                                <td>${emp.ipv6}</td>
                                <td>${emp.ports}</td>
                                <td>${emp.flows}</td>
                                <td>${emp.role}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/toSwitchModify?switchId=${emp.id}" role="button"
                                       class="btn btn-primary emp_edit_btn" data-target=".emp-update-modal">修改</a>
                                    <a id="deleteSwitch" href="javascript:void(0);" role="button" class="btn btn-danger emp_delete_btn"
                                       onclick="f3(${emp.id})">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:import url="switchRollPage.jsp">
                    <c:param name="totalCount" value="${pageInfo.total}"/>
                    <c:param name="currentPageNo" value="${pageInfo.pageNum}"/>
                    <c:param name="totalPageCount" value="${pageInfo.pages}"/>
                </c:import>

<%--            <div class="panel-body">--%>
<%--                    <div class="table_items">--%>
<%--                        当前第<span class="badge">${pageInfo.pageNum}</span>页，共有<span class="badge">${pageInfo.pages}</span>页，总记录数<span class="badge">${pageInfo.total}</span>条。--%>
<%--                    </div>--%>
<%--                    <nav aria-label="Page navigation" class="pull-right">--%>
<%--                        <ul class="pagination">--%>
<%--                            <li><a href="/hrms/emp/getEmpList?pageNo=1">首页</a></li>--%>
<%--                            <c:if test="${curPage==1}">--%>
<%--                                <li class="disabled">--%>
<%--                                    <a href="#" aria-label="Previous" class="prePage">--%>
<%--                                        <span aria-hidden="true">&laquo;</span>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${curPage!=1}">--%>
<%--                                <li>--%>
<%--                                    <a href="#" aria-label="Previous" class="prePage">--%>
<%--                                        <span aria-hidden="true">&laquo;</span>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                            </c:if>--%>

<%--                            <c:forEach begin="1" end="${totalPages<5?totalPages:5}" step="1" var="itemPage">--%>
<%--                                <c:if test="${curPage == itemPage}">--%>
<%--                                    <li class="active"><a href="/hrms/emp/getEmpList?pageNo=${itemPage}">${itemPage}</a></li>--%>
<%--                                </c:if>--%>
<%--                                <c:if test="${curPage != itemPage}">--%>
<%--                                    <li><a href="/hrms/emp/getEmpList?pageNo=${itemPage}">${itemPage}</a></li>--%>
<%--                                </c:if>--%>
<%--                            </c:forEach>--%>

<%--                            <c:if test="${curPage==totalPages}">--%>
<%--                                <li class="disabled" class="nextPage">--%>
<%--                                    <a href="#" aria-label="Next">--%>
<%--                                        <span aria-hidden="true">&raquo;</span>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${curPage!=totalPages}">--%>
<%--                                <li>--%>
<%--                                    <a href="#" aria-label="Next" class="nextPage">--%>
<%--                                        <span aria-hidden="true">&raquo;</span>--%>
<%--                                    </a>--%>
<%--                                </li>--%>
<%--                            </c:if>--%>
<%--                            <li><a href="/hrms/emp/getEmpList?pageNo=${totalPages}">尾页</a></li>--%>
<%--                        </ul>--%>
<%--                    </nav>--%>
<%--                </div>--%>
   
            </div><!-- /.panel panel-success -->
        </div><!-- /.emp_info --> 

    </div><!-- /.hrms_body -->
</div><!-- /.container -->
<div class="zhezhao"></div>
<div class="remove" id="removeSwitch">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该交换机吗？</p>
            <a href="#" id="yes" onclick="deleteSwitch()">确定</a>
            <a href="#" id="no" onclick="cancelBtn();">取消</a>
        </div>
    </div>
</div>
</body>
</html>
