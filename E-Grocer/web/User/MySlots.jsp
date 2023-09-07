<%-- 
    Document   : MySlots
    Created on : May 20, 2021, 3:00:50 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Slots</title>
    </head>
    
    <body>
        
        <h1><center>My Slots</center></h1>
        
        <%
            
            if(request.getParameter("sid")!=null){
                String upd = "update tbl_slot set slot_user = null, slot_status = 0 where slot_id = '"+request.getParameter("sid")+"' ";
                if(con.executeCommand(upd)){
                    out.println("<script>alert('Allocated slot removed')</script>");
                }
                else{
                    out.println("<script>alert('Failed to remove allocated slot')</script>");
                }
            }
            
            String sel = "select * from tbl_slot ts inner join tbl_slotbundle tsb on ts.sb_id = tsb.sb_id inner join tbl_shop tsp on tsb.shop_id = tsp.shop_id "
                       + "inner join tbl_user us on us.user_id = ts.slot_user inner join tbl_place pl on tsp.place_id = pl.place_id "
                       + "where user_id = '"+session.getAttribute("userid")+"' order by slot_date desc, slot_starttime asc  ";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
                do{
                    
        %>
        
        <h1> </h1>
        <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
            <tr>
                <td colspan="2"><h2><b><center><%=rs.getString("shop_name")%></center></b></h2></td>
            </tr>
            <tr>
                <td>Place: <%=rs.getString("place_name")%> </td>
                <td>Phone No: <%=rs.getString("shop_contact")%></td>
            </tr>
            <tr>
                <td colspan="2">Date: <%=rs.getString("slot_date")%></td>
            </tr>
            <tr>
                <td colspan="2">Time Interval: <%=rs.getString("slot_starttime")%> - <%=rs.getString("slot_endtime")%></td>
            </tr>
            <tr>
                <td colspan="2">Customer Name: <%=rs.getString("user_name")%></td>
            </tr>
            <tr>
                <td colspan="2"><center><b><a href="MySlots.jsp?sid=<%=rs.getString("slot_id")%>">Remove my booking</a></b></center></td>
            </tr>
        </table>
        
        <%
            
                }while(rs.next());
            }
            else{
            
        %>
        
        <h1> </h1>
        <h2><b>No slots have been booked for today</b></h2>
        
        <%
            
            }
            
        %>
        
    </body>
    
</html>
