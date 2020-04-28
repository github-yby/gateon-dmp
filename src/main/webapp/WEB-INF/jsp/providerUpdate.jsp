<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <span>供应商管理页面 >> 供应商修改页</span>
        </div>
        <div class="providerAdd">
            <form id="updateForm">
                <input type="hidden" name="id" value="${provider.id}"/>
                <input type="hidden" name="createdBy" value="${provider.createdBy}"/>
                <input type="hidden" name="creationDate" value='<fmt:formatDate value="${provider.creationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'>
                <input type="hidden" name="id" value="${provider.id}"/>
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div class="">
                    <label for="providerId">供应商编码：</label>
                    <input type="text" name="proCode" value="${provider.proCode}" id="providerId" placeholder="PRO-CODE—001"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="providerName">供应商名称：</label>
                    <input type="text" name="proName" value="${provider.proName}" id="providerName" placeholder="测试供应商001"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="people">联系人：</label>
                    <input type="text" name="proContact" value="${provider.proContact}" id="people" placeholder="韩露"/>
                    <span>*</span>

                </div>
                <div>
                    <label for="phone">联系电话：</label>
                    <input type="text" name="proPhone" value="${provider.proPhone}" id="phone" placeholder="15918230478"/>
                    <span></span>
                </div>
                <div>
                    <label for="address">联系地址：</label>
                    <input type="text" name="proAddress" value="${provider.proAddress}" id="address" placeholder="北京"/>
                    <span></span>

                </div>
                <div>
                    <label for="fax">传真：</label>
                    <input type="text" name="proFax" value="${provider.proFax}" id="fax" placeholder="15918230478"/>
                    <span></span>

                </div>
                <div>
                    <label for="describe">描述：</label>
                    <input type="text" name="proDesc" value="${provider.proDesc}" id="describe" placeholder="描述"/>
                    <span></span>

                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="providerList.html">返回</a>-->
                    <input type="button" value="保存" class="btnUpdate"/>
                    <input type="button" value="返回" onclick="history.back(-1)"/>
                </div>
            </form>
        </div>

    </div>
</section>
<footer class="footer">
    版权归0916
</footer>
<script src="/js/time.js"></script>
<script src="/js/jquery.js"></script>
<script type="text/javascript">
    $(function () {
        $(".btnUpdate").click(function () {
            var data = $("#updateForm").serialize();
            $.post("/provider/update",data,function (result) {
                if(result == "true"){
                    location.href="/provider/list";
                }else{
                    alert("修改失败");
                }
            },"text");
        });
    })
</script>
</body>
</html>