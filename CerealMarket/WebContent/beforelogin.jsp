<%@ page contentType="text/html; charset=utf-8"%>
<%@ page errorPage="ErrorPage.jsp"%>


<html>
<head>
<jsp:include page="/common/header.jsp" />
<link rel="stylesheet"   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">

<title>Welcome to Yeji's Cereal Market</title>
<style type="text/css">
   body { 
            padding: 0px;
            margin: 0px;            
        }
        
    .img{
    	height: 100vh;
    	position: relative;
    	background-image: url("./image/cerealbg2.jpg");                                                            
    	background-size: cover;
	}
        
         	
   .img-cover{
   		position: absolute;
   		height: 100%;
   		width: 100%;
   		text-aligh:center;
   		background-color: rgba(0, 0, 0, 0.3);                                                                 
   		z-index:1;
	}
        	
    .img .content{
     	position: absolute;
     	top:50%;
     	left:50%;
     	transform: translate(-50%, -50%);                                                                   
     	z-index: 2;
     	width: 300px;
     	text-align: center;
	}
</style>
</head>
<body>
	    <div class="img">
        <div class="content">
        <h3 class="display-4" style="color:black;font-family: 'Pacifico', cursive">Welcome ;)</h3>
        <p class="display-7" style="color:white;font-family: 'Pacifico', cursive">Yeji's Cereal Market</p>
				<button class="btn btn-Dark btn-block text-uppercase mb-2 rounded-pill shadow-sm" type="submit" onclick="location.href='member/loginMember.jsp'" style="background-color:black; color:white;font-family: 'Pacifico', cursive">Log In</button>
				<button class="btn btn-Dark btn-block text-uppercase mb-2 rounded-pill shadow-sm" type="submit" onclick="location.href='member/addMember.jsp'" style="background-color:black; color:white;font-family: 'Pacifico', cursive">JOIN</button>
		</div>
	<div class="img-cover"></div>
	</div>
</body>
</html>