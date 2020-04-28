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
                <span>账单管理页面</span>
            </div>
            <div class="search">
                <form method="post" action="/bill/list">
                <span>商品名称：</span>
                <input type="text" name="productName" value="${param.productName}" placeholder="请输入商品的名称"/>
                
                <span>供应商：</span>
                <select name="providerId" id="provider">
                    <option value="">--请选择--</option>
                </select>

                <span>是否付款：</span>
                <select name="ispayment">
                    <option value="0">--请选择--</option>
                    <option value="1" <c:if test="${param.isPayment == 1}">selected</c:if>>未付款</option>
                    <option value="2" <c:if test="${param.isPayment == 2}">selceted</c:if>>已付款</option>
                </select>

                <input type="submit" value="查询"/>
                <a href="/bill/tosave">添加订单</a>
                </form>
            </div>
            <!--账单表格 样式和供应商公用-->
            <table class="providerTable" cellpadding="0" cellspacing="0">
                <tr class="firstTr">
                    <th width="10%">账单编码</th>
                    <th width="20%">商品名称</th>
                    <th width="10%">供应商</th>
                    <th width="10%">账单金额</th>
                    <th width="10%">是否付款</th>
                    <th width="10%">创建时间</th>
                    <th width="30%">操作</th>
                </tr>
                <c:forEach items="${list}" var="bill">
                <tr>
                    <td>${bill.billCode}</td>
                    <td>${bill.productName}</td>
                    <td>${bill.provider.proName}</td>
                    <td>${bill.totalPrice}</td>
                    <td>
                        <c:if test="${bill.isPayment == 1}">未付款</c:if>
                        <c:if test="${bill.isPayment == 2}">已付款</c:if>
                    </td>
                    <td><fmt:formatDate value="${bill.creationDate}" pattern="yyyy-MM-dd"/></td>
                    <td>
                        <a href="/bill/toshow?id=${bill.id}"><img src="/img/read.png" alt="查看" title="查看"/></a>
                        <a href="/bill/toupdate?id=${bill.id}"><img src="/img/xiugai.png" alt="修改" title="修改"/></a>
                        <a href="javascript:void(0);" id="${bill.id}" class="removeBill"><img src="/img/schu.png" alt="删除" title="删除"/></a>
                    </td>
                </tr>
                </c:forEach>
            </table>
            <table class="providerTable" cellpadding="0" cellspacing="0">
                <tr class="firstTr">
                    <td colspan="2" style="text-align: left">当前第${page.pageNum}页，共${page.total}条</td>
                    <td colspan="5" style="text-align: right">
                        <a href="/bill/list?pageNum=1&productName=${param.productName}&providerId=${param.providerId}&isPayment=${param.isPayment}">首页</a>
                        <c:if test="${page.pageNum <= 1}">
                            <a href="javascript:void(0);">上一页</a>
                        </c:if>
                        <c:if test="${page.pageNum > 1}">
                            <a href="/bill/list?pageNum=${page.pageNum-1}&productName=${param.productName}&providerId=${param.providerId}&isPayment=${param.isPayment}">上一页</a>
                        </c:if>
                        <c:forEach begin="1" end="${page.pages}" varStatus="index">
                            <a href="/bill/list?pageNum=${index.index}&productName=${param.productName}&providerId=${param.providerId}&isPayment=${param.isPayment}">${index.index}</a>
                        </c:forEach>
                        <c:if test="${page.pageNum >= page.pages}">
                            <a href="javascript:void(0);">下一页</a>
                        </c:if>
                        <c:if test="${page.pageNum < page.pages}">
                            <a href="/bill/list?pageNum=${page.pageNum+1}&productName=${param.productName}&providerId=${param.providerId}&isPayment=${param.isPayment}">下一页</a>
                        </c:if>
                        <a href="/bill/list?pageNum=${page.pages}&productName=${param.productName}&providerId=${param.providerId}&isPayment=${param.isPayment}">尾页</a>
                    </td>
            </table>

        </div>
    </section>


    <footer class="footer">
        版权归0916
    </footer>

<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/time.js"></script>
<script type="text/javascript">
    $(function () {
        //供应商 下拉选项框
        function loadProvider() {
            var pid = ${param.providerId}
            $.getJSON("/provider/listJson",function (result) {
                $(result).each(function () {
                    if(this.id == pid){
                        var option = "<option  selected value='"+this.id+"'>"+this.proName+"</option>";
                    }else{
                        var option = "<option value='"+this.id+"'>"+this.proName+"</option>";
                    }
                    $("#provider").append(option);
                });
            });
        }
        loadProvider();
        //删除

                $(".removeBill").click(function () {
                    if(!confirm("您确定删除吗？")){
                        return;
                    }
                    var id = $(this).prop("id");
                    var $this = $(this);
                $.get("/bill/remove?id=" + id,function (result) {
                    if(result == "true"){
                        $this.parents("tr").remove();
                    }else{
                        alert("删除失败");
                    }
                },"text")
            });
        });
</script>
</body>
</html>