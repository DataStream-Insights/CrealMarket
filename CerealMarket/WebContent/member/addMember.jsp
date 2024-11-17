<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<link rel="stylesheet"   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<script type="text/javascript">
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
<title>회원 가입</title>
<style>
   .img{
    	position: relative;
    	background-image: url("../image/joinbg.gif");                                                               
    	height: 100vh;
    	background-size: cover;
	}

	.jumbotron {
		background-image: url("../image/joinbg.gif");
		background-size: cover;
		}
</style>
</head>
<body class ="img">
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3" style="font-family: 'Permanent Marker', cursive;">JOIN US</h1>
		</div>
	</div>

	<div class="container">
		<form name="newMember" class="form-horizontal"  action="processAddMember.jsp" method="post" onsubmit="return checkForm()">
			<div class="form-group  row">
				<label class="col-sm-2 " style="font-family: 'Permanent Marker', cursive;">id</label>
				<div class="col-sm-3">
					<input name="id" type="text" class="form-control" placeholder="id" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">password</label>
				<div class="col-sm-3">
					<input name="password" type="text" class="form-control" placeholder="password" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">check password</label>
				<div class="col-sm-3">
					<input name="password_confirm" type="text" class="form-control" placeholder="password confirm" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">name</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" placeholder="name" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">gender</label>
				<div class="col-sm-10">
					<input name="gender" type="radio" value="남" /> male 
					<input name="gender" type="radio" value="여" /> female
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">birthday</label>
				<div class="col-sm-4  ">
					<input type="text" name="birthyy" maxlength="4" placeholder="year ex)2001" size="6"> 
					<select name="birthmm">
						<option value="" >month</option>
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
					</select> <input type="text" name="birthdd" maxlength="2" placeholder="day" size="4">
				</div>
			</div>
			<div class="form-group  row ">
				<label class="col-sm-2" style="font-family: 'Permanent Marker', cursive;">Email</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50">@ 
					<select name="mail2">
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
					<input name="phone" type="text" class="form-control" placeholder="phone" >

				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2 " style="font-family: 'Permanent Marker', cursive;">address</label>
				<div class="col-sm-5">
					<input name="address" type="text" class="form-control" placeholder="address">

				</div>
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-secondary " value="submit " > 
					<input type="reset" class="btn btn-secondary " value="reset " onclick="reset()" >
				</div>
			</div>
		</form>
	</div>
</body>
</html>