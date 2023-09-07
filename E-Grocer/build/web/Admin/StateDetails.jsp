<%-- 
    Document   : StateDetails
    Created on : Mar 17, 2021, 10:56:47 AM
    Author     : eldho
--%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

    String editName = "", editID = "";
    if (request.getParameter("editid") != null) {

        String selQry = "select * from tbl_state where state_id='" + request.getParameter("editid") + "'";
        ResultSet rs = con.selectCommand(selQry);
        if (rs.next()) {
            editName = rs.getString("state_name");
            editID = rs.getString("state_id");
           

        }
    }

    if (request.getParameter("delid") != null) {

        String delqry = "delete from tbl_state where state_id='" + request.getParameter("delid") + "'";
        if (con.executeCommand(delqry)) {
            out.println("<script>alert('deleted')</script>");
            response.sendRedirect("StateDetails.jsp");
        } else {
            out.println("<script>alert('failed')</script>");
        }
    }

    if (request.getParameter("save") != null) {
        editID=request.getParameter("txtID");
        if (request.getParameter("txtID") != "") {
            String up = "update  tbl_state set state_name='" + request.getParameter("state") + "' where state_id='" + editID + "'";
            if (con.executeCommand(up)) {
                out.println("<script>alert('updated')</script>");
                out.print(up);
                response.sendRedirect("StateDetails.jsp");
            } else {
                out.println("<script>alert('failed')</script>");
            }
        } else {
            String ins = "insert into tbl_state(state_name)values('" + request.getParameter("state") + "')";
            if (con.executeCommand(ins)) {
                out.println("<script>alert('inserted')</script>");
                response.sendRedirect("StateDetails.jsp");
            } else {
                out.println("<script>alert('failed')</script>");
            }
        }
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form>
            <label for="state"> state
                <input type="text" id="state" name="state" value="<%=editName%>">
                <input type="hidden" id="txtID" name="txtID" value="<%=editID%>">
                <br>
                <input type="submit" id="submit" name="save" value="submit">
                </form>



                <table border="1" >
                    <tr>
                        <td>SL.No</td>
                        <td>State</td>

                    </tr>

                    <%                int i = 0;
                        String sel = "select * from tbl_state";
                        ResultSet rs = con.selectCommand(sel);
                        while (rs.next()) {
                            i++;
                    %>
                    <tr>

                        <td><%=i%></td>
                        <td><%=rs.getString("state_name")%></td>
                        <td><a href="StateDetails.jsp?delid=<%=rs.getString("state_id")%>">Delete</a></td>
                        <td><a href="StateDetails.jsp?editid=<%=rs.getString("state_id")%>">Edit</a></td>



                    </tr>
                    <%

                        }

                    %>


                </table>
                </body>

                </html>
