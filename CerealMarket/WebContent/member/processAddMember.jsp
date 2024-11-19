<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String year = request.getParameter("birthyy");
    String month = request.getParameterValues("birthmm")[0];
    String day = request.getParameter("birthdd");
    String birth = year + "/" + month + "/" + day;
    String mail1 = request.getParameter("mail1");
    String mail2 = request.getParameterValues("mail2")[0];
    String mail = mail1 + "@" + mail2;
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    // 현재 날짜 문자열로 가져오기
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String regist_day = formatter.format(new Date());

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/MyDB");
        conn = ds.getConnection();

        String sql = "INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, id);
        pstmt.setString(2, password);
        pstmt.setString(3, name);
        pstmt.setString(4, gender);
        pstmt.setString(5, birth);
        pstmt.setString(6, mail);
        pstmt.setString(7, phone);
        pstmt.setString(8, address);
        pstmt.setString(9, regist_day);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("resultMember.jsp?msg=1");
        } else {
            response.sendRedirect("resultMember.jsp?msg=0");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>