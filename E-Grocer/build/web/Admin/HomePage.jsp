<%-- 
    Document   : HomePage
    Created on : Apr 5, 2021, 2:36:06 PM
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
         //   out.print(session.getAttribute("username"));      
         %></h1>
         <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
             
            <thead>
                <th>Location</th>
                <th>Grocer Manager</th>
                <th>Delivery Agent Manager</th>
                <th>Inventory Manager</th>
                <th>Mailbox Manager</th>
            </thead>
             
            <tbody>
                <tr>
                    <td><a href="StateDetails.jsp">State</a></td>
                    <td><a href="ShopList-New.jsp">Shop Requests</a></td>
                    <td><a href="DeliveryAgentList-New.jsp">Delivery Agent Requests</a></td>
                    <td><a href="Category.jsp">Category</a></td>
                    <td><a href="ComplaintInbox.jsp">Complaint Inbox</a></td>
                </tr>
                <tr>
                    <td><a href="District.jsp">District</a></td>
                    <td><a href="ShopList-Accepted.jsp">Accepted Shops</a></td>
                    <td><a href="DeliveryAgentList-Accepted.jsp">Accepted Delivery Agents</a></td>
                    <td><a href="BrandManagement.jsp">Brand</a></td>
                    <td><a href="ComplaintRead.jsp">Complaint Read</a></td>
                </tr>
                <tr>
                    <td><a href="Place.jsp">Place</a></td>
                    <td><a href="ShopList-Rejected.jsp">Rejected Shops</a></td>
                    <td><a href="DeliveryAgentList-Rejected.jsp">Rejected Delivery Agents</a></td>
                    <td><a href="ProductManagement.jsp">Product</a></td>
                    <td><a href="ComplaintReply.jsp">Complaint Reply</a></td>
                </tr>
            </tbody>
             
         </table>
         
         
    </body>
</html>
