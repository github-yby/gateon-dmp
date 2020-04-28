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
            <span>用户管理页面 >> 用户修改页面</span>
        </div>
        <div class="providerAdd">
            <form id="updateForm">
                <input type="hidden" name="id" value="${user.id}"/>
                <input type="hidden" name="userCode" value="${user.userCode}"/>
                <input type="hidden" name="userPassword" value="${user.userPassword}"/>
                <input type="hidden" name="createdBy" value="${user.createdBy}"/>
                <input type="hidden" name="creationDate" value='<fmt:formatDate value="${user.creationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'/>
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div>
                    <label for="userName">用户名称：</label>
                    <input type="text" name="userName" value="${user.userName}" id="userName" placeholder="韩露"/>
                    <span >*</span>
                </div>

                <div>
                    <label >用户性别：</label>

                    <select name="gender">
                        <option value="2"<c:if test="${user.gender == 2}">selected</c:if>>男</option>
                        <option value="1"<c:if test="${user.gender == 1}">selected</c:if>>女</option>
                    </select>
                </div>
                <div>
                    <label for="data">出生日期：</label>
                    <input type="text" name="birthday" value='<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd HH:mm:ss"/>' id="data" placeholder="2016年2月1日"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="userphone">用户电话：</label>
                    <input type="text" name="phone" value="${user.phone}" id="userphone" placeholder="13533667897"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="userAddress">用户地址：</label>
                    <input type="text" name="address" value="${user.address}" id="userAddress" placeholder="北京"/>
                </div>
                <div>
                    <label >用户类别：</label>
                    <input type="radio" name="userRole" value="1" <c:if test="${user.userRole == 1}">checked</c:if>/>管理员
                    <input type="radio" name="userRole" value="2" <c:if test="${user.userRole == 2}">checked</c:if>/>经理
                    <input type="radio" name="userRole" value="3" <c:if test="${user.userRole == 3}">checked</c:if>/>普通用户
                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="userList.html">返回</a>-->
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
            $.post("/user/update",data,function (result) {
                if(result == "true"){
                    location.href="/user/list";
                }else{
                    alert("修改失败");
                }
            },"text")

        });
    })
</script>

</body>
</html>