<%-- 
    Document   : BookMySlot
    Created on : May 19, 2021, 10:55:35 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View All Slots</title>
    </head>
    
    <body>
        
        <%
            if(request.getParameter("sid")!=null){
                
                String upd = "update tbl_slot set slot_status = 1 where slot_id = '"+request.getParameter("sid")+"' ";
                if(con.executeCommand(upd)){
                    out.println("<script>alert('Slot Blocked')</script>");
                }else{
                    out.println("<script>alert('No Slot is Blocked')</script>");
                }
                response.sendRedirect("ViewAllSlots.jsp");
                
            }
            
            if(request.getParameter("slid")!=null){
                
                String upd1 = "update tbl_slot set slot_status = 0 where slot_id = '"+request.getParameter("slid")+"' ";
                if(con.executeCommand(upd1)){
                    out.println("<script>alert('Slot is Unblocked')</script>");
                }else{
                    out.println("<script>alert('No Slot is Unblocked')</script>");
                }
                response.sendRedirect("ViewAllSlots.jsp");
                
            }
            
                String sel1 = "select * from tbl_slotbundle tsb inner join tbl_slot ts on tsb.sb_id = ts.sb_id where shop_id = '"+session.getAttribute("userid")+"' order by slot_date,slot_starttime";
                ResultSet rs = con.selectCommand(sel1);
                
                if(rs.next()){
                        
        %>
        
        <h1><center>View Slots</center></h1>
        <h1></h1>
        
        <table  border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            
        <%
                    
                    int len = Integer.parseInt(rs.getString("sb_totalslots"));
                    do{
                        
        %>
            <tr>
                <td colspan="<%=Integer.parseInt(rs.getString("sb_totalslots"))%>" bgcolor="yellow">
                    <b>Date: <%=rs.getString("slot_date")%>  Time Interval: <%=rs.getString("slot_starttime")%> - <%=rs.getString("slot_endtime")%></b>
                </td>
            </tr>
           
            <tr>
                <%
                
                        int i = 0;
                        do{
                            if(Integer.parseInt(rs.getString("slot_status"))==0){
                
                %> 
                
                <td bgcolor="lightgreen" align="center"><b><a href = "ViewAllSlots.jsp?sid=<%=rs.getString("slot_id")%>">Block Slot</a></b></td>
                
                <%
                                
                            }else if (Integer.parseInt(rs.getString("slot_status"))==1 && rs.getString("slot_user")!=null){
                
                %>
                
                <td bgcolor="red" align="center"><b><a href = "SlotDetail.jsp?sdid=<%=rs.getString("slot_id")%>">View Detail</a></b></td>
                
                <%
                                
                            }else{
                
                %>
                
                <td bgcolor="lightblue" align="center"><b><a href = "ViewAllSlots.jsp?slid=<%=rs.getString("slot_id")%>">Unblock</a></b></td>
                
        <%
                                
                            }
                        i++;
                        }while(i<len && rs.next());}while(rs.next());
                }else{
        
        %>
            <h1>No Slots Available</h1>
        <%
                    
                }
                
        %>
            </tr>
            
        </table>
        
    </body>
    
</html>
