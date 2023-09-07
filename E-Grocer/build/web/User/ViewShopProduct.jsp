<%-- 
    Document   : ViewShopProduct
    Created on : Apr 26, 2021, 1:14:13 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Shop Product</title>
    </head>
    
    <body>
        <%
            if(request.getParameter("pid")!=null){
                session.setAttribute("pid", request.getParameter("pid"));
                response.sendRedirect("AddToCart.jsp");
            }
            if(request.getParameter("scid")!=null){
                String sel0 = "select * from tbl_cartbody where cart_id = '"+request.getParameter("scid")+"'";
                ResultSet rs0 = con.selectCommand(sel0);
                if(rs0.next()){
                    do{
                        int newQty = 0;
                        String sel01 = "Select * from tbl_masterstock where shopproduct_id = '"+rs0.getString("shopproduct_id")+"'";
                        ResultSet rs01 = con.selectCommand(sel01);
                        rs01.next();
                        newQty = (Integer.parseInt(rs01.getString("mstock_qty"))) + (Integer.parseInt(rs0.getString("cart_itemqty")));
                        String upd = "update tbl_masterstock set mstock_qty = '"+newQty+"' where shopproduct_id = '"+rs0.getString("shopproduct_id")+"'";
                        con.executeCommand(upd);
                        String upd1 = "update tbl_cartbody set cart_itemstatus = 0 where shopproduct_id = '"+rs0.getString("shopproduct_id")+"' and cart_id = '"+request.getParameter("scid")+"'";
                        con.executeCommand(upd1);
                    }while(rs0.next());
                }
            }
            String sel1 = "select * from tbl_carthead tch inner join tbl_cartbody tcb on tch.cart_id = tcb.cart_id "
                        + "where user_id = '"+session.getAttribute("userid")+"' and cart_status = 0 and shop_id = '"+request.getParameter("shid")+"'";
            ResultSet rs1 = con.selectCommand(sel1);
            if(rs1.next()){
        %>
                            
                <td><a href="ProceedToPurchase.jsp?cid=<%=rs1.getString("cart_id")%>">Proceed to purchase</a></td>
     
        <%
            }else{
        %>
        <h1> </h1>
        <%
            }
            String sel = "select * from tbl_shopproduct shp inner join tbl_product p on shp.product_id = p.product_id "
                       + "inner join tbl_masterstock ms on ms.shopproduct_id = shp.shopproduct_id "
                       + "inner join tbl_brand b on shp.brand_id = b.brand_id "
                       + "inner join tbl_category c on c.category_id = p.category_id "
                       + "where shp.shop_id='"+request.getParameter("shid")+"' order by category_name asc, product_name asc, brand_name asc";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
        %>               
                <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <%
                int i=0;
                do{
                    i++;
            %>
                    <tr>
                        <td rowspan="4"><img src="../Assets/Product Image/<%=rs.getString("product_img")%>" width="80" height="80" alt="Product Image"></td>
                        <td><%=rs.getString("brand_name")%> <%=rs.getString("product_name")%></td>
                        <td rowspan="4">
            <%
                    if((Integer.parseInt(rs.getString("mstock_qty")))>0){
            %>
            <b><a href="ViewShopProduct.jsp?pid=<%=rs.getString("shopproduct_id")%>" style="color:green;">Add to cart</a></b>
            <%
                    }else{
            %>
                            <b style="color:red;">Out of Stock</b>
            <%
                    }
            %>
                        </td>
                    </tr>
                    <tr>
                        <td>Category   : <%=rs.getString("category_name")%></td>
                    </tr>
                    <tr>
                        <td>Price: ₹<%=rs.getString("mstock_price")%> </td>
                    </tr>
                    <tr>
                        <td>Product Description: <%=rs.getString("shopproduct_desc")%> </td>
                    </tr>
            <%
                }while(rs.next());
            %>
                </table>
        <%
            }
            else{
        %>
        
        <center><h1>We are closed now. Sorry for the inconvenience caused.. </h1></center>
        
        <%
            }
        %>
        <a href="SearchShop.jsp">Shop Lists</a>
    </body>
    
</html>
