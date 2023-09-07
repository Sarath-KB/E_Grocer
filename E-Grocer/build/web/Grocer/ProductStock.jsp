<%-- 
    Document   : ProductStock
    Created on : Apr 23, 2021, 11:38:21 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Stock</title>
    </head>
    <body>
        
        <%
            int curr=0, nay=0;
            if(request.getParameter("btn_submit")!=null){

                        String ins = "insert into tbl_stockupdate(shopproduct_id,stockupd_rate,stockupd_qty,stockupd_date) "
                                   + "values('" + request.getParameter("spid") + "',"
                                   + "'" + request.getParameter("txt_price") + "',"
                                   + "'" + request.getParameter("txt_qty") + "',"
                                   + "'" + request.getParameter("txt_date") + "')";
                        if(con.executeCommand(ins)){
                                out.println("<script>alert('Updated')</script>");
//                              response.sendRedirect(".jsp");
                        }
                        else{
                                out.println("<script>alert('Failed')</script>");
                        }
                        
                        String selt = "select * from tbl_masterstock where shopproduct_id='" + request.getParameter("spid") + "'";
                        ResultSet rs1 = con.selectCommand(selt);
                        if(rs1.next()){
                            curr = Integer.parseInt(rs1.getString("mstock_qty"));
                            nay = curr + Integer.parseInt(request.getParameter("txt_qty"));
                            String upd = "update tbl_masterstock set mstock_qty='"+nay+"', mstock_price = '" + request.getParameter("txt_price") + "'"//additional inclusion of , mstock_price = '" + request.getParameter("txt_price") + "'
                                       + " where shopproduct_id='" + request.getParameter("spid") + "'";
                            con.executeCommand(upd);
//                            out.println("updated");
                        }
                        else{
                            String ins1 = "insert into tbl_masterstock(shopproduct_id,mstock_qty,mstock_price) "//additional inclusion of ,mstock_price
                                        + "values('" + request.getParameter("spid") + "','" + request.getParameter("txt_qty") + "','" + request.getParameter("txt_price") + "')";//additional inclusion of mstock_price = '" + request.getParameter("txt_price") + "'
                            con.executeCommand(ins1);
 //                           out.println("Insert");
                        }
                        response.sendRedirect("ShopProduct.jsp");
                    }
        %>
        
        <h1><center>Update Stock</center></h1>    
        
        <%
            String sel = "select * from tbl_shopproduct sp inner join tbl_product p on sp.product_id=p.product_id "
                       + "inner join tbl_category c on c.category_id=p.category_id "
                       + "inner join tbl_brand b on sp.brand_id=b.brand_id "
                       + "where sp.shopproduct_id='"+request.getParameter("spid")+"' ";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
        %>
        
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <tr>
                <td colspan="2">
                    <img src="../Assets/Product Image/<%=rs.getString("product_img") %>" width="80" height="80" alt="Product Image">
                </td>
            </tr>
            <tr>
                <td>Category:</td>
                <td><%=rs.getString("category_name")%></td>
            </tr>
            <tr>
                <td>Product:</td>
                <td><%=rs.getString("product_name")%></td>
            </tr>
            <tr>
                <td>Brand:</td>
                <td><%=rs.getString("brand_name")%></td>
            </tr>
        <form method="POST">
            <tr>
                <td>Price:</td>
                <td><input type="text" name="txt_price" required="required"/></td>
            </tr>
            <tr>
                <td>Quantity:</td>
                <td><input type="text" name="txt_qty" required="required"/></td>
            </tr>
            <tr>
                <td>Date:</td>
                <td><input type="date" name="txt_date" required="required"/></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" name="btn_submit" value="Update"/>
                    <input type="reset" name="btn_reset" value="Reset"/>
                </td>
            </tr>
        </form>
        </table>
                
        <%
            }
            else{
        %>
                <h1>No records found</h1>
        <%
            }
        %>
        
    </body>
</html>
