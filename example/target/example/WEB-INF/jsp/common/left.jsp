<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-group col-sm-2" id="hrms_sidebar_left" role="tablist" aria-multiselectable="true">
    <ul class="nav nav-pills nav-stacked emp_sidebar">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_emp">
                <span class="glyphicon glyphicon-home" aria-hidden="true">网络系统信息</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_emp">
                <li role="presentation"><a href="/switchList" class="switch_info">交换机</a></li>
                <li role="presentation"><a href="/hostList" class="link_info">主机</a></li>
                <li role="presentation"><a href="sflowlist"  class="flow_info" >流表项</a></li>
            </ul>
        </li>
    </ul>
    <ul class="nav nav-pills nav-stacked dept_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_dept">
                <span class="glyphicon glyphicon-cloud" aria-hidden="true">网络防御</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dept">
                <li role="presentation"><a href="flowAdd" class="def_info">下发流表</a></li>
                <li role="presentation"><a href="add" class="acl_info">添加防御策略</a></li>
<%--                <li role="presentation"><a href="#" class="data_info">攻击流过滤</a></li>--%>
                <li role="presentation"><a href="/migrate" class="service_info">主机隔离策略</a></li>
            </ul>
        </li>
    </ul>
        <ul class="nav nav-pills nav-stacked picture_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_dept">
                <span class="glyphicon glyphicon-th-large" aria-hidden="true">攻击检测</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dept2">
                <li role="presentation"><a href="toAttackDetection" class="bd_info">DDoS攻击检测</a></li>
                <li role="presentation"><a href="attackList" class="acl_info">历史攻击记录</a></li>
            </ul>
        </li>
    </ul>
</div><!-- /.panel-group，#hrms_sidebar_left -->

<!--<script type="text/javascript">
    //跳转到交换机信息页面
   $(".switch_info").click(function () {
        $(this).attr("href", "${basePath}getall/swlist");
   });
    //跳转到部门页面
    $(".dept_info").click(function () {
        $(this).attr("href", "${basePath}getall/swlist");
    });
    //员工清零这个功能暂未实现
    $(".emp_clearall_btn").click(function () {
        alert("对不起，您暂无权限进行操作！请先获取权限");
    });
    //部门清零这个功能暂未实现
    $(".dept_clearall_btn").click(function () {
        alert("对不起，您暂无权限进行操作！请先获取权限");
    });
</script>-->
</body>
</html>
