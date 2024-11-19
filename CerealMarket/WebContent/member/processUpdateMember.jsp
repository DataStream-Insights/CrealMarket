<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.util.*"%>

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
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/MyDB");
        conn = ds.getConnection();
        
        String sql = "UPDATE member SET password=?, name=?, gender=?, birth=?, mail=?, phone=?, address=? WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        
        pstmt.setString(1, password);
        pstmt.setString(2, name);
        pstmt.setString(3, gender);
        pstmt.setString(4, birth);
        pstmt.setString(5, mail);
        pstmt.setString(6, phone);
        pstmt.setString(7, address);
        pstmt.setString(8, id);
        
        int rowsAffected = pstmt.executeUpdate();
        
        if (rowsAffected >= 1) {
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