<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理系统</title>
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
                        <li><a href="main">网络防御</a></li>
                        <li class="active">访问控制列表</li>
                    </ol>
                </div>
                
                <!-- Table -->
                <table class="table table-bordered table-hover" id="emp_table">
                    <thead>
                    <th>id</th>
                    <th>源目标IP</th>
                    <th>目的IP</th>
                    <th>指令</th>
                    </thead>
                    <tbody>
                        <c:forEach items="${pageInfo.list}" var="al">
                            <tr>
                                <td>${al.id}</td>
                                <td>${al.ipsrc}</td>
                                <td>${al.ipdst}</td>
                                <td>${al.action}</td>
                                <td>
                                    <a href="add" role="button" class="btn btn-primary emp_edit_btn" data-toggle="modal" data-target=".emp-update-modal" >编辑</a>
                                    <a href="delete" role="button" class="btn btn-danger emp_delete_btn">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
    
            <div class="panel-body">
                    <div class="table_items">
                        当前第<span class="badge">${pageInfo.pageNum}</span>页，共有<span class="badge">${pageInfo.pages}</span>页，总记录数<span class="badge">${pageInfo.total}</span>条。
                    </div>
                    <nav aria-label="Page navigation" class="pull-right">
                        <ul class="pagination">
                            <li><a href="/hrms/emp/getEmpList?pageNo=1">首页</a></li>
                            <c:if test="${curPage==1}">
                                <li class="disabled">
                                    <a href="#" aria-label="Previous" class="prePage">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${curPage!=1}">
                                <li>
                                    <a href="#" aria-label="Previous" class="prePage">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages<5?totalPages:5}" step="1" var="itemPage">
                                <c:if test="${curPage == itemPage}">
                                    <li class="active"><a href="/hrms/emp/getEmpList?pageNo=${itemPage}">${itemPage}</a></li>
                                </c:if>
                                <c:if test="${curPage != itemPage}">
                                    <li><a href="/hrms/emp/getEmpList?pageNo=${itemPage}">${itemPage}</a></li>
                                </c:if>
                            </c:forEach>

                            <c:if test="${curPage==totalPages}">
                                <li class="disabled" class="nextPage">
                                    <a href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${curPage!=totalPages}">
                                <li>
                                    <a href="#" aria-label="Next" class="nextPage">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <li><a href="/hrms/emp/getEmpList?pageNo=${totalPages}">尾页</a></li>
                        </ul>
                    </nav>
                </div>
   
            </div><!-- /.panel panel-success -->
        </div><!-- /.emp_info --> 

    </div><!-- /.hrms_body -->
</div><!-- /.container -->
</body>
</html>
