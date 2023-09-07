<%-- 
    Document   : NewUser
    Created on : Apr 5, 2021, 2:35:41 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
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
            if (request.getParameter("btn_submit") != null){
                String sel1 = "select * from tbl_user where email = '" + request.getParameter("txt_email") + "'";
                String sel2 = "select * from tbl_user where contact = '" + request.getParameter("txt_contact") + "'";
                String sel3 = "select * from tbl_shop where shop_email = '" + request.getParameter("txt_email") + "'";
                String sel4 = "select * from tbl_shop where shop_contact = '" + request.getParameter("txt_contact") + "'";
                String sel5 = "select * from tbl_deliveryagent where da_email = '" + request.getParameter("txt_email") + "'";
                String sel6 = "select * from tbl_deliveryagent where da_contact = '" + request.getParameter("txt_contact") + "'";
                ResultSet rs1 = con.selectCommand(sel1);
                ResultSet rs2 = con.selectCommand(sel2);
                ResultSet rs3 = con.selectCommand(sel3);
                ResultSet rs4 = con.selectCommand(sel4);
                ResultSet rs5 = con.selectCommand(sel5);
                ResultSet rs6 = con.selectCommand(sel6);
                if(rs1.next() || rs3.next() || rs5.next()){
                    out.println("<script>alert('Email ID given is already in use')</script>");
                }
                else if(rs2.next() || rs4.next() || rs6.next()){
                    out.println("<script>alert('Mobile No. given is already in use')</script>");
                }
                else{
                if(request.getParameter("txt_password").equals(request.getParameter("txt_confpassword"))){
                    String ins = "insert into tbl_user(user_name,email,password,contact,address,place_id,pincode)"
                               + "values('" + request.getParameter("txt_username") + "',"
                               + "'" + request.getParameter("txt_email") + "',"
                               + "'" + request.getParameter("txt_password") + "',"
                               + "'" + request.getParameter("txt_contact") + "',"
                               + "'" + request.getParameter("txt_address") + "',"
                               + "'" + request.getParameter("sel_place") + "',"
                               + "'" + request.getParameter("txt_pincode") + "')";
                    if (con.executeCommand(ins)) {
                        out.println("<script>alert('inserted')</script>");
                        // response.sendRedirect("District.jsp");
                    }
                    else {
                        out.println("<script>alert('failed')</script>");
                    }
                }
                else{
                    out.println("<script>alert('Password mismatch')</script>");
                }
                }
            }
        %>
        
        <center><h1>New User Registration</h1></center>
        <form method="POST">
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;" >
                
                <tr>
                    <td>Name:</td>
                    <td><input type="text" name="txt_username" required="required"/></td>
                </tr>
                <tr>
                    <td>Address: </td>
                    <td><textarea name="txt_address" required="required"></textarea></td>
                </tr>
                <tr>
                    <td>District: </td>
                    <td>
                        <select name="sel_district" onchange="getplace(this.value)" >
                            <option>---Select---</option>
                            <%
                                String sel_d = "select * from tbl_district order by district_name ";
                                ResultSet rs_d = con.selectCommand(sel_d);
                                while (rs_d.next()) {
                            %>
                            <option value="<%=rs_d.getString("district_id")%>"><%=rs_d.getString("district_name")%></option>
                            <%
                                }
                            %>                           
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Place: </td>
                    <td>
                        <select name="sel_place" id="sel_place" required="required" >
                              <option>---Select---</option>           
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Pincode: </td>
                    <td><input type="text" name="txt_pincode" required="required"/></td>
                </tr>
                <tr>
                    <td>Contact No: </td>
                    <td><input type="text" name="txt_contact" required="required"/></td>
                </tr>
                <tr>
                    <td>Email ID: </td>
                    <td><input type="email" name="txt_email" required="required"/></td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td><input type="password" name="txt_password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*?[!@#$%^&*+`~=?\|<>/]).{8,}" title ="Must contain at least one number and one uppercase and lowercase letter and one special character , and atleast 8 or more characters" required="required"/></td>
                </tr>
                <tr>
                    <td>Confirm Password: </td>
                    <td><input type="password" name="txt_confpassword" required="required"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="btn_submit" value="Create Account"/>
                        <input type="reset" name="btn_reset" value="Reset"/>
                    </td>
                </tr>
                
            </table>

    </body>
</html>
