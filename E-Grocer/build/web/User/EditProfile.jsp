<%-- 
    Document   : EditProfile
    Created on : Apr 19, 2021, 2:48:35 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
        <script src=" ../JQuery/jQuery.js" type="text/javascript"></script>
        
         
            <script>
            function getplace(did)
            {
	//        alert(a);
                $.ajax({url:"../AjaxPages/AjaxPlace.jsp?district="+did,
                success: function(result){
        //        alert(result);
                $("#sel_place").html(result);}});
            }
            </script>
    </head>
    <body>
        
        <%
            if(request.getParameter("btn_submit")!=null){
                String upd = "update tbl_user set user_name = '" + request.getParameter("txt_name") + "',"
                           + "email = '" + request.getParameter("txt_email") + "',"
                           + "contact = '" + request.getParameter("txt_contact") + "',"
                           + "address = '" + request.getParameter("txt_address") + "',"
                           + "place_id = '" + request.getParameter("sel_place") + "',"
                           + "pincode = '" + request.getParameter("txt_pincode") + "' "
                           + "where user_id = '"+session.getAttribute("userid")+"'";
                if(con.executeCommand(upd)){
                    out.println("<script>alert('Profile Updated')</script>");
                }
                else{
                    out.println("<script>alert('No changes')</script>");
                }
            }
            String sel = "select * from tbl_user usr inner join tbl_place pl on usr.place_id=pl.place_id"
                       + " inner join tbl_district dis on pl.district_id=dis.district_id"
                       + " where user_id='"+session.getAttribute("userid")+"'";
            ResultSet rs = con.selectCommand(sel);
            while (rs.next()){
        %>
        
        <form method="POST">
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;">
                
                <tr>
                    <td>Name:</td>
                    <td><input type="text"  name="txt_name" value="<%=rs.getString("user_name")%>" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Email:</td>
                    <td><input type="email"  name="txt_email" value="<%=rs.getString("email")%>" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Contact:</td>
                    <td><input type="text"  name="txt_contact" value="<%=rs.getString("contact")%>" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Address:</td>
                    <td><input type="text"  name="txt_address" value="<%=rs.getString("address")%>" required="required"/></td>
                </tr>
                
                <tr>
                    <td>District:</td>
                    <td>
                        <select name="sel_district" onchange="getplace(this.value)">
                            <%
                                String sel_d = "select * from tbl_district";
                                ResultSet rs_d = con.selectCommand(sel_d);
                                while (rs_d.next()) {
                            %>
                            <option value="<%=rs_d.getString("district_id")%>"<%if(rs.getString("district_id").equals(rs_d.getString("district_id"))){%>selected<%}%>><%=rs_d.getString("district_name")%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Place:</td>
                    <td>
                        <select name="sel_place" id="sel_place" required="required">
                            
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Pincode:</td>
                    <td><input type="text"  name="txt_pincode" value="<%=rs.getString("pincode")%>" required="required"/></td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="btn_submit" value="Confirm"/>
                        <input type="reset"  value="Cancel"/>
                    </td>
                </tr>
                
            </table>
            
        </form>
                
        <%
            }
        %>
        
    </body>
</html>
