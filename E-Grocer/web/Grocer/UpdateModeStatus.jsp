<%-- 
    Document   : UpdateModeStatus
    Created on : May 29, 2021, 11:03:53 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update On-Counter Status</title>
    </head>
    
    <body>
        <%
            if(request.getParameter("ctid")!=null){
                String upd = "update tbl_carthead set cart_delvstat = 2 where cart_id = '"+request.getParameter("ctid")+"' ";
                if(con.executeCommand(upd)){
        %>
        <script type="text/javascript">
            alert("Status updated");
            setTimeout(function(){window.location.href='UpdateModeStatus.jsp'},40);
        </script>
        <%
                }else{
        %>
        <script type="text/javascript">
            alert("No status updates were made");
            setTimeout(function(){window.location.href='UpdateModeStatus.jsp'},40);
        </script>
        <%
                }
            }
        %>
        <h1 align="center">Update On-Counter Status</h1>
        <h1> </h1>
        <form method="POST">
            <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
                <tr>
                    <td><input type="text" name="txt_keyword" placeholder="Enter the order id" required="required"/></td>
                    <td><input type="submit" name="btn_search" value="Search"></td>
                </tr>
            </table>
        </form>
        <h1> </h1>
        <%
            if(request.getParameter("btn_search")!=null){
                String sel_qry = "select * from tbl_carthead tch inner join tbl_user tur on tch.user_id = tur.user_id where tch.cart_delvstat = 1 and "
                               + "tch.shop_id = '"+session.getAttribute("userid")+"' and tch.cart_delvmod = 1 and tch.cart_id = '"+request.getParameter("txt_keyword")+"' ";
                ResultSet rsq = con.selectCommand(sel_qry);
                if(rsq.next()){
        %>
                    <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
        <%
                    do{
        %>
                        <tr>
                            <td colspan="2">Order Id: <b><%=rsq.getString("cart_id")%></b></td>
                            <td rowspan="4"><b align="center"><a href="UpdateModeStatus.jsp?ctid=<%=rsq.getString("cart_id")%>">Received</a></b></td>
                        </tr>
                        <tr>
                            <td colspan="2">Customer Name: <b><%=rsq.getString("user_name")%></b></td>
                        </tr>
                        <tr>
                            <td>Phone: <b><%=rsq.getString("contact")%></b></td>
                            <td>Email ID: <b><%=rsq.getString("email")%></b></td>
                        </tr>
                        <tr>
                            <td>Date ordered: <b><%=rsq.getString("cart_date")%></b></td>
                            <td>Expected Time: <b><%=rsq.getString("cart_time")%></b></td>
                        </tr>
        <%
                    }while(rsq.next());
        %>
                    </table>
        <%
                }else{
        %>
        <script type="text/javascript">
            alert("No orders found");
            setTimeout(function(){window.location.href='UpdateModeStatus.jsp'},40);
        </script>
        <%
                }
            }else{
                String sel = "select * from tbl_carthead tch inner join tbl_user tur on tur.user_id = tch.user_id where tch.cart_delvstat = 1 and "
                           + "tch.shop_id = '"+session.getAttribute("userid")+"' and tch.cart_delvmod = 1 order by tch.cart_date desc, tch.cart_time asc";
                ResultSet rs = con.selectCommand(sel);
                if(rs.next()){
        %>
                    <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
        <%
                    do{
        %>
                        <tr>
                            <td colspan="2">Order Id: <b><%=rs.getString("cart_id")%></b></td>
                            <td rowspan="4"><b align="center"><a href="UpdateModeStatus.jsp?ctid=<%=rs.getString("cart_id")%>">Received</a></b></td>
                        </tr>
                        <tr>
                            <td colspan="2">Customer Name: <b><%=rs.getString("user_name")%></b></td>
                        </tr>
                        <tr>
                            <td>Phone: <b><%=rs.getString("contact")%></b></td>
                            <td>Email ID: <b><%=rs.getString("email")%></b></td>
                        </tr>
                        <tr>
                            <td>Date ordered: <b><%=rs.getString("cart_date")%></b></td>
                            <td>Expected Time: <b><%=rs.getString("cart_time")%></b></td>
                        </tr>
        <%
                    }while(rs.next());
        %>
                    </table>
        <%            
                }else{
        %>
        <h1>No new orders</h1>
        <%
                }
            }
        %>
    </body>
    
</html>
