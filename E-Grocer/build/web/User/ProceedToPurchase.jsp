<%-- 
    Document   : ProceedToPurchase
    Created on : May 22, 2021, 8:46:11 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Proceed To Purchase</title>
    </head>
    
    <body>
        
        <%
            session.setAttribute("cartiid",request.getParameter("cid"));
            String sel = "select * from tbl_carthead tch inner join tbl_cartbody tcb on tch.cart_id = tcb.cart_id "
                       + "inner join tbl_shopproduct tsp on tcb.shopproduct_id = tsp.shopproduct_id inner join tbl_brand tb on tsp.brand_id = tb.brand_id "
                       + "inner join tbl_product tp on tsp.product_id = tp.product_id where tch.cart_id = '"+request.getParameter("cid")+"'";
            ResultSet rs = con.selectCommand(sel);
           // session.setAttribute("sciid", request.getParameter("cid"));
            if(rs.next()){
        %>
        <center><h1>Your Order</h1></center>
        <form method="POST">
            <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
                <thead>
                    <th>Product</th>
                    <th>Qty</th>
                    <th>Price</th>
                    <th>Net Price</th>
                    <th>Action</th>
                </thead>
                <tbody>
        <%
                int newQty = 0;
                float net = 0 , itemcost = 0;
                do{          
                    itemcost = (Float.parseFloat(rs.getString("cart_itemprice")))*(Integer.parseInt(rs.getString("cart_itemqty")));                    
        %>
                    <tr>
                        <td><%=rs.getString("brand_name")%> <%=rs.getString("product_name")%></td>
                        <td><%=rs.getString("cart_itemqty")%></td>
                        <td>₹<%=rs.getString("cart_itemprice")%></td>
                        <td>₹<%=itemcost%></td>
                        <td>
                            <%
                                String selct = "select * from tbl_masterstock where shopproduct_id = '"+rs.getString("shopproduct_id")+"'";
                                ResultSet rset = con.selectCommand(selct);
                                rset.next();
                                if((Integer.parseInt(rset.getString("mstock_qty")))>=(Integer.parseInt(rs.getString("cart_itemqty")))){
                                    net += itemcost;
                                    newQty = (Integer.parseInt(rset.getString("mstock_qty"))) - (Integer.parseInt(rs.getString("cart_itemqty")));
                                //    out.println(newQty);
                                    String upd = "update tbl_masterstock set mstock_qty = '"+newQty+"' where shopproduct_id = '"+rs.getString("shopproduct_id")+"'";
                                //    out.println(upd);
                                    con.executeCommand(upd);
                                    String upd1 = "update tbl_cartbody set cart_itemstatus = 1 where shopproduct_id = '"+rs.getString("shopproduct_id")+"' and cart_id = '"+request.getParameter("cid")+"'";
                                    con.executeCommand(upd1);
                            %>
                            <b><a href="AddToCart.jsp?ppid=<%=rs.getString("shopproduct_id")%>&scciid=<%=request.getParameter("cid")%>" style="color:blue;">Update/Remove</a></b>
                            <%
                                }else{
                                   String delt = "delete from tbl_cartbody where cart_id = '"+request.getParameter("cid")+"' and shopproduct_id = '"+rs.getString("shopproduct_id")+"'";
                                   if(con.executeCommand(delt)){
                            %>
                            <b style="color:red;">Removed due to out of stock</b>
                            <%
                                    }
                                }
                            %>
                        </td>
                    </tr>
        <%
                }while(rs.next());
        %>
                    <tr>
                        <form method="POST">
                            <td colspan="3"><b><center>Total Net Price</center></b></td>
                            <td><b>₹<%=net%></b></td>
                            <td align="center"><a href="ModeSelection.jsp?cartid=<%=request.getParameter("cid")%>">Proceed</a></td>
                        </form>
                    </tr>
                </tbody>
            </table>
        </form>
        <%  
            String pupd = "Update tbl_carthead set cart_price = '"+net+"' where cart_id = '"+request.getParameter("cid")+"'";
            con.executeCommand(pupd);
            }else{
        %>
        <h3>Cart is currently empty, if you have added something and if it is not displaying here then it is because the item you ordered is now out of stock.</h3>
        <%
            }
            String selt = "select * from tbl_carthead where cart_id = '"+request.getParameter("cid")+"'";
            ResultSet rst = con.selectCommand(selt);
            if(rst.next()){
        %>
        <b><a href="ViewShopProduct.jsp?shid=<%=rst.getString("shop_id")%>&scid=<%=request.getParameter("cid")%>">Go back to shop</a></b>
        <%
            }
        %>
    </body>
    
</html>
