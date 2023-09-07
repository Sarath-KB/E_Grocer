<%-- 
    Document   : ProductEntry
    Created on : Apr 22, 2021, 11:14:55 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management</title>
    </head>
    <body>
        
        <%
            if (request.getParameter("delid") != null) {

                String delqry = "delete from tbl_product where product_id='" + request.getParameter("delid") + "'";
                if (con.executeCommand(delqry)) {
                    out.println("<script>alert('deleted')</script>");
                    response.sendRedirect("ProductManagement.jsp");
                } else {
                    out.println("<script>alert('failed')</script>");
                }
            }
        %>
        
        <form method="POST" enctype="multipart/form-data" action="../ActionPages/ProductUpload.jsp">
            
            <table>
                <tr>
                    <td>
                        Category:
                    </td>
                    <td>
                        <select name="sel_category" required="required">
                            <option>---choose---</option>
                            <%
                                String sel = "select * from tbl_category";
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
                    <td>
                        Product Name:
                    </td>
                    <td>
                        <input type="text" name="txtproduct" required="required"/>
                        <input type="hidden" name="txt_productid"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        Product Image:
                    </td>
                    <td>
                        <input type="file" name="fl_productimg" required="required"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="Submit" name="btnsubmit"/>
                        <input type="reset" value="Reset"/>
                    </td>
                </tr>
            </table>
                        
            <table border="1" align="center" cellpadding="10">
            <tr>
                <td>Product Image</td>
                <td>Product Name</td>
                <td>Category Name</td>
                <td colspan="2">Action</td>
            </tr>

            <%                
                String sel_place = "select * from tbl_product p inner join tbl_category c on p.category_id=c.category_id order by product_id desc";
                ResultSet rs1 = con.selectCommand(sel_place);
                while (rs1.next()) {
            %>
            <tr>
                <td><img src="../Assets/Product Image/<%=rs1.getString("product_img") %>" width="80" height="80" alt="Product Image"></td>
                <td><%=rs1.getString("product_name")%></td>
                <td><%=rs1.getString("category_name")%></td>
                <td><a href="ProductManagement.jsp?delid=<%=rs1.getString("product_id")%>">Delete</a></td>
            </tr>
            <%
                }
            %>


        </table>
        </form>
    </body>
</html>
