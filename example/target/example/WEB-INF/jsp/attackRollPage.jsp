<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link type="text/css" href="${pageContext.request.contextPath}/css/page.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/rollpage.js" charset="UTF-8"></script>
</head>
<body>
<div class="panel-body">
    <div class="table_items">
        <ul class="pull-left">
            <li>共${param.totalCount }条记录&nbsp;&nbsp; ${param.currentPageNo }/${param.totalPageCount }页</li>
            <c:if test="${param.currentPageNo > 1}">
                <a href="${pageContext.request.contextPath}/attackList?pageNo=1">首页</a>
                <a href="${pageContext.request.contextPath}/attackList?pageNo=${param.currentPageNo-1}">上一页</a>
            </c:if>
            <c:if test="${param.currentPageNo < param.totalPageCount }">
                <a href="${pageContext.request.contextPath}/attackList?pageNo=${param.currentPageNo+1}">下一页</a>
                <a href="${pageContext.request.contextPath}/attackList?pageNo=${param.totalPageCount}">最后一页</a>
            </c:if>
            &nbsp;&nbsp;
        </ul>
        <br>
        <form action="${pageContext.request.contextPath}/attackList">
					<span class="pull-right"><label>跳转至</label>
					<input type="hidden" id="totalPageCount" value="${param.totalPageCount}"/>
					<input type="text" name="pageNo" id="inputPage" class="page-key" />&nbsp;页&nbsp;
					<input type="submit" class="page-btn" value="GO">
				</span>
        </form>
    </div>
</div>
</body>
</html>