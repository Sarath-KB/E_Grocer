<%-- 
    Document   : AjaxPlace.jsp
    Created on : Mar 19, 2021, 10:57:47 PM
    Author     : PSST
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>          

<option>---Select---</option>
 <%
                String sel3="select * from tbl_product where category_id='"+request.getParameter("product")+"' order by product_name";
                ResultSet rs3=con.selectCommand(sel3);
                while(rs3.next()) {
            %>
            
            <option value="<%=rs3.getString("product_id")%>"><%=rs3.getString("product_name")%></option>
            <%
                }
            %>
      