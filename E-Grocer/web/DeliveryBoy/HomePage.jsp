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
         <a href="HomePage.jsp?id=<%=session.getAttribute("userid")%>">Sign Out</a>
         <%
            if(request.getParameter("id")!=null){
                session.invalidate();
                response.sendRedirect("../Guest/Login.jsp");
            }
        %>
    </body>
</html>