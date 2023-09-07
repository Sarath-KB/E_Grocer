<%-- 
    Document   : UpdateOrderStatus
    Created on : May 9, 2021, 3:40:51 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Order Status</title>
    </head>
    
    <body>
        <%
           if(request.getParameter("ctid")!=null){
               String upd = "update tbl_carthead set cart_delvstat = 1 where cart_id = '"+request.getParameter("ctid")+"' ";
               if(con.executeCommand(upd)){
                   response.sendRedirect("ViewOrders.jsp");
               }else{
        %>
        <script type="text/javascript">
            alert("Sorry, we couldn't process your request at the moment please try again after sometime if the problem still persists please contact your admin.");
            setTimeout(function(){window.location.href='ViewOrders.jsp'},40);
        </script>
        <%
               }
           }
           String sel = "select * from tbl_carthead tch inner join tbl_cartbody tcb on tch.cart_id = tcb.cart_id "
                      + "inner join tbl_shopproduct tsp on tcb.shopproduct_id = tsp.shopproduct_id inner join tbl_brand tb on tsp.brand_id = tb.brand_id "
                      + "inner join tbl_product tp on tsp.product_id = tp.product_id inner join tbl_user tur on tur.user_id = tch.user_id "
                      + "inner join tbl_place tpc on tpc.place_id = tur.place_id inner join tbl_district tdt on tdt.district_id = tpc.district_id "
                      + "where tch.cart_id = '"+request.getParameter("cid")+"' ";
           ResultSet rs = con.selectCommand(sel);
           if(rs.next()){
        %>
        <h1><center>Order Detail</center></h1>        
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <tr>
                <td colspan="2">Order ID: <b><%=rs.getString("cart_id")%></b></td>
            </tr>
            <tr>
                <td>Date: <b style="color:red;"><%=rs.getString("cart_date")%></b></td>
                <td>Expected Time: <b style="color:green;"><%=rs.getString("cart_time")%></b></td>
            </tr>
            <tr>
                <td colspan="2">Customer Name: <b><%=rs.getString("user_name")%></b></td>
            </tr>
            <tr>
                <td colspan="2">Address: <b><%=rs.getString("address")%>, <%=rs.getString("place_name")%>, <%=rs.getString("district_name")%></b></td>
            </tr>
            <tr>
                <td>Phone: <b><%=rs.getString("contact")%></b></td>
                <td>Email: <b><%=rs.getString("email")%></b></td>
            </tr>
        </table>
        <h1> </h1>
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <thead>
                <th>Product</th>
                <th>Qty</th>
                <th>Price</th>
            </thead>
            <tbody>
        <%
                do{                             
        %>
                <tr>
                    <td><%=rs.getString("brand_name")%> <%=rs.getString("product_name")%></td>
                    <td><%=rs.getString("cart_itemqty")%></td>
                    <td>₹<%=rs.getString("cart_itemprice")%></td>
                </tr>
        <%
                }while(rs.next());
        %>
                <tr>
                    <td colspan="3" align="center"><a href="UpdateOrderStatus.jsp?cid=<%=request.getParameter("cid")%>&ctid=<%=request.getParameter("cid")%>">Order Packed</a></td>
                </tr>
            </tbody>
        </table>
        <%
           }else{
        %>
        <script type="text/javascript">
            alert("Sorry for the inconvenience caused..");
            setTimeout(function(){window.location.href='ViewOrders.jsp'},40);
        </script>
        <%
           }
        %>
    </body>
    
</html>
