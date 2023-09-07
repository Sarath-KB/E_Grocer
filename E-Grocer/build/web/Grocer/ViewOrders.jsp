<%-- 
    Document   : ViewOrders
    Created on : May 9, 2021, 3:40:23 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Orders</title>
    </head>
    
    <body>
        <h1 align="center">New Orders</h1>
        <%
            String sel = "select * from tbl_carthead where cart_status!=0 and cart_delvstat=0 and shop_id = '"+session.getAttribute("userid")+"' order by cart_date desc, cart_time asc";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
        %>
        <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
            <thead>
                <th>Date - Order Placed</th>
                <th>Expected Time</th>
                <th>View Order</th>
            </thead>
            <tbody>
        <%
                do{
        %>
                <tr>
                    <td><%=rs.getString("cart_date")%></td>
                    <td><%=rs.getString("cart_time")%></td>
                    <td><a href="UpdateOrderStatus.jsp?cid=<%=rs.getString("cart_id")%>">View Order</a></td>
                </tr>
        <%
                }while(rs.next());
        %>
            </tbody>
        </table>
        <%
            }else{
                out.println("No new orders were placed with us");
            }
        %>
    </body>
    
</html>
