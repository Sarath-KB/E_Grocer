<%-- 
    Document   : AddToCart
    Created on : May 12, 2021, 1:28:44 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add To Cart</title>
    </head>
    
    <body>
        
        <%
            //out.println(request.getParameter("ppid"));
            if(request.getParameter("ppid")!=null && request.getParameter("scciid")!=null){
                session.setAttribute("pid", request.getParameter("ppid"));
                //out.println(session.getAttribute("pid"));
                String sel0 = "select * from tbl_cartbody where cart_id = '"+request.getParameter("scciid")+"' and cart_itemstatus = 1";
                ResultSet rs0 = con.selectCommand(sel0);
                if(rs0.next()){
                    //out.println(rs0.getString("cart_itemstatus"));
                    do{
                        int newQty = 0;
                        String sel01 = "Select * from tbl_masterstock where shopproduct_id = '"+rs0.getString("shopproduct_id")+"'";
                        ResultSet rs01 = con.selectCommand(sel01);
                        rs01.next();
                        newQty = (Integer.parseInt(rs01.getString("mstock_qty"))) + (Integer.parseInt(rs0.getString("cart_itemqty")));
                        String upd = "update tbl_masterstock set mstock_qty = '"+newQty+"' where shopproduct_id = '"+rs0.getString("shopproduct_id")+"'";
                        con.executeCommand(upd);
                        //out.println(upd);
                        String upd1 = "update tbl_cartbody set cart_itemstatus = 0 where shopproduct_id = '"+rs0.getString("shopproduct_id")+"' and cart_id = '"+request.getParameter("scciid")+"'";
                        con.executeCommand(upd1);
                        //out.println(upd1);
                    }while(rs0.next());
                }
            }
            String mqty = "", spid = "" , ctid="0";
            if(request.getParameter("btn_addtocart")!=null){ // to listen for button click
                
                String shp_qry = "select * from tbl_shopproduct where shopproduct_id = '"+session.getAttribute("pid")+"'"; // qry to help out to differentiate carts for each shop
                ResultSet rs0 = con.selectCommand(shp_qry);
                rs0.next();
                
                if( Integer.parseInt(request.getParameter("txt_qty")) >= 0 ){ // to check whether value entered is within the legal limit
                    
                    String sel1 = "select * from tbl_carthead where user_id = '"+session.getAttribute("userid")+"' and cart_status = 0 and shop_id = '"+rs0.getString("shop_id")+"'" ; 
                    ResultSet rs1 = con.selectCommand(sel1);
                    
                    if(rs1.next()){ // to check whether a open cart exist already or not( updation of qty of already entered cart item or insertion new cart item )
                        
                        // existing cart
                        
                        ctid = rs1.getString("cart_id"); // added for traversal purpose among pages
                        
                        if( Integer.parseInt(request.getParameter("txt_qty")) > 0 ){ // to check whether the qty entered is above 0 or not
                            
                            String sel2 = "select * from tbl_cartbody tcb inner join tbl_masterstock tms on tcb.shopproduct_id = tms.shopproduct_id "
                                        + "inner join tbl_shopproduct tsp on tsp.shopproduct_id = tms.shopproduct_id inner join tbl_carthead tch on tch.shop_id = tsp.shop_id "
                                        + "where tms.shopproduct_id = '"+session.getAttribute("pid")+"' and  "
                                        + "user_id = '"+session.getAttribute("userid")+"' and cart_status = 0 and tch.shop_id = '"+rs0.getString("shop_id")+"'";
                            ResultSet rs2 = con.selectCommand(sel2);
                            String sel21 = "select * from tbl_carthead  where user_id = '"+session.getAttribute("userid")+"' and cart_status = 0 and shop_id = '"+rs0.getString("shop_id")+"'";
                            ResultSet rs21 = con.selectCommand(sel21);
                            String sel22 = "select * from tbl_shopproduct tsp inner join tbl_masterstock tms on tsp.shopproduct_id = tms.shopproduct_id "
                                         + "where tms.shopproduct_id = '"+session.getAttribute("pid")+"'";
                            ResultSet rs22 = con.selectCommand(sel22);
                            
                            
                            if(rs2.next()){ // checking whether it is an update for qty of a cartitem that is already entered
                                
                                // update for qty of an already added cartitem
                                
                                String upd = "update tbl_cartbody set cart_itemqty = '"+request.getParameter("txt_qty")+"' where cart_id = '"+Integer.parseInt(rs2.getString("cart_id"))+"' and "
                                           + "shopproduct_id = '"+session.getAttribute("pid")+"'";
                                
                                if( Integer.parseInt(rs2.getString("mstock_qty")) >= Integer.parseInt(request.getParameter("txt_qty")) ){ // to check whether requested qty is available in stock
                                    
                                    if(con.executeCommand(upd)){
                                        out.println("<script>alert('Quantity Updated')</script>");
                                    }
                                    else{
                                        out.println("<script>alert('Quantity Updation failed')</script>");
                                    }
                                }
                                else{
                                    out.println("<script>alert('Out of stock')</script>");
                                }
                                
                            }
                            else{
                                
                                // insertion of new cartitem into the opencart
                                
                                rs21.next();
                                rs22.next();
                                String ins = "insert into tbl_cartbody(cart_id,shopproduct_id,cart_itemqty,cart_itemprice) values('"+rs21.getString("cart_id")+"', '"+session.getAttribute("pid")+"', "
                                           + "'"+Integer.parseInt(request.getParameter("txt_qty"))+"', '"+rs22.getString("mstock_price")+"')";
                                
                                if( Integer.parseInt(rs22.getString("mstock_qty")) >= Integer.parseInt(request.getParameter("txt_qty")) ){ // to check whether requested qty is available in stock
                                    
                                    if(con.executeCommand(ins)){
                                        out.println("<script>alert('Item added to the cart')</script>");
                                    }
                                    else{
                                        out.println("<script>alert('Item not added to the cart')</script>");
                                    }
                                }
                                else{
                                    out.println("<script>alert('Out of stock')</script>");
                                }
                            }
                            
                        }
                        else{
                            
                            // for qty entered is 0
                            
                            String sel3 = "select * from tbl_cartbody tcb inner join tbl_carthead tch on tcb.cart_id = tch.cart_id where shopproduct_id = '"+session.getAttribute("pid")+"' and  "
                                        + "user_id = '"+session.getAttribute("userid")+"' and cart_status = 0 and shop_id = '"+rs0.getString("shop_id")+"'";
                            ResultSet rs3 = con.selectCommand(sel3);
                            
                            if(rs3.next()){ //if the qty is entered for a cartitem then we have to remove the item from cart
                                
                                String del3 = "delete  from tbl_cartbody where cart_id = '"+Integer.parseInt(rs3.getString("cart_id"))+"' and shopproduct_id = '"+session.getAttribute("pid")+"'";
                                
                                if(con.executeCommand(del3)){
                                    out.println("<script>alert('Item removed from cart')</script>");
                                }
                                else{
                                    out.println("<script>alert('Failed to remove item from cart')</script>");
                                }
                            }
                            else{
                                out.println("<script>alert('Invalid Entry')</script>");
                            }
                        }
                        
                    }
                    else{
                        
                        // new cart
                        
                        String sel4 = "select * from tbl_shopproduct tsp inner join tbl_masterstock tms on tsp.shopproduct_id = tms.shopproduct_id "
                                    + "where tms.shopproduct_id = '"+session.getAttribute("pid")+"'";
                        ResultSet rs4 = con.selectCommand(sel4);
                        rs4.next();
                        
                        if( Integer.parseInt(request.getParameter("txt_qty")) > 0 ){ // to check whether the qty entered is above 0 or not
                            
                            String ins4 = "insert into tbl_carthead(shop_id,user_id) values('"+rs4.getString("shop_id")+"','"+session.getAttribute("userid")+"')";
                            
                            if( Integer.parseInt(rs4.getString("mstock_qty")) >= Integer.parseInt(request.getParameter("txt_qty")) ){ // to check whether requested qty is available in stock
                                
                                    if(con.executeCommand(ins4)){ // to check carthead is created or not
                                        
                                        // carthead created
                                        
                                        String sel41 = "select * from tbl_carthead where user_id = '"+session.getAttribute("userid")+"' and cart_status = 0 and shop_id = '"+rs0.getString("shop_id")+"'"; 
                                        ResultSet rs41 = con.selectCommand(sel41);
                                        rs41.next();
                                        
                                        String ins41 = "insert into tbl_cartbody(cart_id,shopproduct_id,cart_itemqty,cart_itemprice) "
                                                     + "values('"+rs41.getString("cart_id")+"','"+session.getAttribute("pid")+"',"
                                                     + "'"+request.getParameter("txt_qty")+"','"+rs4.getString("mstock_price")+"')";
                                        
                                        ctid = rs41.getString("cart_id"); // added for traversal purpose among pages
                                        
                                        if(con.executeCommand(ins41)){
                                            out.println("<script>alert('Cart creation & insertion successful')</script>");
                                        }
                                        else{
                                            out.println("<script>alert('Cart creation successful')</script>");
                                        }
                                    }
                                    else{
                                        out.println("<script>alert('Cart creation  failed')</script>");
                                    }
                            }
                            else{
                                out.println("<script>alert('Out of stock')</script>");
                            }
                        }
                        else{
                                out.println("<script>alert('Invalid Entry')</script>");
                        }
                    }
                    
                }
                else{
                    out.println("<script>alert('Invalid Entry')</script>");
                }
            }
            
            
            // qry for product details 
            
            String sel_qty = "select * from tbl_shopproduct shp inner join tbl_product p on shp.product_id = p.product_id  "
                           + "inner join tbl_masterstock ms on ms.shopproduct_id = shp.shopproduct_id inner join tbl_brand b on shp.brand_id = b.brand_id "
                           + "inner join tbl_category c on c.category_id = p.category_id where shp.shopproduct_id= '"+session.getAttribute("pid")+"'"; 
            ResultSet rsq = con.selectCommand(sel_qty);
                                        
            if(rsq.next()){
                
                mqty = "0";
                spid = rsq.getString("shop_id");
                
                // qry for checking whether cart exist or not 
                
                String sel_d = "select * from tbl_cartbody tcb inner join tbl_carthead tch on tcb.cart_id = tch.cart_id where user_id = '"+session.getAttribute("userid")+"' and cart_status = 0 " 
                             + "and shopproduct_id= '"+session.getAttribute("pid")+"'"; 
                ResultSet rsd = con.selectCommand(sel_d);
                
                if(rsd.next()){ // to get quantity value incase you are just updating the qty of an item which is already in the cart
                    mqty = rsd.getString("cart_itemqty");
                    ctid = rsd.getString("cart_id");
                    
                }
                
        %>
        
        <form method="post">
        <table  border="1" align="center" cellpadding="10" style="border-collapse:collapse;">
          
            <tr>
                <td colspan="2"><%=rsq.getString("brand_name")%> <%=rsq.getString("product_name")%></td>
                <td rowspan="2"><img src="../Assets/Product Image/<%=rsq.getString("product_img")%>" width="80" height="80" alt="Product Image"/></td>
                
            </tr>
            <tr>
                <td colspan="2"><%=rsq.getString("category_name")%></td>
            </tr>
            <tr>
                <td><center><b style="color:green;">₹<%=rsq.getString("mstock_price")%></b></center></td>
                <td>In Stock: <b style="color:blue;"><%=rsq.getString("mstock_qty")%></b> </td>
                <td rowspan="2">
                <%
                    if((Integer.parseInt(rsq.getString("mstock_qty")))>0){
                %>
                        <input type="text" name="txt_qty" value="<%=mqty%>" required="required"/><input type="submit" name="btn_addtocart" value="Add to cart"/>
                <%
                    }else{
                %>
                        <b style="color:red;">Out of Stock</b>
                <%
                    }
                %>
                </td>
            </tr>
            <tr>
                <td colspan="2">Description: <%=rsq.getString("shopproduct_desc")%> </td>
            </tr>
        </table>
        </form>
            <h5 style="color:green;" align="center">Hint: Inorder remove item from cart please enter value 0 in the field and press add to cart</h5>
            <b><a href="ViewShopProduct.jsp?shid=<%=rsq.getString("shop_id")%>">Go back to shop</a></b>
            
        <%     
                
            }
            
             // added exclusively for traversal purpose among pages
            
            String sel_dp = "select * from tbl_cartbody tcb inner join tbl_carthead tch on tcb.cart_id = tch.cart_id where user_id = '"+session.getAttribute("userid")+"' and cart_status = 0 and tch.cart_id = '"+ctid+"'";
            ResultSet rsp = con.selectCommand(sel_dp);
            if(rsp.next()){
            
        %>
        
        <b><a href="ProceedToPurchase.jsp?cid=<%=rsp.getString("cart_id")%>">Proceed to purchase</a></b>
        
        
        <%
        
            }
            else{
              
        %>
        
             <h1> </h1>
             
        <%
                
            }
            
        %>
             
    </body>
</html>
