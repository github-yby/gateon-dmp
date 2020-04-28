<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <link rel="stylesheet" href="/css/public.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
<!--头部-->
<header class="publicHeader">
    <h1>超市账单管理系统</h1>

    <div class="publicHeaderR">
        <p><span>下午好！</span><span style="color: #fff21b"> Admin</span> , 欢迎你！</p>
        <a href="login.html">退出</a>
    </div>
</header>
<!--时间-->
<section class="publicTime">
    <span id="time">2015年1月1日 11:11  星期一</span>
    <a href="#">温馨提示：为了能正常浏览，请使用高版本浏览器！（IE10+）</a>
</section>
<!--主体内容-->
<section class="publicMian ">
    <div class="left">
        <h2 class="leftH2"><span class="span1"></span>功能列表 <span></span></h2>
        <nav>
            <ul class="list">
                <li id="active"><a href="/bill/list">账单管理</a></li>
                <li><a href="/provider/list">供应商管理</a></li>
                <li><a href="/user/list">用户管理</a></li>
                <li><a href="/user/password">密码修改</a></li>
                <li><a href="/user/login">退出系统</a></li>
            </ul>
        </nav>
    </div>
    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>供应商管理页面</span>
        </div>
        <div class="search">
            <form name="listForm" action="/provider/list" method="post">
            <span>供应商名称：</span>
            <input type="text" name="proName" value="${param.proName}" placeholder="请输入供应商的名称"/>
            <input type="submit"  value="查询"/>
            </form>
            <a href="/provider/tosave">添加供应商</a>
        </div>
        <!--供应商操作表格-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">供应商编码</th>
                <th width="20%">供应商名称</th>
                <th width="10%">联系人</th>
                <th width="10%">联系电话</th>
                <th width="10%">传真</th>
                <th width="10%">创建时间</th>
                <th width="30%">操作</th>
            </tr>
            <c:if test="${list != null}">
                <c:forEach items="${list}" var="provider">
                    <tr>
                        <td>${provider.proCode}</td>
                        <td>${provider.proName}</td>
                        <td>${provider.proContact}</td>
                        <td>${provider.proPhone}</td>
                        <td>${provider.proFax}</td>
                        <td><fmt:formatDate value="${provider.creationDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <a href="/provider/toshow?id=${provider.id}"><img src="/img/read.png" alt="查看" title="查看"/></a>
                            <a href="/provider/toupdate?id=${provider.id}"><img src="/img/xiugai.png" alt="修改" title="修改"/></a>
                            <a href="javascript:void(0);" id=${provider.id} class="removeProvider"><img src="/img/schu.png" alt="删除" title="删除"/></a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>

        </table>
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th colspan="2" style="text-align: left">当前第${page.pageNum}页，共${page.total}条记录</th>
                <th colspan="5" style="text-align: right">
                    <a href="/provider/list?pageNum=1&proName=${parm.proName}">首页</a>
                    <c:if test="${page.pageNum <= 1}">
                        <a href="/provider/list?pageNum=1&proName=${parm.proName}">上一页</a>
                    </c:if>
                    <c:if test="${page.pageNum > 1}">
                        <a href="/provider/list?pageNum=${page.pageNum-1}&proName=${parm.proName}">上一页</a>
                    </c:if>
                    <c:forEach begin="1" end="${page.pages}" varStatus="index">
                        <a href="/provider/list?${index.index}&proName=${parm.proName}">${index.index}</a>
                    </c:forEach>
                    <c:if test="${page.pageNum >= page.pages}">
                        <a href="/provider/list?pageNum=${page.pages}&proName=${parm.proName}">下一页</a>
                    </c:if>
                    <c:if test="${page.pageNum < page.pages}">
                        <a href="/provider/list?pageNum=${page.pageNum+1}&proName=${parm.proName}">下一页</a>
                    </c:if>
                    <a href="/provider/list?pageNum=${page.pages}&proName=${parm.proName}">尾页</a>
                </th>
        </table>

    </div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeProv">
   <div class="removerChid">
       <h2>提示</h2>
       <div class="removeMain" >
           <p>你确定要删除该供应商吗？</p>
           <a href="javascript:void(0);" id="yes">确定</a>
           <a href="#" id="no">取消</a>
       </div>
   </div>
</div>


<footer class="footer">
    版权归0916
</footer>

<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/time.js"></script>
<script type="text/javascript">
    $(".removeProvider").click(function () {
        var pid = $(this).prop("id");
        var $this = $(this);
        $("#yes").click(function () {
            $.post("/provider/remove?id="+ pid,function (result) {
                if(result == "true"){
                    $this.parents("tr").remove();
                    $(".zhezhao").hide();
                    $(".remove").hide();
                }else{
                    alert("删除失败");
                }
            },"text")
        });
    });
</script>
</body>
</html>