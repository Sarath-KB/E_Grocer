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
        <title>Slot Detail</title>
    </head>
    
    <body>
        
        <h1><center>Slot Detail</center></h1>
        
        <%
            
            if(request.getParameter("sid")!=null){
                String upd = "update tbl_slot set slot_user = null, slot_status = 0 where slot_id = '"+request.getParameter("sid")+"' ";
                if(con.executeCommand(upd)){
                    out.println("<script>alert('Allocated slot removed')</script>");
                    response.sendRedirect("ViewAllSlots.jsp");
                }
                else{
                    out.println("<script>alert('Failed to remove allocated slot')</script>");
                }
            }
            
            String sel = "select * from tbl_slot ts inner join tbl_slotbundle tsb on ts.sb_id = tsb.sb_id inner join tbl_shop tsp on tsb.shop_id = tsp.shop_id "
                       + "inner join tbl_user us on us.user_id = ts.slot_user where slot_id = '"+request.getParameter("sdid")+"'";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
                 
        %>
        
        <h1> </h1>
        <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
            <tr>
                <td colspan="2">Customer Name: <%=rs.getString("user_name")%></td>
            </tr>
            <tr>
                <td>Email Id: <%=rs.getString("email")%> </td>
                <td>Phone No: <%=rs.getString("contact")%></td>
            </tr>
            <tr>
                <td colspan="2">Date: <%=rs.getString("slot_date")%></td>
            </tr>
            <tr>
                <td colspan="2">Time Interval: <%=rs.getString("slot_starttime")%> - <%=rs.getString("slot_endtime")%></td>
            </tr>
            <tr>
                <td colspan="2"><center><b><a href="SlotDetail.jsp?sid=<%=rs.getString("slot_id")%>">Remove booking</a></b></center></td>
            </tr>
        </table>
        
        <%
            
            }
            else{
            
        %>
        
        <h1> </h1>
        <h2><b>This slot is not booked</b></h2>
        
        <%
            
            }
            
        %>
        
    </body>
    
</html>
