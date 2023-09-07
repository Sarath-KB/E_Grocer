<%-- 
    Document   : SetSlotBundle
    Created on : Apr 26, 2021, 1:12:14 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Set Slot Bundle</title>
    </head>
    
    <body>
        
        <%
            if(request.getParameter("btn_submit")!=null){
                String ins = "insert into tbl_slotbundle(sb_starttime,sb_endtime,sb_lifetime,sb_totalslots,sb_fine,sb_break,sb_date,shop_id,sb_generateslot) "
                           + "values( '"+request.getParameter("txt_starttime")+"',"
                           + "'"+request.getParameter("txt_closetime")+"',"
                           + "'"+request.getParameter("txt_duration")+"',"
                           + "'"+request.getParameter("txt_totalslots")+"',"
                           + "'"+request.getParameter("txt_fine")+"',"
                           + "'"+request.getParameter("txt_break")+"',"
                           + "'"+request.getParameter("txt_date")+"',"
                           + "'"+session.getAttribute("userid")+"',0)";
                con.executeCommand(ins);
            }
           // if(request.getParameter("gen")!=null){
             //   String upd = "update tbl_slotbundle set sb_generateslot = 1 where sb_id = '" + request.getParameter("gen") + "'";
               // con.executeCommand(upd);
            //}
            if(request.getParameter("reid")!=null){
                String selt = "select * from tbl_slot where sb_id='" + request.getParameter("reid") + "'";
                ResultSet rs2 = con.selectCommand(selt);
                if(rs2.next()){
                    String delt1 = "delete from tbl_slot where sb_id='" + request.getParameter("reid") + "'";
                    con.executeCommand(delt1);
                }
                String delt = " delete from tbl_slotbundle where sb_id ='" + request.getParameter("reid") + "'";
                con.executeCommand(delt);                
            }
        %>
        
        <center><h1>Slot Management</h1></center>
        
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <form method="POST">
                
                <tr>
                    <td>Date:</td>
                    <td><input type="date" name="txt_date" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Start Time:</td>
                    <td><input type="time" name="txt_starttime" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Closing Time:</td>
                    <td><input type="time" name="txt_closetime" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Life Time:(mins)</td>
                    <td><input type="text" name="txt_duration" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Total Slots:</td>
                    <td><input type="text" name="txt_totalslots" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Fine:(Rs)</td>
                    <td><input type="text" name="txt_fine" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Break:(mins)</td>
                    <td><input type="text" name="txt_break" required="required"/></td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="Save" name="btn_submit"/>
                        <input type="reset" value="Reset" name="btn_reset"/>
                    </td>
                </tr>
                
            </form>        
        </table>
            
            <h1> </h1>
            
            <%
                String sel = "select * from tbl_slotbundle where shop_id = '"+session.getAttribute("userid")+"'";
                ResultSet rs1 = con.selectCommand(sel);
                if(rs1.next()){
            %>
            
        <table border="1" align="center" style="border-collapse:collapse;">
            
            <thead>
                <th>Date</th>
                <th>Start Time</th>
                <th>Closing Time</th>
                <th>Life Time (mins)</th>
                <th>Break (mins)</th>
                <th>Total Slots</th>
                <th>Fine (Rs)</th>
                <th>Action</th>
                <th>Status</th>
            </thead> 
                
            <tbody>
                <%
                    do{
                %>
                <tr>
                    <td><%=rs1.getString("sb_date")%></td>
                    <td><%=rs1.getString("sb_starttime")%></td>
                    <td><%=rs1.getString("sb_endtime")%></td>
                    <td><%=rs1.getString("sb_lifetime")%></td>
                    <td><%=rs1.getString("sb_break")%></td>
                    <td><%=rs1.getString("sb_totalslots")%></td>
                    <td><%=rs1.getString("sb_fine")%></td>
                    <td><%if(rs1.getString("sb_generateslot").equals("0")){%><a href="GenerateSlots.jsp?gen=<%=rs1.getString("sb_id")%>">Generate Slot</a><%}%> <a href="SetSlotBundle.jsp?reid=<%=rs1.getString("sb_id")%>">Delete</a></td>
                    <td><%if(rs1.getString("sb_generateslot").equals("0")){%>Slots not generated<%}else{%>Slots generated<%}%></td>                    
                </tr>
                <%
                    }while(rs1.next());
                %>
            </tbody>
            
        </table>
            
            <%
                }
                else{
            %>
        <center>No records found..</center>
            <%
                }
            %>
        
    </body>
    
</html>
