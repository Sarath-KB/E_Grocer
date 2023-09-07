<%-- 
    Document   : ModeSelection
    Created on : May 27, 2021, 3:57:29 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mode selection</title>
    </head>
    
    <body>
        
        <%
            // To perform update operation on clcicking proceed btn in this page
            if(request.getParameter("btn_proceed")!=null){
                String upd8 = "update tbl_carthead set cart_date=CURDATE(),cart_delvmod='"+request.getParameter("rb_mod")+"',"
                            + "cart_paymod='"+request.getParameter("rb_mop")+"',cart_time='"+request.getParameter("txt_tod")+"',"
                            + "cart_status=1 where cart_id='"+session.getAttribute("cartiid")+"'";                
                con.executeCommand(upd8);
                if(Integer.parseInt(request.getParameter("rb_mop"))==1){
        %>
                    <script type="text/javascript">
                        alert("Your order is successfully placed");
                        setTimeout(function(){window.location.href='SearchShop.jsp'},40);
                    </script>
        <%
                }
                else{
                    session.setAttribute("carttid",session.getAttribute("cartiid"));
                    response.sendRedirect("Payment.jsp");
                    //out.println("<script>alert('Your order is not successfully placed')</script>");
                
                // to payment page then after payment display msg order placed succesfully and redirects back to SearchShop.jsp incase any error encountered during online payment make 
                                                                    // it as cash on delivery and display msg stating cash on delivery and display mesaage as order placed successfully 
                }
            }
            
            // To cancel order
            if(request.getParameter("cartid")!=null && request.getParameter("cartid1")!=null){
                String sel0 = "select * from tbl_cartbody where cart_id = '"+request.getParameter("cartid")+"' and cart_itemstatus = 1";
                ResultSet rs0 = con.selectCommand(sel0);
                if(rs0.next()){
                    //out.println(rs0.getString("cart_itemstatus"));
                    do{
                        String sid = "";
                        int newQty = 0;
                        String sel01 = "Select * from tbl_masterstock where shopproduct_id = '"+rs0.getString("shopproduct_id")+"'";
                        ResultSet rs01 = con.selectCommand(sel01);
                        rs01.next();
                        newQty = (Integer.parseInt(rs01.getString("mstock_qty"))) + (Integer.parseInt(rs0.getString("cart_itemqty")));
                        String upd = "update tbl_masterstock set mstock_qty = '"+newQty+"' where shopproduct_id = '"+rs0.getString("shopproduct_id")+"'";
                        con.executeCommand(upd);
                        //out.println(upd);
                        String upd1 = "update tbl_cartbody set cart_itemstatus = 0 where shopproduct_id = '"+rs0.getString("shopproduct_id")+"' and cart_id = '"+request.getParameter("cartid")+"'";
                        con.executeCommand(upd1);
                        //out.println(upd1);
                    }while(rs0.next());
                }
                response.sendRedirect("SearchShop.jsp");
            }
            
            // Normal Page 
        %>
        
        <h1 align="center">Modify your choice</h1>
        
        <form method="POST">
            
            <table align="center" border="1" cellpadding="10" style="border-collapse:collapse;" >
                
                
                <tr>
                    <td>Mode of delivery: </td>
                    <td><input type="radio" name="rb_mod" required="required" value=0 checked/>Home Delivery <input type="radio" name="rb_mod" value=1 required="required"/>Take Away</td>
                </tr>
                
                <tr>
                    <td>Mode of payment: </td>
                    <td><input type="radio" name="rb_mop" required="required" value=0 checked/>Pay Now <input type="radio" name="rb_mop" value=1 required="required"/>Cash on Delivery</td>
                </tr>
                
                <tr>
                    <td>Expected time of delivery: </td>
                    <td><input type="time" name="txt_tod" required="required"/></td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="Proceed" name="btn_proceed"/>
                        <input type="reset" value="Reset your choice"/>
                        <a href="ModeSelection.jsp?cartid=<%=request.getParameter("cartid")%>&cartid1=<%=request.getParameter("cartid")%>" >Cancel Purchase</a>
                    </td>
                </tr>
                
            </table>
            
        </form>
        
        
    </body>
    
</html>
