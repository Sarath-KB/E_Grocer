<%--
    Document   : District
    Created on : Apr 5, 2021, 2:37:34 PM
    Author     : HP
--%>



<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>District Details</title>
    </head>
    <body>


        <%

            String EditDistrictName="",EditDistrictid="";
            if (request.getParameter("btnsubmit") != null) {
                
                if(request.getParameter("txt_districtid")!=""){
                    
                    String upData="update tbl_district set "
                               + "district_name='"+request.getParameter("txtname")+"' "
                               + "where district_id='"+request.getParameter("txt_districtid")+"'";
                       
                                if(con.executeCommand(upData)){
//                                out.println("<script>alert('Updated')</script>");
                                    response.sendRedirect("District.jsp");
                                }
                                else{
                                    out.println("<script>alert('Failed')</script>");
                                }

                }
                else{

                    String ins = "insert into tbl_district(district_name)values('" + request.getParameter("txtname") + "')";
                    out.print(ins);
                    
                    if (con.executeCommand(ins)) {
                        out.println("<script>alert('inserted')</script>");
                        // response.sendRedirect("District.jsp");
                    } else {
                        out.println("<script>alert('failed')</script>");
                    }
                    
                }
             
            }

            if (request.getParameter("delid") != null) {

                String delqry = "delete from tbl_district where district_id='" + request.getParameter("delid") + "'";
                if (con.executeCommand(delqry)) {
                    out.println("<script>alert('deleted')</script>");
                    response.sendRedirect("District.jsp");
                } else {
                    out.println("<script>alert('failed')</script>");
                }
            }

            if(request.getParameter("edid")!=null){
            
            
                String EditSel="select * from tbl_district where district_id='"+request.getParameter("edid")+"'";
                ResultSet rsEdit=con.selectCommand(EditSel);
                
                if(rsEdit.next()){                
                    EditDistrictName=rsEdit.getString("district_name");
                    EditDistrictid=rsEdit.getString("district_id");                
                }
            
            }

        %>
        <form>
            <table>
                <tr>
                    <td>
                        District :
                    </td>
                    <td>

                        <input type="text" name="txtname" value="<%= EditDistrictName %>" required="required">
                        <input type="hidden" name="txt_districtid" value="<%= EditDistrictid %>"/>

                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="btnsubmit" value="Submit" >
                    </td>
                </tr>
            </table>
        </form>



        <table border="1" >
            <tr>
                <td>SL.No</td>
                <td>DistrictName</td>
                <td colspan="2">Action</td>

            </tr>

            <%                int i = 0;
                String sel = "select * from tbl_district";
                ResultSet rs = con.selectCommand(sel);
                while (rs.next()) {
                    i++;
            %>
            <tr>

                <td><%=i%></td>
                <td><%=rs.getString("district_name")%></td>
                <td><a href="District.jsp?edid=<%=rs.getString("district_id")%>">Edit</a></td>
                <td><a href="District.jsp?delid=<%=rs.getString("district_id")%>">Delete</a></td>

            </tr>
            <%

                }

            %>


        </table>


    </body>
</html>