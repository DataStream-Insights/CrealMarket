<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<html>
<head>
<link rel="stylesheet"   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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

<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=?
   <sql:param value="<%=sessionId%>" />
</sql:query>


	
	<title>회원 수정</title>
	<style>
   .img{
    	position: relative;
    	background-image: url("../image/updatebg.png");                                                               
    	height: 100vh;
    	background-size: cover;
	}

	.jumbotron {
		background-image: url("../image/updatebg.png");
		background-size: cover;
		}
</style>
</head>
<body class="img" onload="init()">
	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3" style="font-family: 'Permanent Marker', cursive;">Edit Profile</h1>
		</div>
	</div>

	<c:forEach var="row" items="${resultSet.rows}">
	<c:set var="mail" value="${row.mail}" />
	<c:set var="mail1" value="${mail.split('@')[0]}" />
	<c:set var="mail2" value="${mail.split('@')[1]}" />

	<c:set var="birth" value="${row.birth }" />
	<c:set var="year" value="${birth.split('/')[0]}" />
	<c:set var="month" value="${birth.split('/')[1]}" />
	<c:set var="day" value="${birth.split('/')[2]}" />
	
	<div class="container">
		<form name="newMember" class="form-horizontal"
			action="processUpdateMember.jsp" method="post"
			onsubmit="return checkForm()">
			<div class="form-group  row">
				<label class="col-sm-2 " style="font-family: 'Permanent Marker', cursive;">id</label>
				<div class="col-sm-3">
					<input name="id" type="text" class="form-control" placeholder="id"
						value="<c:out value='${row.id }'/>" />
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">password</label>
				<div class="col-sm-3">
					<input name="password" type="text" class="form-control"
						placeholder="password" value="<c:out value='${row.password }'/>" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">check password</label>
				<div class="col-sm-3">
					<input name="password_confirm" type="text" class="form-control"
						placeholder="password_confirm" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">name</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control"
						placeholder="name" value="<c:out value='${row.name }'/>" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">gender</label>
				<div class="col-sm-10">
					<c:set var="gender" value="${row.gender }" />
					<input name="gender" type="radio" value="남"	<c:if test="${gender.equals('남')}"> <c:out value="checked" /> </c:if> >male 
						<input name="gender" type="radio" value="여"	<c:if test="${gender.equals('여')}"> <c:out value="checked" /> </c:if> >female
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">birthday</label>
				<div class="col-sm-4  ">
					<input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" 	size="6" value="${year}"> 
						<select name="birthmm"	id="birthmm">
						<option value="">월</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
					</select> <input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" value="${day}">
				</div>
			</div>
			<div class="form-group  row ">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">Email</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50" value="${mail1}">@
					<select name="mail2" id="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">phone</label>
				<div class="col-sm-3">
					<input name="phone" type="text" class="form-control" placeholder="phone" value="<c:out value='${row.phone}'/>">

				</div>
			</div>

			<div class="form-group  row">
				<label class="col-sm-2 " style="font-family: 'Permanent Marker', cursive;">address</label>
				<div class="col-sm-5">
					<input name="address" type="text" class="form-control" placeholder="address" value="<c:out value='${row.address}'/>">
				</div>
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-outline-primary" value="Edit " style="font-family: 'Permanent Marker', cursive;"> 
					<a href="deleteMember.jsp" class="btn btn-outline-primary" style="font-family: 'Permanent Marker', cursive;">Account withdrawal</a>
				</div>
			</div>
		</form>	
	</div>
	</c:forEach>
</body>
</html>
<script type="text/javascript">
	function init() {
		setComboMailValue("${mail2}");
		setComboBirthValue("${month}");
	}

	function setComboMailValue(val) {
		var selectMail = document.getElementById('mail2');
		for (i = 0, j = selectMail.length; i < j; i++) {
			if (selectMail.options[i].value == val) {
				selectMail.options[i].selected = true; 
				break;
			}
		}
	}
	function setComboBirthValue(val) {
		var selectBirth = document.getElementById('birthmm'); 
		for (i = 0, j = selectBirth.length; i < j; i++){
			if (selectBirth.options[i].value == val){
				selectBirth.options[i].selected = true; 
				break;
			}
		}
	}
	function checkForm() {
		if (!document.newMember.id.value) {
			swal('회원정보 수정 실패!',"아이디를 입력하세요",'warning');
			return false;
		}
		if (!document.newMember.password.value) {
			swal('회원정보 수정 실패!',"비밀번호를 입력하세요",'warning');
			return false;
		}
		if (document.newMember.password.value != document.newMember.password_confirm.value) {
			swal('회원정보 수정 실패!',"비밀번호를 동일하게 입력하세요",'warning');
			return false;
		}
	}
</script>