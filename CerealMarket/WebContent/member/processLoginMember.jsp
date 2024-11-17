<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>

<%@ page import="util.ConfigLoader" %>
<%
    String dbUrl = ConfigLoader.getDbUrl();
    String dbUsername = ConfigLoader.getDbUsername();
    String dbPassword = ConfigLoader.getDbPassword();
%>
<c:set var="dbUrl" value="<%= dbUrl %>" />
<c:set var="dbUsername" value="<%= dbUsername %>" />
<c:set var="dbPassword" value="<%= dbPassword %>" />
<sql:setDataSource var="dataSource" driver="com.mysql.cj.jdbc.Driver"
    url="${dbUrl}" user="${dbUsername}" password="${dbPassword}" />

<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=? and password=?  
   <sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
</sql:query>

<c:forEach var="row" items="${resultSet.rows}">
	<%
		session.setAttribute("sessionId", id);
	%>
	<c:redirect url="/main.jsp" />
</c:forEach>

<c:redirect url="loginMember.jsp?error=1" />
