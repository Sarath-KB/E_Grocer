<%-- 
    Document   : NeedHelp
    Created on : May 7, 2021, 1:21:00 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Need Help - To Admin</title>
    </head>
    <body>
        
        <%
            if(request.getParameter("btn_send")!=null){
                String ins = "insert into tbl_msgadmin (ma_content,ma_senderid,ma_senddesg) "
                           + "values('"+request.getParameter("toadmin")+"','"+session.getAttribute("userid")+"',2)";
                if(con.executeCommand(ins)){
                    out.println("<script>alert('Your complaint is send to the Admin')</script>");
                    response.sendRedirect("HomePage.jsp");
                }
                else{
                    out.println("<script>alert('Sending failed')</script>");
                }
            }
        %>       
        
        <h1> </h1>
        <table border="2" align="center">
            <form method="POST" align="center">
                <tr>
                    <td colspan="3">To Admin,</td>
                </tr>
                <tr>
                    <td colspan="3"><textarea name="toadmin"></textarea></td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <input type="submit" name="btn_send" value="Send"/>
                        <input type="reset" name="btn_clr" value="Clear"/>
                    </td>
                </tr>
            </form>
        </table>
    </body>
</html>
