<%-- 
    Document   : Place
    Created on : Apr 5, 2021, 2:37:45 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Place Details</title>
    </head>
    <body>
        
        <%
            String EditPlaceName="",EditPlaceid="", EditDistrictid="";
            if (request.getParameter("btnsubmit") != null) {
                
                if(request.getParameter("txt_placeid")!=""){
                    
                    String upData="update tbl_place set "
                               + "place_name='"+request.getParameter("txtplace")+"',"
                               + "district_id='" + request.getParameter("sel_district") + "'"
                               + "where place_id='"+request.getParameter("txt_placeid")+"'";
                       
                                if(con.executeCommand(upData)){
//                                out.println("<script>alert('Updated')</script>");
                                    response.sendRedirect("Place.jsp");
                                }
                                else{
                                    out.println("<script>alert('Failed')</script>");
                                }

                }
                else{

                    String ins = "insert into tbl_place(place_name,district_id)values('" + request.getParameter("txtplace") + "','" + request.getParameter("sel_district") + "')";
                    if (con.executeCommand(ins)) {
                        out.println("<script>alert('inserted')</script>");
                        // response.sendRedirect("District.jsp");
                    } else {
                        out.println("<script>alert('failed')</script>");
                    }
                }
                
            }

            if (request.getParameter("delid") != null) {

                String delqry = "delete from tbl_place where place_id='" + request.getParameter("delid") + "'";
                if (con.executeCommand(delqry)) {
                    out.println("<script>alert('deleted')</script>");
                    response.sendRedirect("Place.jsp");
                } else {
                    out.println("<script>alert('failed')</script>");
                }
            }
            
            if(request.getParameter("edid")!=null){
            
            
                String EditSel="select * from tbl_place where place_id='"+request.getParameter("edid")+"'";
                ResultSet rsEdit=con.selectCommand(EditSel);
                
                if(rsEdit.next()){                
                    EditPlaceName=rsEdit.getString("place_name");
                    EditPlaceid=rsEdit.getString("place_id");
                    EditDistrictid=rsEdit.getString("district_id");                
                }
            
            }

        %>
        
        <form>
            
            <table>
                <tr>
                    <td>
                        District:
                    </td>
                    <td>
                        <select name="sel_district" required="required">
                            <option>---choose---</option>
                            <%
                                String sel = "select * from tbl_district";
                                ResultSet rs = con.selectCommand(sel);
                                while (rs.next()) {
                            %>
                            <option value="<%=rs.getString("district_id")%>"<%if(EditDistrictid.equals(rs.getString("district_id"))){%>selected<%}%>><%=rs.getString("district_name")%></option>
                            <%
                                }
                            %>
                        </select>
                        <input type="hidden" name="txt_districtid" value="<%= EditDistrictid %>"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        Place:
                    </td>
                    <td>
                        <input type="text" name="txtplace" value="<%= EditPlaceName %>" required="required"/>
                        <input type="hidden" name="txt_placeid" value="<%= EditPlaceid %>"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="Submit" name="btnsubmit"/>
                        <input type="reset" value="Reset"/>
                    </td>
                </tr>
            </table>
                        
            <table border="1" align="center" cellpadding="10">
            <tr>
                <td>Place Name</td>
                <td>District Name</td>
                <td colspan="2">Action</td>

            </tr>

            <%                
                String sel_place = "select * from tbl_place p inner join tbl_district d on p.district_id=d.district_id";
                ResultSet rs1 = con.selectCommand(sel_place);
                while (rs1.next()) {
            %>
            <tr>

                <td><%=rs1.getString("Place_name")%></td>
                <td><%=rs1.getString("district_name")%></td>
                <td><a href="Place.jsp?edid=<%=rs1.getString("place_id")%>">Edit</a></td>
                <td><a href="Place.jsp?delid=<%=rs1.getString("place_id")%>">Delete</a></td>
            </tr>
            <%
                }
            %>


        </table>
        </form>
    </body>
</html>
