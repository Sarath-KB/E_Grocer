<%-- 
    Document   : ComplaintInbox
    Created on : May 7, 2021, 7:05:15 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Complaint Inbox</title>
    </head>
    <body>
        
        <%
            if(request.getParameter("acid")!=null){
                String up="update tbl_msgadmin set ma_read=1 where ma_id='"+request.getParameter("acid")+"'";
                con.executeCommand(up);
                response.sendRedirect("ComplaintInbox.jsp");
            }
            String sel = "select * from tbl_msgadmin where ma_read = 0 order by ma_id asc";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
        %>
        <table  border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <thead>
                <th>Identity</th>
                <th>Message</th>
                <th>Read</th>
            </thead>
            <tbody>
                <%
                    do{
                        int desg=0, id=0, pid=0, rdid=0;
                        String name="", contact="", email="", designation="", refid="";
                        desg = Integer.parseInt(rs.getString("ma_senddesg"));
                        id = Integer.parseInt(rs.getString("ma_id"));
                        if(desg == 0){
                            String selt = "select * from tbl_msgadmin ma inner join tbl_shop sp on ma.ma_senderid = sp.shop_id where ma.ma_id='"+id+"'";
                            ResultSet rs1 = con.selectCommand(selt);
                            if(rs1.next()){
                                name = rs1.getString("shop_name");
                                contact = rs1.getString("shop_contact");
                                email = rs1.getString("shop_email");
                                designation="Grocer";
                                refid="GrocerViewProfile.jsp";
                                pid = Integer.parseInt(rs1.getString("shop_id"));
                                rdid = (Integer.parseInt(rs.getString("ma_id")))*10;
                            }
                        }else if(desg == 1){
                            String selt = "select * from tbl_msgadmin ma inner join tbl_user us on ma.ma_senderid = us.user_id where ma.ma_id='"+id+"'";
                            ResultSet rs1 = con.selectCommand(selt);
                            if(rs1.next()){
                                name = rs1.getString("user_name");
                                contact = rs1.getString("contact");
                                email = rs1.getString("email");
                                designation = "Customer";
                                refid = "UserViewProfile.jsp";
                                pid = Integer.parseInt(rs1.getString("user_id"));
                                rdid = ((Integer.parseInt(rs.getString("ma_id")))*10)+1;
                            }
                        }else{
                            String selt = "select * from tbl_msgadmin ma inner join tbl_deliveryagent da on ma.ma_senderid = da.da_id where ma.ma_id='"+id+"'";
                            ResultSet rs1 = con.selectCommand(selt);
                            if(rs1.next()){
                                name = rs1.getString("da_name");
                                contact = rs1.getString("da_contact");
                                email = rs1.getString("da_email");
                                designation = "Delivery Agent";
                                refid = "DeliveryBoyViewProfile.jsp";
                                pid = Integer.parseInt(rs1.getString("da_id"));
                                rdid = ((Integer.parseInt(rs.getString("ma_id")))*10)+2;
                            }
                        }                        
                %>
                <tr>
                    <td><%=name%></td>
                    <td rowspan="5"><%=rs.getString("ma_content")%></td>
                    <td rowspan="5"><a href="ComplaintInbox.jsp?acid=<%=rs.getString("ma_id")%>">Yes</a></td>
                </tr>
                <tr>
                    <td>Message ID: <%=id%></td>
                </tr>
                <tr>
                    <td><%=designation%></td>
                </tr>
                <tr>
                    <td><%=email%></td>
                </tr>
                <tr>
                    <td><%=contact%></td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <a href="<%=refid%>?fwdid=<%=pid%>">Visit Profile</a>
                        <a href="ComplaintReply.jsp?rid=<%=rdid%>">Reply</a>
                    </td>
                </tr>
                <%
                    }while(rs.next());
                %>
            </tbody>
        </table>
        <%
            }else{
        %>
        <h1><center>Empty Inbox</center> </h1>
        <%
            }
        %>
    </body>
</html>
