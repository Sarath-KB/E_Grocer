<%-- 
    Document   : ViewYourFeedback
    Created on : May 29, 2021, 6:40:06 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Feedbacks</title>
    </head>

    <body>
        <%
            String sel = "select * from tbl_msgshop where cart_id = '"+session.getAttribute("orderid")+"' order by ms_date desc, ms_time desc ";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
        %>
        <h1 align="center">My Feedback</h1>
        <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
            <thead>
                <th>Date</th>
                <th>Time</th>
                <th>Content</th>
            </thead>
            <tbody>
        <%
                do{
        %>
                <tr>
                    <td><%=rs.getString("ms_date")%></td>
                    <td><%=rs.getString("ms_time")%></td>
                    <td><%=rs.getString("ms_content")%></td>
                </tr>
        <%
                }while(rs.next());
        %>
            </tbody>
        </table>
        <a href ="OrderDetail.jsp?cid=<%=session.getAttribute("orderid")%>">Back</a>
        <%
            }
        %>
    </body>

</html>
