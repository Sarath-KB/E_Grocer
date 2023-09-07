<%-- 
    Document   : EditProfile
    Created on : Apr 5, 2021, 2:39:42 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
        
    </head>
    
    <body>
        
        <%
            if(request.getParameter("btn_submit")!=null){
                String upd = "update tbl_shop set shop_email = '" + request.getParameter("txt_email") + "',"
                           + "shop_contact = '" + request.getParameter("txt_contact") + "'"
                           + "where shop_id = '"+session.getAttribute("userid")+"'";
                if(con.executeCommand(upd)){
                    out.println("<script>alert('Profile Updated')</script>");
                }
                else{
                    out.println("<script>alert('No changes')</script>");
                }
            }
            String sel = "select * from tbl_shop shp inner join tbl_place pl on shp.place_id=pl.place_id"
                       + " inner join tbl_district dis on pl.district_id=dis.district_id"
                       + " where shop_id='"+session.getAttribute("userid")+"'";
            ResultSet rs = con.selectCommand(sel);
            while (rs.next()){
        %>
        
        <form method="POST">
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">                
                
                <tr>
                    <td>Email:</td>
                    <td><input type="email"  name="txt_email" value="<%=rs.getString("shop_email")%>" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Contact:</td>
                    <td><input type="text"  name="txt_contact" value="<%=rs.getString("shop_contact")%>" required="required"/></td>
                </tr>
                                                
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="btn_submit" value="Confirm"/>
                        <input type="reset"  value="Cancel"/>
                    </td>
                </tr>
                
            </table>
            
        </form>
                
        <%
            }
        %>
        
    </body>
    
</html>