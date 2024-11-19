<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.cereal"%>
<%@ page import="dao.cerealRepository"%>

<%
    String id = request.getParameter("cartId");
    
    if (id == null || id.trim().equals("")) {
        response.sendRedirect("cart.jsp");
        return;
    }

    // 현재 세션 ID와 전달받은 cartId가 일치하는지 확인
    if (session.getId().equals(id)) {
        // 장바구니만 삭제
        session.removeAttribute("cartlist");
        // 새로운 세션 생성
        request.getSession(true);
    }
    
    response.sendRedirect("cart.jsp");
%>