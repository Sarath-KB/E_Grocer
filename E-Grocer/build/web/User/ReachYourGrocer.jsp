<%-- 
    Document   : ReachYourGrocer
    Created on : May 29, 2021, 3:27:10 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reach Your Grocer</title>
    </head>
 
    <body>
        
        <%
            if(request.getParameter("btn_send")!=null){
                String sel = "select * from tbl_carthead where cart_id = '"+session.getAttribute("orderid")+"' ";
                ResultSet rs = con.selectCommand(sel);
                rs.next();
                String ins = "insert into tbl_msgshop (ms_content,user_id,shop_id,cart_id,ms_date,ms_time) "
                           + "values('"+request.getParameter("toshop")+"','"+rs.getString("user_id")+"','"+rs.getString("shop_id")+"','"+rs.getString("cart_id")+"', CURDATE(), CURTIME())";
                if(con.executeCommand(ins)){
        %>
        <script type="text/javascript">
            alert("Your complaint is send to the Admin");
            setTimeout(function(){window.location.href='HomePage.jsp'},40);
        </script>
        <%
                }
                else{
                    out.println("<script>alert('Sending failed')</script>");
                }
            }
        %> 
        
        <h1 align="center">Reach Your Grocer</h1>
        <h1> </h1>
        <table border="2" align="center">
            <form method="POST" align="center">
                <tr>
                    <td colspan="3">To Customer Manager,</td>
                </tr>
                <tr>
                    <td colspan="3"><textarea name="toshop"></textarea></td>
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
