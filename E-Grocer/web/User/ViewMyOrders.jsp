<%-- 
    Document   : ViewMyOrders
    Created on : May 9, 2021, 3:42:04 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View My Orders</title>
    </head>
    
    <body>
        <h1 align = "center">Your Orders</h1>
        <h1> </h1>
        <%
            String sel = "select * from tbl_carthead tch inner join tbl_shop tsp on tch.shop_id = tsp.shop_id inner join tbl_place tpl on tpl.place_id = tsp.place_id "
                       + "where tch.user_id = '"+session.getAttribute("userid")+"'  and tch.cart_status!=0 order by tch.cart_date desc, tch.cart_time desc";
            ResultSet rs = con.selectCommand(sel);
    //        out.println(sel);
            if(rs.next()){
                do{
        %>
         <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
            <tr>
                <td colspan="2"><h2><b><center><%=rs.getString("shop_name")%>, <%=rs.getString("place_name")%></center></b></h2></td>
            </tr>
            <tr>
                <td colspan="2">Order ID: <b style="color:indigo;"><%=rs.getString("cart_id")%></b></td>
            </tr>
            <tr>
                <td>Email: <%=rs.getString("shop_email")%> </td>
                <td>Phone No: <%=rs.getString("shop_contact")%></td>
            </tr>
            <tr>
                <td colspan="2">Ordered Date: <%=rs.getString("cart_date")%></td>
            </tr>
            <tr>
                <td>Net Amount: <b style="color:green;">₹<%=rs.getString("cart_price")%></b></td>
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
        %>
            </tr>
            <tr>
        <%
                if(Integer.parseInt(rs.getString("cart_delvstat"))==0){
        %>
                <td colspan="2">Order Status: <b style="color:blue;">Order is placed</b></td>
        <%
                }else if(Integer.parseInt(rs.getString("cart_delvstat"))==1){
        %>
                <td colspan="2">Order Status: <b style="color:brown;">Order is packed</b></td>
        <%
                }else if(Integer.parseInt(rs.getString("cart_delvstat"))==2){
                    if(Integer.parseInt(rs.getString("cart_delvmod"))==0){
        %>
                <td colspan="2">Order Status: <b style="color:orange;">En-route to you</b></td>
        <%
                    }else{
        %>
                <td colspan="2">Order Status: <b style="color:orange;">Ready at counter</b></td>
        <%
                    }
                }else if(Integer.parseInt(rs.getString("cart_delvstat"))==3){
        %>
                <td colspan="2">Order Status: <b style="color:green;">Order delivered</b></td>
        <%
                }else {
        %>
                <td colspan="2">Order Status: <b style="color:red;">Order rejected and returned</b></td>
        <%
                }
        %>
            </tr>
            <tr>
                <td colspan="2"><center><b><a href="OrderDetail.jsp?cid=<%=rs.getString("cart_id")%>">View Order</a></b></center></td>
            </tr>
        </table>
            <h1> </h1>
        <%
                }while(rs.next());
            }else{
                out.println("You haven't placed any orders yet...");
            }
        %>
        <a href="HomePage.jsp">Home Page</a>
    </body>

</html>
