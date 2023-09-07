<%-- 
    Document   : OrderDetail
    Created on : May 29, 2021, 12:31:16 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
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
            session.setAttribute("orderid", request.getParameter("cid"));
            String sel = "select * from tbl_carthead tch inner join tbl_cartbody tcb on tch.cart_id = tcb.cart_id "
                       + "inner join tbl_shopproduct tsp on tcb.shopproduct_id = tsp.shopproduct_id inner join tbl_brand tb on tsp.brand_id = tb.brand_id "
                       + "inner join tbl_product tp on tsp.product_id = tp.product_id where tch.cart_id = '"+request.getParameter("cid")+"'";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
                float net = Float.parseFloat(rs.getString("cart_price"));
        %>
        <h1><center>Order Detail</center></h1>
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
                    <tr>
                      <!--  <td align="center" colspan="4"><b><a href="ReachYourGrocer.jsp?cartid=<%=request.getParameter("cid")%>">Reach out to your grocer</a></b></td> -->
                        <td align="center" colspan="4"><b><a href="ReachYourGrocer.jsp">Reach out to your grocer</a></b></td>
                    </tr>
        <%
                String sel1 = "select * from tbl_msgshop where cart_id = '"+request.getParameter("cid")+"'";
                ResultSet rs1 = con.selectCommand(sel1);
                if(rs1.next()){
        %>
                    <tr>
                        <td align="center" colspan="4"><b><a href="ViewYourFeedback.jsp">View your message</a></b></td>
                    </tr>
        <%
                }
        %>
                </tbody>
            </table>
        <%
            }else{
                out.println("Sorry for the inconvenience caused requested order details of yours is not available now please come back after sometime");
            }
        %>
        <a href="ViewMyOrders.jsp">Back</a>
    </body>
    
</html>
