<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>

<%
    String sessionId = (String) session.getAttribute("sessionId");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/MyDB");
        conn = ds.getConnection();
        
        String sql = "DELETE FROM member WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, sessionId);
        
        int rowsAffected = pstmt.executeUpdate();
        
        if (rowsAffected >= 1) {
            response.sendRedirect("logoutMember.jsp");
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
%>