<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="dto.cereal"%>
<%@ page import="dao.cerealRepository"%>

<%
	request.setCharacterEncoding("UTF-8");

	// 세션에서 사용자 ID 가져오기 추가
	String member_id = (String) session.getAttribute("sessionId");

	String cartId = session.getId();

	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_shippingDate = "";
	String shipping_country = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";
	String shipping_DetailedAddress = "";
	
	Cookie[] cookies = request.getCookies();

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.equals("Shipping_cartId"))
				shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if (n.equals("Shipping_name"))
				shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if (n.equals("Shipping_shippingDate"))
				shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if (n.equals("Shipping_country"))
				shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if (n.equals("Shipping_zipCode"))
				shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if (n.equals("Shipping_addressName"))
				shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			if (n.equals("Shipping_DetailedAddress"))
				shipping_DetailedAddress = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
	}
%>
<html>
<head>
<link rel="stylesheet"   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Indie+Flower&family=Poor+Story&display=swap" rel="stylesheet">
<jsp:include page="/common/header.jsp" />
<title>Order Confirmation</title>
<style>
   .img{
    	position: relative;
    	background: url("./image/orderconfirmationbg.gif");                                                               
    	height: 100vh;
    	background-size: cover;
	}
	
	.jumbotron {
		background-image: url("./image/orderconfirmationbg.gif");
		background-size: cover;
	}
</style>
</head>
<body class ="img">
	<jsp:include page="menu.jsp" />
	<input type="hidden" id="memberId" value="<%= member_id != null ? member_id : "anonymous" %>">
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3" style="font-family: 'Indie Flower', cursive;">ORDER CONFIRMATION</h1>
		</div>
	</div>

	<div class="container col-8 alert alert-secondary">
		<div class="text-center" style = "font-family: 'Comfortaa', cursive;">
			<h1>RECEIPT</h1>
		</div>
		<div class="row justify-content-between" style = "font-family: 'Comfortaa', cursive; font-family: 'Poor Story', cursive;">
			<div class="col-4" align="left">
				<strong>SHIPPING ADDRESS INFORMATION</strong> <br> NAME : <% out.println(shipping_name); %>	<br> 
				ZIP CODE : <% 	out.println(shipping_zipCode);%><br> 
				ADDRESS : <%	out.println(shipping_addressName);%>, <%out.println(shipping_DetailedAddress);%>
				(<%	out.println(shipping_country);%>) <br>
			</div>
			<div class="col-4" align="right">
				<p>	<em>DELIVERY DATE: <% out.println(shipping_shippingDate);%></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">			
			<tr>
				<th class="text-center" style = "font-family: 'Comfortaa', cursive;">items</th>
				<th class="text-center" style = "font-family: 'Comfortaa', cursive;">quantity</th>
				<th class="text-center" style = "font-family: 'Comfortaa', cursive;">price</th>
				<th class="text-center" style = "font-family: 'Comfortaa', cursive;"></th>
			</tr>
			<%
				int sum = 0;
				ArrayList<cereal> cartList = (ArrayList<cereal>) session.getAttribute("cartlist");
				if (cartList == null)
					cartList = new ArrayList<cereal>();
				for (int i = 0; i < cartList.size(); i++) { // 상품리스트 하나씩 출력하기
					cereal cereal = cartList.get(i);
					int total = cereal.getPrice() * cereal.getQuantity();
					sum = sum + total;
			%>
			<tr>
				<td class="text-center" style = "font-family: 'Comfortaa', cursive;"><em><%=cereal.getName()%> </em></td>
				<td class="text-center" style = "font-family: 'Comfortaa', cursive;"><%=cereal.getQuantity()%></td>
				<td class="text-center" style = "font-family: 'Comfortaa', cursive;"><%=cereal.getPrice()%>$</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td> </td>
				<td> </td>
				<td class="text-right" style = "font-family: 'Comfortaa', cursive;">	<strong>total: </strong></td>
				<td class="text-center text-danger"><strong><%=sum%> </strong></td>
			</tr>
			</table>
			
				<a href="./shippingInfo.jsp?cartId=<%=shipping_cartId%>"class="btn btn-outline-secondary" role="button" style = "color:#7690AC; font-family: 'Comfortaa', cursive;"> BACK </a>
				<a href="./thankCustomer.jsp" id="completeOrderBtn" class="btn btn-dark" role="button" style = "background-color: #8FB0C6; font-family: 'Comfortaa', cursive;"> ORDER COMPLETE </a>
				<a href="./checkOutCancelled.jsp" class="btn btn-outline-secondary"	role="button" style = "color:#7690AC; font-family: 'Comfortaa', cursive;"> CANCEL ORDER</a>			
		</div>
	</div>	
</body>
</html>
