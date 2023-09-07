<%-- 
    Document   : NewDeliveryAgency
    Created on : Apr 5, 2021, 2:42:28 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>New Delivery Agent</title>
        
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
        
        <center><h1>Delivery Agent Registration</h1></center>
        
        <form method="POST" enctype="multipart/form-data" action="DeliveryBoyUpload.jsp">
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;" >
                
               
                <tr>
                    <td>Candidate Name: </td>
                    <td><input type="text" name="txt_name" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Photo of Candidate: </td>
                    <td><input type="file" name="fl_photo" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Date of Birth: </td>
                    <td><input type="date" name="txt_dob" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Contact: </td>
                    <td><input type="text" name="txt_contact" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Email: </td>
                    <td><input type="email" name="txt_email" required="required"/></td>
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
                    <td>Driving License:  </td>
                    <td><input type="file" name="fl_drvlic" required="required"/></td>
                </tr>
                
                <tr>
                    <td>Vehicle Proof :  </td>
                    <td><input type="file" name="fl_vehproof" required="required"/></td>
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
                        <input type="submit" name="btn_submit" value="Register"/>
                        <input type="reset" name="btn_reset" value="Cancel"/>
                    </td>
                </tr>
                
            </table>
            
        </form>
        
    </body>
    
</html>