<%-- 
    Document   : Category
    Created on : Apr 13, 2021, 3:52:40 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category</title>
    </head>
    <body>
        
        <%
            String EditCategoryName="",EditCategoryid="";
            
            if(request.getParameter("btn_submit")!=null){
//                    out.print("Id"+request.getParameter("txt_categoryid"));
                    if(request.getParameter("txt_categoryid")!=""){
                    
                    
                       String upData="update tbl_category set "
                               + "category_name='"+request.getParameter("txt_category")+"' "
                               + "where category_id='"+request.getParameter("txt_categoryid")+"'";
                       
                                if(con.executeCommand(upData)){
//                                out.println("<script>alert('Updated')</script>");
                                    response.sendRedirect("Category.jsp");
                                }
                                else{
                                out.println("<script>alert('Failed')</script>");
                                }
                    
                    
                    
                    }
                    else{
                        String ins = "insert into tbl_category(category_name)values('" + request.getParameter("txt_category") + "')";
                        if(con.executeCommand(ins)){
//                                out.println("<script>alert('Inserted')</script>");
                                response.sendRedirect("Category.jsp");
                        }
                        else{
                                out.println("<script>alert('Failed')</script>");
                        }
                    }
            }
            
            if(request.getParameter("delid")!=null){
                String delqry = "delete from tbl_category where category_id='" + request.getParameter("delid") + "'";
                if(con.executeCommand(delqry)){
//                    out.println("<script>alert('Deleted')</script>");
                   response.sendRedirect("Category.jsp");
                }
                else{
                    out.println("<script>alert('Failed')</script>");
                }
            }
            
            
            
            if(request.getParameter("edid")!=null){
            
            
                String EditSel="select * from tbl_category where category_id='"+request.getParameter("edid")+"'";
                ResultSet rsEdit=con.selectCommand(EditSel);
                
                if(rsEdit.next()){                
                    EditCategoryName=rsEdit.getString("category_name");
                    EditCategoryid=rsEdit.getString("category_id");                
                }
            
            }
        %>
        
        <form method="POST">
            <table>
                <tr>
                    <td>Category</td>
                    <td>
                        <input type="text" name="txt_category" value="<%= EditCategoryName %>" required="required"/>
                        <input type="hidden" name="txt_categoryid" value="<%= EditCategoryid %>"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="submit" name="btn_submit" value="Submit"/></td>
                </tr>
            </table>
        </form>
        
        <table border="1">
            <tr>
               
                <td>Category Name</td>
                <td colspan="2">Action</td>
            </tr>
            
            <%
                String sel = "select * from tbl_category";
                ResultSet rs = con.selectCommand(sel);
                while(rs.next()){
            %>
        
            <tr>
                
                <td><%=rs.getString("category_name")%></td>
                <td><a href="Category.jsp?edid=<%=rs.getString("category_id")%>">Edit</a></td>
                <td><a href="Category.jsp?delid=<%=rs.getString("category_id")%>">Delete</a></td>
            </tr>
            
            <%
                }
            %>
        </table>
    
    </body>
</html>
