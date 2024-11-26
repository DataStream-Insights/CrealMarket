<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.cereal"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
    request.setCharacterEncoding("UTF-8");

    String shipping_cartId = "";
    String shipping_name = "";
    String shipping_shippingDate = "";
    String shipping_country = "";
    String shipping_zipCode = "";
    String shipping_addressName = "";
    String shipping_DetailedAddress = "";
    
    // 쿠키에서 주문 정보 가져오기
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

    // 총 주문금액 계산
    int sum = 0;
    ArrayList<cereal> cartList = (ArrayList<cereal>) session.getAttribute("cartlist");
    if (cartList == null)
        cartList = new ArrayList<cereal>();
    for (int i = 0; i < cartList.size(); i++) {
        cereal cereal = cartList.get(i);
        int total = cereal.getPrice() * cereal.getQuantity();
        sum = sum + total;
    }

    // 현재 로그인한 사용자 ID 가져오기
    String member_id = (String) session.getAttribute("sessionId");
    
    // 현재 날짜 가져오기
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String order_date = formatter.format(new Date());

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Context init = new InitialContext();
        DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MyDB");
        conn = ds.getConnection();

        String sql = "INSERT INTO orders VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        
        pstmt.setString(1, member_id);
        pstmt.setString(2, shipping_cartId);
        pstmt.setString(3, shipping_name);
        pstmt.setString(4, shipping_shippingDate);
        pstmt.setString(5, shipping_country);
        pstmt.setString(6, shipping_zipCode);
        pstmt.setString(7, shipping_addressName);
        pstmt.setString(8, shipping_DetailedAddress);
        pstmt.setInt(9, sum);
        pstmt.setString(10, order_date);

        pstmt.executeUpdate();

        // 주문이 완료되면 세션의 장바구니 정보 삭제
        session.removeAttribute("cartlist");
        
        // 쿠키 삭제
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                Cookie thisCookie = cookies[i];
                String n = thisCookie.getName();
                if (n.startsWith("Shipping_")) {
                    thisCookie.setMaxAge(0);
                    response.addCookie(thisCookie);
                }
            }
        }
%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Comfortaa&family=Indie+Flower&display=swap" rel="stylesheet">
<jsp:include page="/common/header.jsp" />
<title>주문 완료</title>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3" style="font-family: 'Indie Flower', cursive;">Order Completed</h1>
        </div>
    </div>
    <div class="container">
        <h2 class="alert alert-success" style="font-family: 'Comfortaa', cursive;">Thank you for your order!</h2>
        <p style="font-family: 'Comfortaa', cursive;">
            Your order number is: <%= shipping_cartId %>
        </p>
        <p style="font-family: 'Comfortaa', cursive;">
            The product will be delivered on <%= shipping_shippingDate %>
        </p>
        <p><a href="./products.jsp" class="btn btn-secondary" style="font-family: 'Comfortaa', cursive;">&laquo; Products</a></p>
    </div>
</body>
</html>
<%
    } catch(Exception e) {
        e.printStackTrace();
%>
<html>
<head>
<title>주문 실패</title>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">Order Failed</h1>
        </div>
    </div>
    <div class="container">
        <h2 class="alert alert-danger">An error occurred while processing your order.</h2>
        <p><a href="./products.jsp" class="btn btn-secondary">&laquo; Products</a></p>
    </div>
</body>
</html>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
%>