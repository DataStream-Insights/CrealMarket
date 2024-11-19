<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>

<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%
    String sessionId = (String) session.getAttribute("sessionId");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/MyDB");
        conn = ds.getConnection();
        
        String sql = "SELECT * FROM MEMBER WHERE ID=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, sessionId);
        rs = pstmt.executeQuery();
        
        if(rs.next()) {
            String mail = rs.getString("mail");
            String[] mailArr = mail.split("@");
            String mail1 = mailArr[0];
            String mail2 = mailArr[1];
            
            String birth = rs.getString("birth");
            String[] birthArr = birth.split("/");
            String year = birthArr[0];
            String month = birthArr[1];
            String day = birthArr[2];
            
            request.setAttribute("mail1", mail1);
            request.setAttribute("mail2", mail2);
            request.setAttribute("year", year);
            request.setAttribute("month", month);
            request.setAttribute("day", day);
            request.setAttribute("member", rs);
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!-- 나머지 HTML 부분은 동일하나 JSTL 태그 대신 request 속성 사용 -->
    <div class="form-group  row">
        <label class="col-sm-2 " style="font-family: 'Permanent Marker', cursive;">id</label>
        <div class="col-sm-3">
            <input name="id" type="text" class="form-control" placeholder="id"
                value="${member.id}" />
        </div>
    </div>
    <!-- 나머지 폼 필드들도 같은 방식으로 변경 -->
</html>