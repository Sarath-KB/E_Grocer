<%-- 
    Document   : ViewDeliveryAgent
    Created on : May 30, 2021, 1:31:35 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Delivery Agent</title>
    </head>
    
    <body>
        <%
            if(request.getParameter("daid")!=null){
                String sel = "select * from tbl_deliveryagent da inner join tbl_place pl on da.place_id = pl.place_id "
                           + "inner join tbl_district dis on pl.district_id = dis.district_id where da.da_id = '"+request.getParameter("daid")+"' ";
                ResultSet rs = con.selectCommand(sel);
                if(rs.next()){
        %>
        <h1 align="center">Delivery Agent Profile</h1>
        <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;" >
                
            <tr>
                <td><%=rs.getString("da_name") %></td>
                <td><img src="../Assets/Delivery Agent/<%=rs.getString("da_photo") %>" width="80" height="80" alt="Delivery Agent Photo"></td>  
            </tr>
                
            <tr>
                <td>DOB:</td>
                <td><%=rs.getString("da_dob") %></td>
            </tr>
                
            <tr>
                <td>Email:</td>
                <td><%=rs.getString("da_email") %></td>
            </tr>
                
            <tr>
                <td>Contact:</td>
                <td><%=rs.getString("da_contact") %></td>
            </tr>
                
            <tr>
                <td>Address:</td>
                <td><%=rs.getString("da_address") %></td>
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
                <td><%=rs.getString("da_pincode") %></td>
            </tr>
                
            <tr>
                <td>Driving License:</td>
                <td><img src="../Assets/Delivery Agent/<%=rs.getString("da_drivlic") %>" width="80" height="80" alt="Driving License Image"/></td>
            </tr>
                
            <tr>
                <td>Vehicle Proof:</td>
                <td><img src="../Assets/Delivery Agent/<%=rs.getString("da_vehproof") %>" width="80" height="80" alt="Driving License Image"/></td>
            </tr>
                
        </table>
        <%
                }else{
                    out.println("No records found on this delivery agent..");
                }
            }else{
                out.println("No records found on this delivery agent..");
            }
        %>
        <a href="HomePage.jsp">HomePage</a>
    </body>

</html>
