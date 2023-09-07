<%-- 
    Document   : ChangePassword
    Created on : Apr 5, 2021, 2:39:54 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
    </head>
    <body>
        
        <form method="POST">
            
            <%
                if(request.getParameter("btn_submit")!=null){
                    String sel = "select * from tbl_deliveryagent where da_id='"+session.getAttribute("userid")+"'"
                               + "and da_pwd='"+request.getParameter("txt_currentpwd")+"'";
                    ResultSet rs = con.selectCommand(sel);
                    if(rs.next()){
                        if(request.getParameter("txt_newpwd").equals(request.getParameter("txt_confpwd"))){
                            String upd = "update tbl_deliveryagent set da_pwd='"+request.getParameter("txt_newpwd")+"'" 
                                       + "where da_id='"+session.getAttribute("userid")+"'";
                            if(con.executeCommand(upd)){
                                out.println("<script>alert('Password Changed')</script>");
                            }
                            else{
                                out.println("<script>alert('No Change')</script>");
                            }
                        }
                        else{
                            out.println("<script>alert('New Password Mismatch')</script>");
                        }
                    }
                    else{
                        out.println("<script>alert('Wrong password')</script>");
                    }
                }
            %>
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
                
                <tr>
                    <td>Current Password:</td>
                    <td><input type="password" name="txt_currentpwd" value="" required="required"/></td>
                </tr>
                
                <tr>
                    <td>New Password:</td>
                    <td><input type="password" name="txt_newpwd" value="" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*?[!@#$%^&*+`~=?\|<>/]).{8,}" title ="Must contain at least one number and one uppercase and lowercase letter and one special character , and atleast 8 or more characters" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Confirm Password:</td>
                    <td><input type="password" name="txt_confpwd" value="" required="required"/></td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="btn_submit" value="Confirm"/>
                        <input type="reset"  value="Cancel"/>
                    </td>
                </tr>
            
            </table>
        
        </form>
        
    </body>
</html>