<%-- 
    Document   : HomePage
    Created on : Apr 5, 2021, 2:39:14 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
    </head>
    <body>
        
        <h1>Welcome
        <%
            out.print(session.getAttribute("username"));      
         %></h1>
         <a href="MyProfile.jsp">My Profile</a>
         <a href="EditProfile.jsp">Edit Profile</a>
         <a href="ChangePassword.jsp">Change Password</a>
         <a href="SetSlotBundle.jsp">Slot Setting</a>
         <a href="ViewAllSlots.jsp">View Slots</a>
         <a href="ShopProduct.jsp">Shop Product</a>
         <a href="AllOrders.jsp">All Orders</a>
         <a href="ViewOrders.jsp">New Orders</a>
         <a href="UpdateModeStatus.jsp">Packing Order</a>
         <a href="ViewDeliveryStatus.jsp">Order on Counter</a>
         <a href="DeliveryStatus.jsp">Home Delivery Status</a>
         <a href="ViewNewFeedbacks.jsp">New Feedbacks</a>
         <a href="ViewReadFeedbacks.jsp">Read Feedbacks</a>
         <a href="NeedHelp.jsp">Talk to Admin</a>
         <a href="ViewAdminReply.jsp">Admin Reply</a>
         <a href="HomePage.jsp?id=<%=session.getAttribute("userid")%>">Sign Out</a>
         <%
            if(request.getParameter("id")!=null){
                session.invalidate();
                response.sendRedirect("../Guest/Login.jsp");
            }
        %>
    </body>
</html>
