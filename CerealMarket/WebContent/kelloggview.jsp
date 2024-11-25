<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.cereal"%>
<%@ page import="dao.cerealRepository"%>


<html>

<head>
<jsp:include page="/common/header.jsp" />
<title>Welcome to Yeji's Market</title>
<script type="text/javascript">
	function addToCart() {
		if (confirm("buy now?")) {
			document.addForm.submit();
		} else {
			document.addForm.reset();
		}
	}
</script>

<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Zilla+Slab:ital,wght@1,500&display=swap" rel="stylesheet">

<style>

      body  {
    background: #ececec;
    padding: 0px;
	margin: 0px;
    font-family: 'Zilla Slab', serif;
    color: #444;
  }
  .button-wrapper {
    display: inline-block;
    margin: 20px 5px;
    padding: 40px;
  }
  .dark-button,
  .dark-button-2 {
    background: #333;
  }
  .button {
    background: #fff;
    border: none;
    padding: 2px;
    cursor: pointer;
    display: block;
    position: absolute;
    top: 500px;
    left: -500px;
    overflow: hidden;
    transition: all .35s ease-in-out .35s;
      margin: 30px;
      width: 200px;
      text-align: center;
  }
  .dark-button .button,
  .dark-button .button span {
    background: #36B4C7;
    color: #fff;
  }
  .dark-button .button:after,
  .dark-button .button:before,
  .dark-button .button:hover span {
    background: #fff;
    color: #444;
  } 
  .dark-button-2 .button,
  .dark-button-2 .button span {
    background: #333;
    color: #fff;
  }
  .dark-button-2 .button:after,
  .dark-button-2 .button:before,
  .dark-button-2 .button:hover span {
    background: #fff;
    color: #444;
  } 
  span {
    display: block;
    padding: 15px 30px;
    background: #fff;
    z-index: 100;
    position: relative;
    transition: all .35s ease-in-out .35s;
  }
  .button:hover span {
    background: #041486;
    color: #fff;
    transition: all .35s ease-in-out .35s;
  }
  .button:after {
    bottom: -100%;
    right: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: black;
    transition: all .35s ease-in-out .5s;
  }
  .button:hover:after {
    right: 0;
    bottom: 0;
    transition: all ease-in-out .35s;
  }
  .button:before {
    top: -100%;
    left: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: black;
    transition: all .35s ease-in-out .5s;
  }
  .button:hover:before {
    left: 0;
    top: 0;
    transition: all ease-in-out .35s;
  }

</style>

</head>


<body style="background-color: #bb3431;">

<!-- 메뉴바 호출 -->
<%@ include file="menu.jsp" %>


<!-- 제품 페이지 -->
<%

  String aid = request.getParameter("id");
  cerealRepository dao = cerealRepository.getInstance();
  cereal cereal = dao.getId(aid);

%>
<div class="container">

      <div class="row">
         <div class="col-md-6 mt-3">
           <img class="featurette-image img-responsive center-block" src="<%=cereal.getFile()%>" data-src="holder.js/500x500/auto" alt="Generic placeholder image" style="width:350px; height:400px; position:absolute; top:70; left:20;">
        </div>
        <div class="col-md-6">
        <div class="row">
          <h1 style="color:black; font-family: 'Zilla Slab', serif; font-size:35px; position:absolute; top:120;"><%=cereal.getName()%></h1>
          <p class="card-text" style="text-align:center; color:#041486; font-family: 'Zilla Slab', serif; font-size:20px; position:absolute; top:190;">Price: <%=cereal.getPrice()%>$</p>
          <p style="color:white; font-family: 'Zilla Slab', serif; font-size:24px; position:absolute; top:230;"><%=cereal.getNote()%></p>  
          <p><form name = "addForm" action="./addCart.jsp?id=<%=cereal.getId()%> " method="post">
          <div class="light-button button-wrapper">
  			<div class="button" onclick="addToCart()">
    			<span>Buy Now</span>
  			</div>  
		  </div>
		  </form> 
        </div>
        </div>
      </div>
    </div>

</body>
</html>