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
        <title>Book Slot</title>
    </head>
    
    <body>
        
        <%
            if(request.getParameter("sid")!=null){
                
                String upd = "update tbl_slot set slot_status = 1, slot_user = '"+session.getAttribute("userid")+"' where slot_id = '"+request.getParameter("sid")+"' ";
                if(con.executeCommand(upd)){
                    out.println("<script>alert('Slot Booked')</script>");
                }else{
                    out.println("<script>alert('No Slot is Booked')</script>");
                }
                response.sendRedirect("SearchShop.jsp");
                
            }
            
        //    if(request.getParameter("shid")!=null){
                
                String sel1 = "select * from tbl_slotbundle tsb inner join tbl_slot ts on tsb.sb_id = ts.sb_id where shop_id = '"+request.getParameter("shid")+"' order by slot_date,slot_starttime";
                ResultSet rs = con.selectCommand(sel1);
                
                if(rs.next()){
                        
        %>
        
        <h1><center>Book My Slot</center></h1>
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
                
                <td bgcolor="lightgreen" align="center"><b><a href = "BookMySlot.jsp?sid=<%=rs.getString("slot_id")%>">Book Slot</a></b></td>
                
                <%
                                
                            }else{
                
                %>
                <td bgcolor="red" align="center"><b>Booked</b></td>
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
        
        <%
        //    }
        //    else{
        //        response.sendRedirect("SearchShop.jsp");
        //    }    
        %>
        
    </body>
    
</html>
