<%-- 
    Document   : ViewOrder
    Created on : May 29, 2021, 11:04:48 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail</title>
    </head>
    
    <body>
        <%
            String sel = "select * from tbl_carthead tch inner join tbl_cartbody tcb on tch.cart_id = tcb.cart_id "
                       + "inner join tbl_shopproduct tsp on tcb.shopproduct_id = tsp.shopproduct_id inner join tbl_brand tb on tsp.brand_id = tb.brand_id "
                       + "inner join tbl_product tp on tsp.product_id = tp.product_id inner join tbl_user tur on tur.user_id = tch.user_id "
                       + "where tch.cart_id = '"+request.getParameter("crtid")+"'";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
                float net = Float.parseFloat(rs.getString("cart_price"));
        %>
        <h1><center>Order Detail</center></h1>
        
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <tr>
                <td colspan="3">Order ID: <%=rs.getString("cart_id")%></td>
            </tr>
            <tr>
                <td colspan="3">Date: <%=rs.getString("cart_date")%></td>
            </tr>
            <tr>
                <td colspan="3">Expected Time: <%=rs.getString("cart_time")%></td>
            </tr>
            <tr>
                <td colspan="3">Customer Name: <%=rs.getString("user_name")%></td>
            </tr>
            <tr>
                <td>Phone: <%=rs.getString("contact")%></td>
                <td colspan="2">Email: <%=rs.getString("email")%></td>
            </tr>
            <tr>
                <td>Amount: <b style="color:green;">₹<%=rs.getString("cart_price")%></b></td>
        <%
                if(Integer.parseInt(rs.getString("cart_paystat"))==0){
        %>
                <td>Payment Status: <b style="color:red;">Not paid</b></td>
        <%
                }else{
        %>
                <td>Payment Status: <b style="color:green;">Paid</b></td>
        <%
                }
                if(Integer.parseInt(rs.getString("cart_paymod"))==0){
        %>
                <td>Payment Mode: Pay Now</td>
        <%
                }else{
        %>
                <td>Payment Mode: Cash on Delivery</td>
        <%
                }
        %>
            </tr>
            <tr>
        <%
                if(Integer.parseInt(rs.getString("cart_delvmod"))==0){
        %>
                <td>Mode of Delivery: Home Delivery</td>
        <%
                    if(Integer.parseInt(rs.getString("cart_delvstat"))==0){
        %>
                <td>Delivery Status: <b style="color:blue;">Order is placed</b></td>
        <%
                    }else if(Integer.parseInt(rs.getString("cart_delvstat"))==1){
        %>
                <td>Delivery Status: <b style="color:brown;">Order is packed</b></td>
        <%
                    }else if(Integer.parseInt(rs.getString("cart_delvstat"))==2){
        %>
                <td>Delivery Status: <b style="color:orange;">En-route to you</b></td>
        <%
                    }else if(Integer.parseInt(rs.getString("cart_delvstat"))==3){
        %>
                <td>Delivery Status: <b style="color:green;">Order delivered</b></td>
        <%
                    }else {
        %>
                <td>Order Status: <b style="color:red;">Order rejected and returned</b></td>
        <%
                    }
                    if((rs.getString("da_id"))!=null){
        %>
                <td><a href="ViewDeliveryAgent.jsp?daid=<%=rs.getString("da_id")%>">View Delivery Agent</a></td>
        <%
                    }else{
        %>
                <td><b style="color:red;">No delivery agent assigned yet</b></td>
        <%
                    }
                }else{
        %>
                <td>Mode of Delivery: Take Away</td>
        <%
                    if(Integer.parseInt(rs.getString("cart_delvstat"))==0){
        %>
                <td colspan="2">Delivery Status: <b style="color:blue;">Order is placed</b></td>
        <%
                    }else if(Integer.parseInt(rs.getString("cart_delvstat"))==1){
        %>
                <td colspan="2">Delivery Status: <b style="color:brown;">Order is packed</b></td>
        <%
                    }else if(Integer.parseInt(rs.getString("cart_delvstat"))==2){
        %>
                <td colspan="2">Delivery Status: <b style="color:orange;">Order is ready at counter</b></td>
        <%
                    }else if(Integer.parseInt(rs.getString("cart_delvstat"))==3){
        %>
                <td colspan="2">Delivery Status: <b style="color:green;">Order delivered</b></td>
        <%
                    }else {
        %>
                <td colspan="2">Order Status: <b style="color:red;">Order rejected and returned</b></td>
        <%
                    }
                }
        %>
            </tr>
        </table>
        <h1> </h1>
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <thead>
                <th>Product</th>
                <th>Qty</th>
                <th>Price</th>
                <th>Net Price</th>
            </thead>
            <tbody>
        <%
                float itemcost = 0;
                do{          
                    itemcost = (Float.parseFloat(rs.getString("cart_itemprice")))*(Integer.parseInt(rs.getString("cart_itemqty")));                    
        %>
                <tr>
                    <td><%=rs.getString("brand_name")%> <%=rs.getString("product_name")%></td>
                    <td><%=rs.getString("cart_itemqty")%></td>
                    <td>₹<%=rs.getString("cart_itemprice")%></td>
                    <td>₹<%=itemcost%></td>
                </tr>
        <%
                }while(rs.next());
        %>
                <tr>
                    <td colspan="3"><b><center>Total Net Price</center></b></td>
                    <td><b>₹<%=net%></b></td>                            
                </tr>
            </tbody>
        </table>
        <%
            }else{
                out.println("Sorry for the inconvenience caused requested order details is not available. Please contact admin for assistace");
            }
        %>
    </body>
    
</html>
