<%-- 
    Document   : MyProfile
    Created on : Apr 5, 2021, 2:39:30 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Profile</title>
    </head>
    <body>
        
        <%            
            String qry ="select * from tbl_shop shp inner join tbl_place pl on shp.place_id=pl.place_id"
                       +" inner join tbl_district dis on pl.district_id=dis.district_id"
                       +" where shop_id='"+session.getAttribute("userid")+"'";
            ResultSet rs =con.selectCommand(qry);
            if(rs.next()){
        %>
        
        <form method="POST">
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;" >
                
                <tr>
                    <td><h1><%=rs.getString("shop_name") %></h1></td>
                    <td><img src="../Assets/Shop/<%=rs.getString("shop_img") %>" width="80" height="80" alt="Shop Photo"></td>  
                </tr>
                
                <tr>
                    <td>Owner Name:</td>
                    <td><%=rs.getString("shop_owner") %></td>
                </tr>
                
                <tr>
                    <td>License No:</td>
                    <td><%=rs.getString("shop_licsno") %></td>
                </tr>
                
                <tr>
                    <td>GST No:</td>
                    <td><%=rs.getString("shop_gstno") %></td>
                </tr>
                
                <tr>
                    <td>Email:</td>
                    <td><%=rs.getString("shop_email") %></td>
                </tr>
                
                <tr>
                    <td>Contact:</td>
                    <td><%=rs.getString("shop_contact") %></td>
                </tr>
                
                <tr>
                    <td>Address:</td>
                    <td><%=rs.getString("shop_address") %></td>
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
                    <td><%=rs.getString("shop_pincode") %></td>
                </tr>
                
                <tr>
                    <td>Shop Proof:</td>
                    <td><img src="../Assets/Shop/<%=rs.getString("shop_proof") %>" width="80" height="80" alt="Shop Proof"></td>
                </tr>
                
                <tr>
                    <td>Owner ID Proof:</td>
                    <td><img src="../Assets/Shop/<%=rs.getString("idproof") %>" width="80" height="80" alt="Owner ID Proof"></td>
                </tr>
                
            </table>
            <%
                }
            %>
        </form>
    </body>
</html>
