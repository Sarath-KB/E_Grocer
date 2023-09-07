<%-- 
    Document   : ViewAdminReply
    Created on : May 10, 2021, 5:05:01 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Admin Reply</title>
    </head>
    <body>
        <%
            if(request.getParameter("acid")!=null){
                String up="update tbl_replymsg set rm_status=1 where rm_id='"+request.getParameter("acid")+"'";
                con.executeCommand(up);
                response.sendRedirect("ViewAdminReply.jsp");
            }
            String sel = "select * from tbl_replymsg rm inner join tbl_msgadmin ma on rm.ma_id = ma.ma_id where ma.ma_senddesg = 2 and "
                       + "ma.ma_senderid = '"+session.getAttribute("userid")+"' order by rm.rm_status,rm.rm_id asc";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
        %>
        <h1> </h1>
        <table  border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <thead>
                <th>Message</th>
                <th>Status</th>
            </thead>
            <tbody>
        <%
                do{
        %>
                <tr>
                    <td><%=rs.getString("rm_content")%></td>
                    <td><%
                            int a = 0;
                            a = Integer.parseInt(rs.getString("rm_status"));
                            if(a==1){
                        %>
                            Seen
                        <%
                            }else{
                        %>
                            <a href="ViewAdminReply.jsp?acid=<%=rs.getString("rm_id")%>">Read</a>
                        <%
                            }
                        %>
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