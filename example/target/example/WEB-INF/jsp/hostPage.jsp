<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理系统</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/page.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/hostpage.js" charset="UTF-8"></script>
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
                        <li><a href="main">网络系统信息</a></li>
                        <li class="active">主机</li>
                    </ol>
                </div>
                
                <!-- Table -->
                <table class="table table-bordered table-hover" id="emp_table">
                    <thead>
                    <th>id</th>
                    <th>主机名</th>
                    <th>主机ip</th>
                    <th>主机mac地址</th>
                    <th>连接的交换机</th>
                    <th>连接端口</th>
                    <th>
                        <a href="toHostAdd" role="button" class="btn btn-primary emp_edit_btn" data-target=".emp-update-modal">添加</a>
                    </th>
                    </thead>
                    <tbody>
                        <c:forEach items="${pageInfo.list}" var="host">
                            <tr>
                                <td>${host.id}</td>
                                <td>${host.name}</td>
                                <td>${host.ip}</td>
                                <td>${host.mac}</td>
                                <td>${host.linkSwitch}</td>
                                <td>${host.linkPort}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/toHostModify?hostId=${host.id}" role="button"
                                       class="btn btn-primary emp_edit_btn" data-target=".emp-update-modal">修改</a>
                                    <a id="deleteHost" href="javascript:void(0);" role="button" class="btn btn-danger emp_delete_btn" onclick="f2(${host.id})">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:import url="hostRollPage.jsp">
                    <c:param name="totalCount" value="${pageInfo.total}"/>
                    <c:param name="currentPageNo" value="${pageInfo.pageNum}"/>
                    <c:param name="totalPageCount" value="${pageInfo.pages}"/>
                </c:import>

<%--            <div class="panel-body">--%>
<%--                    <div class="table_items">--%>
<%--                        当前第<span class="badge">${pageHostList.pageNum}</span>页，共有<span class="badge">${pageHostList.pages}</span>页，总记录数<span class="badge">${pageHostList.total}</span>条。--%>
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
<%--            </div>--%>
   
            </div><!-- /.panel panel-success -->
        </div><!-- /.emp_info --> 

    </div><!-- /.hrms_body -->
</div><!-- /.container -->
<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeHost">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该主机吗？</p>
            <a href="#" id="yes" onclick="deleteHost()">确定</a>
            <a href="#" id="no" onclick="cancelBtn();">取消</a>
        </div>
    </div>
</div>
</body>
</html>
