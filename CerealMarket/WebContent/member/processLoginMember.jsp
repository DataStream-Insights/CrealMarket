<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/MyDB");
        conn = ds.getConnection();
        
        String sql = "SELECT * FROM member WHERE id=? AND password=?";
        pstmt = conn.prepareStatement(sql);
        
        pstmt.setString(1, id);
        pstmt.setString(2, password);
        
        rs = pstmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("sessionId", id);
            response.sendRedirect("../main.jsp");
        } else {
            response.sendRedirect("loginMember.jsp?error=1");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("loginMember.jsp?error=1");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>