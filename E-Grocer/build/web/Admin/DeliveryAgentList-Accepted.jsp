<%-- 
    Document   : ShopList-Accepted
    Created on : Apr 5, 2021, 2:38:31 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<jsp:useBean class="DB.mailconnection" id="ma"></jsp:useBean>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Accepted Delivery Agents</title>
    </head>
    
    <body>
        
        <%
            if(request.getParameter("reid")!=null){
                String upd="update tbl_deliveryagent set da_status=2 where da_id='"+request.getParameter("reid")+"'";
                con.executeCommand(upd);
                String toAddress[]={request.getParameter("email")};
                    String subject="Registration Details From EDriver ";
                    String text=" Your registration Rejected";
                            boolean b=ma.sendMail(toAddress, subject, text);
                response.sendRedirect("DeliveryAgentList-Accepted.jsp");
            }
            
            String qry ="select * from tbl_deliveryagent da inner join tbl_place pl on da.place_id=pl.place_id "
                       +"inner join tbl_district dis on pl.district_id=dis.district_id "
                       +"where da_status=1";
            ResultSet rs =con.selectCommand(qry);
            if(rs.next()){
        %>
        
        <table border="1" style="border-collapse:collapse;">
            
            <thead>
                <th>Sl.No</th>
                <th>Candidate Name</th>
                <th>DOB</th>
                <th>Address</th>
                <th>Place</th>
                <th>District</th>
                <th>Pincode</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Candidate Photo</th>
                <th>Candidate Driving License</th>
                <th>Vehicle Proof</th>
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
                    <td><%=rs.getString("da_name")%></td>
                    <td><%=rs.getString("da_dob") %></td>
                    <td><%=rs.getString("da_address") %></td>
                    <td><%=rs.getString("place_name") %></td>
                    <td><%=rs.getString("district_name") %></td>
                    <td><%=rs.getString("da_pincode") %></td>
                    <td><%=rs.getString("da_email") %></td>
                    <td><%=rs.getString("da_contact") %></td>
                    <td><img src="../Assets/Delivery Agent/<%=rs.getString("da_photo") %>" width="80" height="80" alt="Candidate Photo"></td>
                    <td><img src="../Assets/Delivery Agent/<%=rs.getString("da_drivlic") %>" width="80" height="80" alt="Driving License"></td>
                    <td><img src="../Assets/Delivery Agent/<%=rs.getString("da_vehproof") %>" width="80" height="80" alt="Vehicle Proof"></td>
                    <td><a href="DeliveryAgentList-Accepted.jsp?reid=<%=rs.getString("da_id")%>&email=<%=rs.getString("da_email")%>">Remove</a></td>
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
