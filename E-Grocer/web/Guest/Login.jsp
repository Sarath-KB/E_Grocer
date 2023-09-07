<%-- 
    Document   : Login
    Created on : Apr 5, 2021, 2:35:29 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        
        <%
            if(request.getParameter("btn_submit")!=null){
                String qry ="select * from tbl_user where (email='"+request.getParameter("txt_loginid")+"'"
                           +" or contact='"+request.getParameter("txt_loginid")+"')"
                           +" and password='"+request.getParameter("txt_pwd")+"'";
                String sqry="select * from tbl_shop where (shop_email='"+request.getParameter("txt_loginid")+"'"
                           +" or shop_contact='"+request.getParameter("txt_loginid")+"')"
                           +" and shop_pwd='"+request.getParameter("txt_pwd")+"' and shop_status=1";
                String qry1="select * from tbl_deliveryagent where (da_email='"+request.getParameter("txt_loginid")+"'"
                           +" or da_contact='"+request.getParameter("txt_loginid")+"')"
                           +" and da_pwd='"+request.getParameter("txt_pwd")+"' and da_status=1";
                ResultSet rs =con.selectCommand(qry);
                ResultSet rs1=con.selectCommand(sqry);
                ResultSet rs2=con.selectCommand(qry1);
                if(rs.next()){
                    session.setAttribute("username",rs.getString("user_name"));
                    session.setAttribute("userid",rs.getString("user_id"));
                    
                    response.sendRedirect("../User/HomePage.jsp");
                   
                }
                else if(rs1.next()){
                    
                    session.setAttribute("username",rs1.getString("shop_name"));
                    session.setAttribute("userid",rs1.getString("shop_id"));
                    
                    response.sendRedirect("../Grocer/HomePage.jsp");
                }
                else if(rs2.next()){
                    
                    session.setAttribute("username",rs2.getString("da_name"));
                    session.setAttribute("userid",rs2.getString("da_id"));
                    
                    response.sendRedirect("../DeliveryBoy/HomePage.jsp");
                }
                else{
                    out.println("<script>alert('Login Failed')</script>");
                }
            }
        %>
        
        <center><h3>Login</h3></center>
        
        <table border="2" align="center">
            <form method="POST">
                <tr>
                    <td>Login ID: </td>
                    <td><input type="text" name="txt_loginid" required="required"/></td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td><input type="password" name="txt_pwd" required="required"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="btn_submit" value="Login"/>
                        <input type="reset" name="btn_reset" value="Reset"/>
                    </td>
                </tr>
            </form>
        </table>
        
        <h1> </h1>
        
        <center>
            Register as:
            <a href="NewUser.jsp">Customer</a>
            <a href="NewShop.jsp">Grocer</a>
            <a href="NewDeliveryAgency.jsp">Delivery Agent</a>
        </center>
        
    </body>
</html>
