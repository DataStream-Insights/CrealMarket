<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.cereal"%>
<%@ page import="dao.cerealRepository"%>

<%
    String id = request.getParameter("id");
    if (id == null || id.trim().equals("")) {
        response.sendRedirect("cart.jsp");
        return;
    }

    cerealRepository dao = cerealRepository.getInstance();
    
    cereal cereal = dao.getcerealById(id);
    if (cereal == null) {
        response.sendRedirect("ErrorPage.jsp");
        return;
    }

    ArrayList<cereal> cartList = (ArrayList<cereal>) session.getAttribute("cartlist");
    if (cartList == null) {
        response.sendRedirect("cart.jsp");
        return;
    }

    for (int i = 0; i < cartList.size(); i++) {
        if (cartList.get(i).getId().equals(id)) {
            cartList.remove(i);
            break;
        }
    }

    response.sendRedirect("cart.jsp");
%>