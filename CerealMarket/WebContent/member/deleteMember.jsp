<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	String sessionId = (String) session.getAttribute("sessionId");
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

<sql:update dataSource="${dataSource}" var="resultSet">
   DELETE FROM member WHERE id = ?
   <sql:param value="<%=sessionId%>" />
</sql:update>

<c:if test="${resultSet>=1}">
	<c:import var="url" url="logoutMember.jsp" />
	<c:redirect url="resultMember.jsp" />
</c:if>

