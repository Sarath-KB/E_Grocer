<%-- 
    Document   : SearchShop
    Created on : Apr 26, 2021, 1:13:15 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Shop</title>
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
        
        <h1> </h1>
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <form method="POST">
                <tr>
                    <td>District</td>
                    <td><select name="sel_district" onchange="getplace(this.value)" >
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
                    <td>Place</td>
                    <td><select name="sel_place" id="sel_place" required="required">
                            <option>---Select---</option>
                        </select> 
                    </td>
                    <td><input type="submit" name="btn_search" value="Search"/></td>
                </tr>                             
            </form>
        </table>
        <h1> </h1>
        <%
            if(request.getParameter("btn_search")==null){
                String sel4 = "select * from tbl_shop shp inner join tbl_place pl on shp.place_id = pl.place_id order by pl.place_name asc";
                ResultSet rs2 = con.selectCommand(sel4);              
                if(rs2.next()){
        %>
        
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <%
                    int i=0;
                    do{
                        i++;
            %>
            <tr>                
                <td colspan='2'align='center'><h1><%=rs2.getString("shop_name")%></h1></td>
                <td><img src="../Assets/Shop/<%=rs2.getString("shop_img")%>" width="80" height="80" alt="Shop Photo"></td>
                
            </tr>
            <tr>                
                <td>License No: <%=rs2.getString("shop_licsno")%> </td>
                <td>GSTN: <%=rs2.getString("shop_gstno")%></td>
                <td rowspan="2" align="center"><a href="../User/ViewShopProduct.jsp?shid=<%=rs2.getString("shop_id")%>">Visit</a></td>
            </tr>
            <tr>
                
                <td>Address: <%=rs2.getString("shop_address")%></td>
                <td>Location: <%=rs2.getString("place_name")%></td>
            </tr>
            <tr>
                <td>Email: <%=rs2.getString("shop_email")%> </td>
                <td>Contact: <%=rs2.getString("shop_contact")%></td>
                <td align="center"><a href="../User/BookMySlot.jsp?shid=<%=rs2.getString("shop_id")%>">Book My Slot</a></td>
            </tr>
            <%
                    }while(rs2.next());
            %>
        </table>
        <h1> </h1>
            <%
                    if(i>1){
            %>
        <center><%=i%> Records found</center>
            <%
                    }
                    else{
            %>
        <center><%=i%> Record found</center>
        <%
                    }
                }
            else{
        %>
        
        <center><h1>No record found..</h1></center>
        
        <%
                }
            }
            else{
                String sel = "select * from tbl_shop shp inner join tbl_place pl on shp.place_id = pl.place_id "
                          // + "inner join tbl_district d on pl.district_id = d.district_id where "
                           + "where (shp.place_id = '"+request.getParameter("sel_place")+"' and "
                           + "pl.district_id='"+request.getParameter("sel_district")+"') order by shp.shop_name asc";
                ResultSet rs = con.selectCommand(sel);              
                if(rs.next()){
        %>
        
        <table border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
            <%
                    int i=0;
                    do{
                        i++;
            %>
            <tr>                
                <td colspan='2'align='center'><h1><%=rs.getString("shop_name")%></h1></td>
                <td><img src="../Assets/Shop/<%=rs.getString("shop_img")%>" width="80" height="80" alt="Shop Photo"></td>
                
            </tr>
            <tr>                
                <td>License No: <%=rs.getString("shop_licsno")%> </td>
                <td>GSTN: <%=rs.getString("shop_gstno")%></td>
                <td rowspan="2" align="center"><a href="../User/ViewShopProduct.jsp?shid=<%=rs.getString("shop_id")%>">Visit</a></td>
            </tr>
            <tr>
                
                <td>Address: <%=rs.getString("shop_address")%></td>
                <td>Location: <%=rs.getString("place_name")%></td>
            </tr>
            <tr>
                <td>Email: <%=rs.getString("shop_email")%> </td>
                <td>Contact: <%=rs.getString("shop_contact")%></td>
                <td align="center"><a href="../User/BookMySlot.jsp?shid=<%=rs.getString("shop_id")%>">Book My Slot</a></td>
            </tr>
            <%
                    }while(rs.next());
            %>
        </table>
        <h1> </h1>
            <%
                    if(i>1){
            %>
        <center><%=i%> Records found</center>
            <%
                    }
                    else{
            %>
        <center><%=i%> Record found</center>
        <%
                    }
                }
            else{
        %>
        
        <center><h1>No record found..</h1></center>
        
        <%
                }
            }
        %>
        <a href="HomePage.jsp">HomePage</a>
    </body>
    
</html>