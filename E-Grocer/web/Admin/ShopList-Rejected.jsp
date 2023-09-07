<%-- 
    Document   : ShopList-Rejected
    Created on : Apr 5, 2021, 2:38:46 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rejected Shops</title>
    </head>
    
    <body>
        
        <%
            if(request.getParameter("acid")!=null){
                String up="update tbl_shop set shop_status=1 where shop_id='"+request.getParameter("acid")+"'";
                con.executeCommand(up);
                response.sendRedirect("ShopList-Rejected.jsp");
            }
            
            String qry ="select * from tbl_shop shp inner join tbl_place pl on shp.place_id=pl.place_id "
                       +"inner join tbl_district dis on pl.district_id=dis.district_id "
                       +"where shop_status=2";
            ResultSet rs =con.selectCommand(qry);
            if(rs.next()){
        %>
        
        <table border="1" style="border-collapse:collapse;">
            
            <thead>
                <th>Sl.No</th>
                <th>Grocery Name</th>
                <th>Owner Name</th>
                <th>License No.</th>
                <th>GST No.</th>
                <th>Address</th>
                <th>Place</th>
                <th>District</th>
                <th>Pincode</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Image of Shop</th>
                <th>Proof of Shop</th>
                <th>ID proof of Owner</th>
                <th>Action</th>
            </thead>
        
            <tbody>
            <%
                int i=0;
                do{
                    i++;
            %>
                <tr>
                    <td><%=i%></td>
                    <td><%=rs.getString("shop_name")%></td>
                    <td><%=rs.getString("shop_owner") %></td>
                    <td><%=rs.getString("shop_licsno") %></td>
                    <td><%=rs.getString("shop_gstno") %></td>
                    <td><%=rs.getString("shop_address") %></td>
                    <td><%=rs.getString("place_name") %></td>
                    <td><%=rs.getString("district_name") %></td>
                    <td><%=rs.getString("shop_pincode") %></td>
                    <td><%=rs.getString("shop_email") %></td>
                    <td><%=rs.getString("shop_contact") %></td>
                    <td><img src="../Assets/Shop/<%=rs.getString("shop_img") %>" width="80" height="80" alt="Shop Photo"></td>
                    <td><img src="../Assets/Shop/<%=rs.getString("shop_proof") %>" width="80" height="80" alt="Shop Proof"></td>
                    <td><img src="../Assets/Shop/<%=rs.getString("idproof") %>" width="80" height="80" alt="Owner ID Proof"></td>
                    <td><a href="ShopList-Rejected.jsp?acid=<%=rs.getString("shop_id")%>">Accept</a>
                </tr>
            <%
                }while(rs.next());
            %>
            </tbody>
        </table>
        
        <%
            }else{
        %>
        
        <h1>No records found..</h1>
        
        <%
            }
        %>
        
        
    </body>
    
</html>
