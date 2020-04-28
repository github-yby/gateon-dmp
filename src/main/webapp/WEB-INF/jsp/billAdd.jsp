<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <span>账单管理页面 >> 订单添加页面</span>
        </div>
        <div class="providerAdd">
            <form id="saveFrom">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div class="">
                    <label for="billId">订单编码：</label>
                    <input type="text" name="billCode" id="billId" required/>
                    <span>*请输入订单编码</span>
                </div>
                <div>
                    <label for="billName">商品名称：</label>
                    <input type="text" name="productName" id="billName" required/>
                    <span >*请输入商品名称</span>
                </div>
                <div>
                    <label for="billCom">商品单位：</label>
                    <input type="text" name="productUnit" id="billCom" required/>
                    <span>*请输入商品单位</span>

                </div>
                <div>
                    <label for="billNum">商品数量：</label>
                    <input type="text" name="productCount" id="billNum" required/>
                    <span>*请输入大于0的正自然数，小数点后保留2位</span>
                </div>
                <div>
                    <label for="money">总金额：</label>
                    <input type="text" name="totalPrice" id="money" required/>
                    <span>*请输入大于0的正自然数，小数点后保留2位</span>
                </div>
                <div>
                    <label >供应商：</label>
                    <select name="providerId" id="provider" >
                        <option value="">--请选择相应的提供商--</option>
                    </select>
                    <span>*请选择供应商</span>
                </div>
                <div>
                    <label >是否付款：</label>
                    <input type="radio" name="isPayment" value="1" checked />未付款
                    <input type="radio" name="isPayment" value="2"/>已付款
                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="billList.html">返回</a>-->
                    <input type="button" value="保存" id="btnSave"/>
                    <input type="button" value="返回" onclick="history.back(-1)"/>
                </div>
            </form>
        </div>

    </div>
</section>
<footer class="footer">
    版权0916
</footer>
<script src="/js/time.js"></script>
<script src="/js/jquery.js"></script>
<script>
    $(function () {

        function loadProvider() {
            $.getJSON("/provider/listJson",function (result) {
                $(result).each(function () {
                    var option = "<option value='"+this.id+"'>"+this.proName+"</option>";
                    $("#provider").append(option);
                });
            });
        }
        loadProvider();
        $("#btnSave").click(function () {
            var data = $("#saveFrom").serialize();
            $.post("/bill/save",data,function (result) {
                if(result == "true"){
                    location.href="/bill/list";
                }else{
                    alert("添加失败");
                }
            },"text");
        });
    })
</script>
</body>
</html>