<%-- 
    Document   : ComplaintReply.jsp
    Created on : May 10, 2021, 1:14:52 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Reply</title>
    </head>
    <body>
        
         <%
                       
            String name="";
            int id = 0, desg=0;
            id = (Integer.parseInt(request.getParameter("rid")))/10;
            desg = (Integer.parseInt(request.getParameter("rid")))%10;
            if(desg == 0){
                String selt = "select * from tbl_msgadmin ma inner join tbl_shop sp on ma.ma_senderid = sp.shop_id where ma.ma_id='"+id+"'";
                ResultSet rs1 = con.selectCommand(selt);
                if(rs1.next()){
                    name = rs1.getString("shop_name");
                }
            }else if(desg == 1){
                String selt = "select * from tbl_msgadmin ma inner join tbl_user us on ma.ma_senderid = us.user_id where ma.ma_id='"+id+"'";
                ResultSet rs1 = con.selectCommand(selt);
                if(rs1.next()){
                    name = rs1.getString("user_name");
                }
            }else{
                String selt = "select * from tbl_msgadmin ma inner join tbl_deliveryagent da on ma.ma_senderid = da.da_id where ma.ma_id='"+id+"'";
                ResultSet rs1 = con.selectCommand(selt);
                if(rs1.next()){
                    name = rs1.getString("da_name");
                }
            }
            
            if(request.getParameter("btn_send")!=null){
                String ins = "insert into tbl_replymsg (rm_content,ma_id) "
                           + "values('"+request.getParameter("txt_reply")+"','"+ id +"')";
                if(con.executeCommand(ins)){
                    //out.println("<script>alert('Your reply is send')</script>");
                    //response.sendRedirect("HomePage.jsp");%>
        <script type="text/javascript">
            alert("Your reply is send");
            setTimeout(function(){window.location.href='HomePage.jsp'},40);//40millisecend it go to next page
        </script>
        <%      
                }
                else{
                    out.println("<script>alert('Sending failed')</script>");
                }
            }
        %>       
        
        <h1> </h1>
        <table border="2" align="center">
            <form method="POST" align="center">
                <tr>
                    <td colspan="3">To <%=name%> ,</td>
                </tr>
                <tr>
                    <td colspan="3"><textarea name="txt_reply"></textarea></td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <input type="submit" name="btn_send" value="Send"/>
                        <input type="reset" name="btn_clr" value="Clear"/>
                    </td>
                </tr>
            </form>
        </table>
    </body>
</html>
