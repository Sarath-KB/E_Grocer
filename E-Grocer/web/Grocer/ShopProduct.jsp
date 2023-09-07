<%-- 
    Document   : ProductPricing
    Created on : Apr 22, 2021, 11:18:14 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shop Product</title>
        <script src=" ../JQuery/jQuery.js" type="text/javascript"></script>
        
         
            <script>
            function getProduct(pid)
            {
//	       alert(pid);
                $.ajax({url:"../AjaxPages/AjaxProduct.jsp?product="+pid,
                success: function(result){
//                alert(result);
                $("#sel_product").html(result);}});
            }
            function getBrand(bid)
            {
	//        alert(a);
                $.ajax({url:"../AjaxPages/AjaxBrand.jsp",
                success: function(result){
        //        alert(result);
                $("#sel_brand").html(result);}});
            }
</script>
    </head>
    <body>
        
        <%
            if(request.getParameter("btn_submit")!=null){
                String ins = "insert into tbl_shopproduct(product_id,brand_id,shop_id,shopproduct_desc) "
                           + "values('" + request.getParameter("sel_product") + "',"
                           + "'" + request.getParameter("sel_brand") + "',"
                           + "'" + session.getAttribute("userid") + "',"
                           + "'" + request.getParameter("txt_desc") + "')";
                if (con.executeCommand(ins)) {
                        out.println("<script>alert('inserted')</script>");
                        // response.sendRedirect("ShopProduct.jsp");
                }
                else {
                        out.println("<script>alert('failed')</script>");
                }
            }
            
            if(request.getParameter("delid")!=null){
                String delqry = "delete from tbl_shopproduct where shopproduct_id='" + request.getParameter("delid") + "'";
                if(con.executeCommand(delqry)){
//                    out.println("<script>alert('Deleted')</script>");
                   response.sendRedirect("ShopProduct.jsp");
                }
                else{
                    out.println("<script>alert('Failed')</script>");
                }
            }
        %>
        
        <center><h1>Shop Product</h1></center>
        <form method="POST">
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;" >
                
                <tr>
                    <td>Category: </td>
                    <td>
                        <select name="sel_category" onchange="getProduct(this.value)" >
                            <option>---Select---</option>
                            <%
                                String sel = "select * from tbl_category order by category_name ";
                                ResultSet rs = con.selectCommand(sel);
                                while (rs.next()) {
                            %>
                            <option value="<%=rs.getString("category_id")%>"><%=rs.getString("category_name")%></option>
                            <%
                                }
                            %>                           
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Product: </td>
                    <td>
                        <select name="sel_product" id="sel_product" required="required" onchange="getBrand(this.value)" >
                              <option>---Select---</option>           
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Brand: </td>
                    <td>
                        <select name="sel_brand" id="sel_brand" required="required" >
                              <option>---Select---</option>           
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Product Description: </td>
                    <td>
                        <textarea name="txt_desc" required="required"></textarea>
                    </td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="Submit" name="btn_submit"/>
                        <input type="reset" value="Reset"/>
                    </td>
                </tr>
                
            </table>
        
        </form>
        
        <center><h1> </h1></center>
        
        <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;" >
            
            <thead>
                <th>Category Name</th>
                <th>Product Name</th>
                <th>Brand Name</th>
                <th>Stock</th>
                <th>Lastest Rate</th>
                <th>Product Description</th>
                <th colspan="2">Action</th>
            </thead>
            
            <tbody>
            <%
            //    String PStock="",LastestRate="";
                String sel1 = "select * from tbl_shopproduct sp inner join tbl_product p on sp.product_id=p.product_id "
                            + "inner join tbl_category c on c.category_id=p.category_id inner join tbl_brand br on sp.brand_id=br.brand_id "
                            + "where shop_id = '" + session.getAttribute("userid") + "'";
                ResultSet rs1 = con.selectCommand(sel1);
                while(rs1.next()){
                    String PStock="",LastestRate="";
                    String selStock="select mstock_qty,shopproduct_id from tbl_masterstock where shopproduct_id='"+rs1.getString("shopproduct_id")+"'";
//                    out.print(selStock);
                    ResultSet rsStock=con.selectCommand(selStock);
                    if(rsStock.next()){
                        PStock=rsStock.getString("mstock_qty");
                       
                    }
                    //stockupd_id desc newly added on next line for correction of price incase wrongly entered previously by typing qty as 0 and entering orginal price
                    String selLastestRate="select stockupd_rate,stockupd_date from tbl_stockupdate where shopproduct_id='"+rs1.getString("shopproduct_id")+"' order by stockupd_date desc,stockupd_id desc";
//                    out.print(selLastestRate);
                    ResultSet rsLastestRate=con.selectCommand(selLastestRate);
                   if(rsLastestRate.next()){
                        LastestRate=rsLastestRate.getString("stockupd_rate");
//                        out.print(LastestRate);
                        //next 2lines newly added for mstock_price updation
                        String update = "update tbl_masterstock set mstock_price = '"+rsLastestRate.getString("stockupd_rate")+"' where shopproduct_id='"+rs1.getString("shopproduct_id")+"' ";
                        con.executeCommand(update);
                    }
                    
            %>
        
            <tr>    
                <td><%=rs1.getString("category_name")%></td>
                <td><%=rs1.getString("product_name")%></td>
                <td><%=rs1.getString("brand_name")%></td>
                <td style="color:red;"><%=PStock %></td>
                <td style="color:red;"><%=LastestRate %></td>
                <td><%=rs1.getString("shopproduct_desc")%></td>
                <td><a href="ProductStock.jsp?spid=<%=rs1.getString("shopproduct_id")%>">Update Stock</a></td>
                <td><a href="ShopProduct.jsp?delid=<%=rs1.getString("shopproduct_id")%>">Delete</a></td>
            </tr>
            
            <%
                }
            %>
            </tbody>
            
        </table>
        
    </body>
</html>
