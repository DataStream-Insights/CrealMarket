<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.cereal"%>
<%@ page import="dao.cerealRepository"%>

<head>
<jsp:include page="/common/header.jsp" />
<title>Welcome to Yeji's Cereal Market</title>

<link rel="stylesheet"   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=PT+Sans+Narrow:wght@700&display=swap" rel="stylesheet">


<style>
   body { 
            padding: 0px;
            margin: 0px;   
            background-image: url("./image/cinnamonbg.jpeg");
            background-repeat: no-repeat;
            background-size: cover;
     
        }
</style>

</head>


<body>
           
   <div class="container">
         

      <div class="row">
         <div class="col-md-12 mb-4"><!-- 로고 -->
        <a class="navbar-brand" href="main.jsp"><img class="featurette-image img-responsive center-block" src="./image/cerealicon2.png" data-src="holder.js/500x500/auto" alt="Generic placeholder image" style="width:102px; height:39px;"></a>
        </div>
        <div class="col-md-12">
        <div class="row">
        <%
				cerealRepository dao = cerealRepository.getInstance();
                ArrayList<cereal> listOfcereal = dao.getAllcereal();
                
            for (int i = 0; i < listOfcereal.size(); i++) {
               cereal cereal = listOfcereal.get(i);
               
               int a = cereal.getCompare();
               
               if(a >= 20 && a <= 29){
                  
               
         %>
        <div class="col-3">
          <div class="card mb-2" style="background-color: #ffffff88; ">
            <img class="product-image"
            	src="<%=cereal.getFile()%>" 
			     data-product-id="<%=cereal.getId()%>"
			     data-product-name="<%=cereal.getName()%>"
			     data-product-price="<%=cereal.getPrice()%>"
			     alt=" " 
			     onclick="location.href='./cinnamonview.jsp?id=<%=cereal.getId()%>'"
			     />
            <div class="card-body">
              <h5 class="card-title" style="color:#8B00FF; text-align:center; font-family: 'PT Sans Narrow', sans-serif;"><%=cereal.getName()%></h5>    
              <p class="card-text" style="text-align:center; color:#39FF14; font-family: 'PT Sans Narrow', sans-serif;"><%=cereal.getPrice()%>$</p>

            </div>
          </div>
        </div>
        <%
               }
        }
                         
        %>
            </div>
        </div>
      </div>
    </div>
        
 

</body>
</html>