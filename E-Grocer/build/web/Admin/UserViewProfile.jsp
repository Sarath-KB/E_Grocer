<%-- 
    Document   : ViewProfile
    Created on : May 9, 2021, 1:19:25 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Profile</title>
    </head>
    <body>
        
        <%            
            String qry ="select * from tbl_user usr inner join tbl_place pl on usr.place_id=pl.place_id"
                       +" inner join tbl_district dis on pl.district_id=dis.district_id"
                       +" where user_id='"+request.getParameter("fwdid")+"'";
            ResultSet rs =con.selectCommand(qry);
            if(rs.next()){
        %>
        
        <form method="POST">
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;" >
                
                <tr>
                    <td>Name:</td>
                    <td><%=rs.getString("user_name") %></td>
                </tr>
                
                <tr>
                    <td>Email:</td>
                    <td><%=rs.getString("email") %></td>
                </tr>
                
                <tr>
                    <td>Contact:</td>
                    <td><%=rs.getString("contact") %></td>
                </tr>
                
                <tr>
                    <td>Address:</td>
                    <td><%=rs.getString("address") %></td>
                </tr>
                
                <tr>
                    <td>Place:</td>
                    <td><%=rs.getString("place_name") %></td>
                </tr>
                
                <tr>
                    <td>District:</td>
                    <td><%=rs.getString("district_name") %></td>
                </tr>
                
                <tr>
                    <td>Pincode:</td>
                    <td><%=rs.getString("pincode") %></td>
                </tr>
                
            </table>
            <%
                }
            %>
        </form>
    </body>
</html>