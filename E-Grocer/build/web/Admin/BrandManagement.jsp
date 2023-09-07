<%-- 
    Document   : BrandEntry
    Created on : Apr 22, 2021, 11:15:21 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Brand Management</title>
    </head>
    <body>
        
        <%
            String EditBrandName="",EditBrandid="";
            
            if(request.getParameter("btn_submit")!=null){
//                    out.print("Id"+request.getParameter("txt_categoryid"));
                    if(request.getParameter("txt_brandid")!=""){
                    
                    
                       String upData="update tbl_brand set "
                               + "brand_name='"+request.getParameter("txt_brand")+"' "
                               + "where brand_id='"+request.getParameter("txt_brandid")+"'";
                       
                                if(con.executeCommand(upData)){
//                                out.println("<script>alert('Updated')</script>");
                                    response.sendRedirect("BrandManagement.jsp");
                                }
                                else{
                                out.println("<script>alert('Failed')</script>");
                                }
                    
                    
                    
                    }
                    else{
                        String ins = "insert into tbl_brand(brand_name)values('" + request.getParameter("txt_brand") + "')";
                        if(con.executeCommand(ins)){
//                                out.println("<script>alert('Inserted')</script>");
                                response.sendRedirect("BrandManagement.jsp");
                        }
                        else{
                                out.println("<script>alert('Failed')</script>");
                        }
                    }
            }
            
            if(request.getParameter("delid")!=null){
                String delqry = "delete from tbl_brand where brand_id='" + request.getParameter("delid") + "'";
                if(con.executeCommand(delqry)){
//                    out.println("<script>alert('Deleted')</script>");
                   response.sendRedirect("BrandManagement.jsp");
                }
                else{
                    out.println("<script>alert('Failed')</script>");
                }
            }
            
            
            
            if(request.getParameter("edid")!=null){
            
            
                String EditSel="select * from tbl_brand where brand_id='"+request.getParameter("edid")+"'";
                ResultSet rsEdit=con.selectCommand(EditSel);
                
                if(rsEdit.next()){                
                    EditBrandName=rsEdit.getString("brand_name");
                    EditBrandid=rsEdit.getString("brand_id");                
                }
            
            }
        %>
        
        <form method="POST">
            <table>
                <tr>
                    <td>Brand</td>
                    <td>
                        <input type="text" name="txt_brand" value="<%= EditBrandName %>" required="required"/>
                        <input type="hidden" name="txt_brandid" value="<%= EditBrandid %>"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="submit" name="btn_submit" value="Submit"/></td>
                </tr>
            </table>
        </form>
        
        <table border="1">
            <tr>
               
                <td>Brand Name</td>
                <td colspan="2">Action</td>
            </tr>
            
            <%
                String sel = "select * from tbl_brand";
                ResultSet rs = con.selectCommand(sel);
                while(rs.next()){
            %>
        
            <tr>
                
                <td><%=rs.getString("brand_name")%></td>
                <td><a href="BrandManagement.jsp?edid=<%=rs.getString("brand_id")%>">Edit</a></td>
                <td><a href="BrandManagement.jsp?delid=<%=rs.getString("brand_id")%>">Delete</a></td>
            </tr>
            
            <%
                }
            %>
        </table>
    
    </body>
</html>
