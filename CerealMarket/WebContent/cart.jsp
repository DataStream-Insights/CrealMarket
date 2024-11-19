<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.cereal"%>
<%@ page import="dao.cerealRepository"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Indie+Flower&display=swap" rel="stylesheet">
<%
String sessionId = session.getId();
%>
<title>Cart</title>

<style>
.img {
    position: relative;
    background-image: url("./image/cartbg.jpg");
    height: 100vh;
    background-size: cover;
}

.jumbotron {
    background-image: url("./image/cartbg.jpg");
    background-size: cover;
}
</style>
</head>
<body class="img">
<jsp:include page="menu.jsp" />
<div class="jumbotron">
    <div class="container">
        <h1 class="display-3" style="font-family: 'Indie Flower', cursive;">Cart total</h1>
    </div>
</div>
<div class="container">
    <div class="row">
        <table width="100%">
            <tr>
                <td align="left"><a href="./deleteCart.jsp?cartId=<%=sessionId%>" class="btn btn-outline-dark" style="background-color:#FFF5EE; font-family: 'Indie Flower', cursive;">Delete All</a></td>
                <td align="right"><a href="./shippingInfo.jsp?cartId=<%=sessionId%>" class="btn btn-outline-dark" style="background-color:#F5C360; font-family: 'Indie Flower', cursive;">Order Now</a></td>
            </tr>
        </table>
    </div>
    <div style="padding-top: 50px">
        <table class="table table-hover" style="font-family: 'Indie Flower', cursive;">
            <tr>
                <th>item</th>
                <th>quantity</th>
                <th>price</th>
                <th></th>
            </tr>
            <%
            int sum = 0;
            ArrayList<cereal> cartList = (ArrayList<cereal>) session.getAttribute("cartlist");
            if (cartList == null)
                cartList = new ArrayList<cereal>();

            for (int i = 0; i < cartList.size(); i++) {
                cereal cereal = cartList.get(i);
                int total = cereal.getPrice() * cereal.getQuantity();
                sum = sum + total;
            %>
            <tr>
                <td><%=cereal.getName()%></td>
                <td><%=cereal.getQuantity()%></td>
                <td><%=cereal.getPrice()%></td>
                <td><a href="./removeCart.jsp?id=<%=cereal.getId()%>" class="badge badge-danger" style="background-color:#9B111E; font-family: 'Indie Flower', cursive;">remove</a></td>
            </tr>
            <%
            }
            %>
            <tr>
                <th></th>
                <th>total</th>
                <th><%=sum%></th>
                <th></th>
            </tr>
        </table>
        <a href="./main.jsp" class="btn btn-outline-secondary" style="background-color:#D3D3D3; font-family: 'Indie Flower', cursive;">Continue shopping</a>
    </div>
    <hr>
</div>
</body>
</html>