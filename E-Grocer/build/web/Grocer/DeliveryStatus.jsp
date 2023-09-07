<%-- 
    Document   : DeliveryStatus
    Created on : May 30, 2021, 12:22:16 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders</title>
    </head>
    <body>
        <h1 align="center">All orders</h1>
        <h1> </h1>
        <form method="POST">
            <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
                <tr>
                    <td><input type="text" name="txt_keyword" placeholder="Enter the order id" required="required"/></td>
                    <td><input type="submit" name="btn_search" value="Search"></td>
                </tr>
            </table>
        </form>
        <h1> </h1>
        <%
            if(request.getParameter("btn_search")!=null){
                String sel_qry = "select * from tbl_carthead tch inner join tbl_user tur on tch.user_id = tur.user_id where tch.shop_id = '"+session.getAttribute("userid")+"' and "
                               + "tch.cart_id = '"+request.getParameter("txt_keyword")+"' and tch.cart_status!=0 and tch.cart_delvmod = 0";
                ResultSet rsq = con.selectCommand(sel_qry);
                if(rsq.next()){
        %>
                    <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
        <%
                    do{
        %>
                        <tr>
                            <td colspan="2">Order Id: <b><%=rsq.getString("cart_id")%></b></td>
                            <td rowspan="5"><b align="center"><a href="ViewOrderDetail.jsp?oid=<%=rsq.getString("cart_id")%>">View Order</a></b></td>
                        </tr>
                        <tr>
                            <td colspan="2">Customer Name: <b><%=rsq.getString("user_name")%></b></td>
                        </tr>
                        <tr>
                            <td>Phone: <b><%=rsq.getString("contact")%></b></td>
                            <td>Email ID: <b><%=rsq.getString("email")%></b></td>
                        </tr>
                        <tr>
                            <td>Date ordered: <b><%=rsq.getString("cart_date")%></b></td>
                            <td>Expected Time: <b><%=rsq.getString("cart_time")%></b></td>
                        </tr>
                        <tr>
                            <td>Amount: <b style="color:green;">₹<%=rsq.getString("cart_price")%></b></td>
        <%
                        if(Integer.parseInt(rsq.getString("cart_delvstat"))==0){
        %>
                            <td>Delivery Status: <b style="color:blue;">Order is placed</b></td>
        <%
                        }else if(Integer.parseInt(rsq.getString("cart_delvstat"))==1){
        %>
                            <td>Delivery Status: <b style="color:brown;">Order is packed</b></td>
        <%
                        }else if(Integer.parseInt(rsq.getString("cart_delvstat"))==2){
        %>
                            <td>Delivery Status: <b style="color:orange;">En-route to you</b></td>
        <%
                        }else if(Integer.parseInt(rsq.getString("cart_delvstat"))==3){
        %>
                            <td>Delivery Status: <b style="color:green;">Order delivered</b></td>
        <%
                        }else {
        %>
                            <td>Order Status: <b style="color:red;">Order rejected and returned</b></td>
        <%
                        }
        %>
                        </tr>
        <%
                    }while(rsq.next());
        %>
                    </table>
        <%
                }else{
        %>
        <script type="text/javascript">
            alert("No orders found");
            setTimeout(function(){window.location.href='DeliveryStatus.jsp'},40);
        </script>
        <%
                }
            }else{
                String sel = "select * from tbl_carthead tch inner join tbl_user tur on tur.user_id = tch.user_id "
                           + "where tch.shop_id = '"+session.getAttribute("userid")+"' and tch.cart_status != 0 and tch.cart_delvmod = 0 order by tch.cart_date desc, tch.cart_time asc";
                ResultSet rs = con.selectCommand(sel);
                if(rs.next()){
        %>
                    <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
        <%
                    do{
        %>
                        <tr>
                            <td colspan="2">Order Id: <b><%=rs.getString("cart_id")%></b></td>
                            <td rowspan="5"><b align="center"><a href="ViewOrderDetail.jsp?oid=<%=rs.getString("cart_id")%>">View Order</a></b></td>
                        </tr>
                        <tr>
                            <td colspan="2">Customer Name: <b><%=rs.getString("user_name")%></b></td>
                        </tr>
                        <tr>
                            <td>Phone: <b><%=rs.getString("contact")%></b></td>
                            <td>Email ID: <b><%=rs.getString("email")%></b></td>
                        </tr>
                        <tr>
                            <td>Date ordered: <b><%=rs.getString("cart_date")%></b></td>
                            <td>Expected Time: <b><%=rs.getString("cart_time")%></b></td>
                        </tr>
                        <tr>
                            <td>Amount: <b style="color:green;">₹<%=rs.getString("cart_price")%></b></td>
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
        %>
                        </tr>
        <%
                    }while(rs.next());
        %>
                    </table>
        <%            
                }else{
        %>
        <h1>No new orders</h1>
        <%
                }
            }
        %>
    </body>
</html>