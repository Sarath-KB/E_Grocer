<%-- 
    Document   : ViewNewFeedbacks
    Created on : May 29, 2021, 9:43:44 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Feedbacks</title>
    </head>
    
    <body>
        <%
            if(request.getParameter("mid")!=null){
                String upd = "update tbl_msgshop set ms_read=1 where ms_id = '"+request.getParameter("mid")+"' ";
                con.executeCommand(upd);
            }
        %>
        <h1 align="center">Customer Feedback - New</h1>
        <%
            String sel = "select * from tbl_msgshop tms inner join tbl_user tur on tur.user_id = tms.user_id "
                       + "where tms.shop_id = '"+session.getAttribute("userid")+"' and ms_read=0 order by ms_date asc, ms_time asc ";
            ResultSet rs = con.selectCommand(sel);
            if(rs.next()){
        %>
        <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
            <thead>
                <th>Order ID</th>
                <th>Customer Name</th>
                <th>Contact No</th>
                <th>Content</th>
                <th>Status Change</th>
                <th>View Order</th>
            </thead>
            <tbody>
        <%
                do{
        %>
                <tr>
                    <td><%=rs.getString("cart_id")%></td>
                    <td><%=rs.getString("user_name")%></td>
                    <td><%=rs.getString("contact")%></td>
                    <td><%=rs.getString("ms_content")%></td>
                    <td><b align="center"><a href="ViewNewFeedbacks.jsp?mid=<%=rs.getString("ms_id")%>">Read</a></b></td>
                    <td><b align="center"><a href="ViewOrderDetail.jsp?oid=<%=rs.getString("cart_id")%>">View</a></b></td>
                </tr>
        <%
                }while(rs.next());
        %>
        <%
            }else{
                out.println("No new messages in the inbox");
            }
        %>
    </body>
    
</html>
