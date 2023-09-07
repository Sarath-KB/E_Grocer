/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package WebService;

import DB.ConnectionClass;
import DB.mailconnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


/**
 *
 * @author HP
 */
@WebService(serviceName = "AndroidWebService")
public class AndroidWebService {

    ConnectionClass con=new ConnectionClass();
    mailconnection ma=new mailconnection();
    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "Login")
    public String Login(@WebParam(name = "username") String username, @WebParam(name = "password") String password) {
        
         String s="Success";
        String selQry="select * from tbl_deliveryagent where (da_email='"+username+"' or da_contact='"+username+"') and da_pwd='"+password+"' and da_status=1";
        System.out.println(selQry);
        ResultSet r=con.selectCommand(selQry);
        JSONArray J=new JSONArray();
        try {
            if(r.next()){
                JSONObject a=new JSONObject();
                try {
                    a.put("Sucess", s);
                    a.put("user_id", r.getString("da_id"));
                    J.put(a);
                } catch (JSONException ex) {
                    Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(J);
        return J.toString();

    }
    
    
      /**
     * Web service operation
     */
    @WebMethod(operationName = "myprofile")
    public String myprofile(@WebParam(name = "userid") String userid) {
        //TODO write your implementation code here:
         String sel="select * from tbl_deliveryagent where da_id='"+userid+"'";
        System.out.println(sel);
        ResultSet rs=con.selectCommand(sel);
        JSONArray J=new JSONArray();
        try {
            if(rs.next())
            {
                 JSONObject a=new JSONObject();
                try {
                    a.put("name", rs.getString("da_name"));
                    a.put("address", rs.getString("da_address"));
                    a.put("contact",rs.getString("da_contact"));
                    a.put("email",rs.getString("da_email"));
                    a.put("photo",rs.getString("da_photo"));
                    J.put(a);
                } catch (JSONException ex) {
                    Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
                    
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return J.toString();

    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "editprofile")
    public String editprofile(@WebParam(name = "userid") String userid, @WebParam(name = "username") String username, @WebParam(name = "useraddress") String useraddress, @WebParam(name = "usercontact") String usercontact, @WebParam(name = "useremail") String useremail) {
        //TODO write your implementation code here:
       
          String s="";
        String upQry="update tbl_deliveryagent set da_name='"+username+"',da_contact='"+usercontact+"',da_email='"+useremail+"',da_address='"+useraddress+"' where da_id='"+userid+"' ";
         System.out.println(upQry);
        boolean b=con.executeCommand(upQry);
        if(b==true)
        {
            s="Success";
        }
        else
        {
            s="Fail";
        }
        return s;

    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "changepassword")
    public String changepassword(@WebParam(name = "currentpassword") String currentpassword, @WebParam(name = "newpassword") String newpassword, @WebParam(name = "confirmpassword") String confirmpassword, @WebParam(name = "userid") String userid) {
        //TODO write your implementation code here:
       
        String Custid = null,a="";
        String sel="select * from tbl_deliveryagent where da_id='"+userid+"' ";
        ResultSet rs=con.selectCommand(sel);
        try {
            if(rs.next()){
                System.out.println(sel);
                try {
                    if(currentpassword.equals(rs.getString("da_pwd")))
                    {
                        System.out.println("Hai");
                         System.out.println("ne"+newpassword);
                          System.out.println("conf"+confirmpassword);
                        if(newpassword.equals(confirmpassword))
                        {
                            
                            String upQry="update tbl_deliveryagent set da_pwd='"+confirmpassword+"' where da_id='"+userid+"'";
                            boolean b=con.executeCommand(upQry);
                            System.out.println(upQry);
                            a="Success";
                        }
                        else
                        {
                            a="New password and confirm password not equal";
                        }
                    }
                    else{
                         a="Current Password Incorrect";
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return a;


    }


     /**
     * Web service operation
     */
    @WebMethod(operationName = "fchangepassword")
    public String fchangepassword(@WebParam(name = "newpassword") String newpassword, @WebParam(name = "confirmpassword") String confirmpassword, @WebParam(name = "userid") String userid) {
        //TODO write your implementation code here:
       
        String Custid = null,a="";
           if(newpassword.equals(confirmpassword))
               {
                            
                    String upQry="update tbl_deliveryagent set da_pwd='"+confirmpassword+"' where da_id='"+userid+"'";
                    boolean b=con.executeCommand(upQry);
                    System.out.println(upQry);
                    a="Password Changed Successfully";
               }
           else
               {
                     a="New password and confirm password not equal";
                }
        return a;

    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "sendmail")
    public String sendmail(@WebParam(name = "email") String email) {
        //TODO write your implementation code here:
        String a="";
        
         Random r=new Random();//to generate random number
             int r_num=r.nextInt(1111)+999;
             a = Integer.toString(r_num);
             
        String sel="select * from tbl_deliveryagent where da_email='"+email+"' ";
        ResultSet rs=con.selectCommand(sel);
        JSONArray J=new JSONArray();
        try {
            if(rs.next()){
                
                 String toAddress[]={email};
                    String subject="OTP";
                    String text=" Your OTP :"+a+"";
                            boolean b=ma.sendMail(toAddress, subject, text);
                            
                JSONObject a1=new JSONObject();
                try {
                    a1.put("otp", a);
                    a1.put("userid", rs.getString("da_id"));
                    
                    J.put(a1);
                } catch (JSONException ex) {
                    Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
       return J.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "shopdetails")
    public String shopdetails() {
        //TODO write your implementation code here:
            String sel="select * from tbl_shop";
        System.out.println(sel);
        ResultSet rs=con.selectCommand(sel);
        JSONArray J=new JSONArray();
        try {
            while(rs.next())
            {
                 JSONObject a=new JSONObject();
                 
                 String sel1="select count(cart_id) as cunt from tbl_carthead where shop_id='"+rs.getString("shop_id")+"' and da_id='0' and cart_status='1' and cart_delvmod='0' and cart_delvstat='1'";
                try {
                    ResultSet rs1= con.selectCommand(sel1);
                    if(rs1.next()){
                         a.put("available", rs1.getString("cunt"));
                    }
                     a.put("shopid", rs.getString("shop_id"));
                    a.put("shopname", rs.getString("shop_name"));
                    a.put("shopaddress", rs.getString("shop_address"));
                    a.put("shopcontact",rs.getString("shop_contact"));
                    a.put("shopemail",rs.getString("shop_email"));
                     a.put("shopimage",rs.getString("shop_img"));
                   
                    J.put(a);
                } catch (JSONException ex) {
                    Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
                    
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return J.toString();

    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "availableorders")
    public String availableorders(@WebParam(name = "shopid") String shopid) {
        //TODO write your implementation code here:
        String st="";
        String sel="select * from tbl_carthead ch inner join tbl_shop s on s.shop_id=ch.shop_id inner join tbl_user u on u.user_id=ch.user_id where ch.cart_status='1' and ch.shop_id='"+shopid+"' and ch.da_id='0' and ch.cart_delvmod='0' and ch.cart_delvstat='1' and ch.cart_paystat='0'";
        System.out.println(sel);
        ResultSet rs=con.selectCommand(sel);
        JSONArray J=new JSONArray();
        try {
            while(rs.next())
            {
                if(rs.getString("cart_paymod")=="0"){
                   st="Online Payment"; 
                }
                else{
                    st="Cash On Delivery"; 
                }
                 JSONObject a=new JSONObject();
                 try {
                    a.put("orderid", rs.getString("cart_id"));
                    a.put("time",rs.getString("cart_time"));
                    a.put("status",st);
                    a.put("saddress",rs.getString("shop_address"));
                    a.put("caddress",rs.getString("address"));
                    J.put(a);
                } catch (JSONException ex) {
                    Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
                       
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return J.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "acceptedorders")
    public String acceptedorders(@WebParam(name = "daid") String daid) {
        //TODO write your implementation code here:
        String st="";
        String sel="select * from tbl_carthead ch inner join tbl_shop s on s.shop_id=ch.shop_id inner join tbl_user u on u.user_id=ch.user_id where ch.cart_status='1' and ch.da_id='"+daid+"' and ch.cart_delvmod='0' and ch.cart_delvstat='2' and ch.cart_paystat='0'";
        System.out.println(sel);
        ResultSet rs=con.selectCommand(sel);
        JSONArray J=new JSONArray();
        try {
            while(rs.next())
            {
                if(rs.getString("cart_paymod")=="0"){
                   st="Online Payment"; 
                }
                else{
                    st="Cash On Delivery"; 
                }
                 JSONObject a=new JSONObject();
                 try {
                    a.put("orderid", rs.getString("cart_id"));
                    a.put("status",st);
                    a.put("cname",rs.getString("user_name"));
                    a.put("cphno",rs.getString("contact"));
                    a.put("amt",rs.getString("cart_price"));
                    a.put("time",rs.getString("cart_time"));
                    J.put(a);
                } catch (JSONException ex) {
                    Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
                       
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return J.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "deliveryboyaccept")
    public String deliveryboyaccept(@WebParam(name = "deliveryboyid") String deliveryboyid,@WebParam(name = "cartid") String cartid) {
        //TODO write your implementation code here:
        String s="";
        String upQry="update tbl_carthead set da_id='"+deliveryboyid+"',cart_delvstat='2' where cart_id='"+cartid+"' ";
         System.out.println(upQry);
        boolean b=con.executeCommand(upQry);
        if(b==true)
        {
            s="Success";
        }
        else
        {
            s="Fail";
        }
        return s;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "orderdetails")
    public String orderdetails(@WebParam(name = "orderid") String orderid) {
        //TODO write your implementation code here:
        String st="";
        String sel="select * from tbl_carthead ch inner join tbl_cartbody cb on cb.cart_id=ch.cart_id inner join tbl_shop s on s.shop_id=ch.shop_id inner join tbl_user u on u.user_id=ch.user_id inner join tbl_shopproduct sh on sh.shopproduct_id=cb.shopproduct_id inner join tbl_product p on p.product_id=sh.product_id where ch.cart_status='1' and ch.cart_id='"+orderid+"' and ch.cart_delvmod='0' and ch.cart_delvstat='2' and ch.cart_paystat='0'";
        System.out.println(sel);
        ResultSet rs=con.selectCommand(sel);
        JSONArray J=new JSONArray();
        try {
            while(rs.next())
            {
                if(rs.getString("cart_paymod")=="0"){
                   st="Online Payment"; 
                }
                else{
                    st="Cash On Delivery"; 
                }
                 JSONObject a=new JSONObject();
                 try {
                    a.put("orderid", rs.getString("cart_id"));
                    a.put("pname", rs.getString("product_name"));
                    a.put("pamt",rs.getString("cart_price"));
                    a.put("time",rs.getString("cart_time"));
                    a.put("status",st);
                    a.put("floc",rs.getString("shop_address"));
                    a.put("tloc",rs.getString("address"));
                    a.put("cname",rs.getString("user_name"));
                    a.put("cphno",rs.getString("contact"));
                    J.put(a);
                } catch (JSONException ex) {
                    Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
                       
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return J.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "custaccept")
    public String custaccept(@WebParam(name = "orderid") String orderid) {
        //TODO write your implementation code here:
        String s="";
        String upQry="update tbl_carthead set cart_delvstat='3',cart_paystat='1' where cart_id='"+orderid+"' ";
         System.out.println(upQry);
        boolean b=con.executeCommand(upQry);
        if(b==true)
        {
            s="Success";
        }
        else
        {
            s="Fail";
        }
        return s;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "custreject")
    public String custreject(@WebParam(name = "orderid") String orderid) {
        //TODO write your implementation code here:
         String s="";
        String upQry="update tbl_carthead set cart_delvstat='4' where cart_id='"+orderid+"' ";
         System.out.println(upQry);
        boolean b=con.executeCommand(upQry);
        if(b==true)
        {
            s="Success";
        }
        else
        {
            s="Fail";
        }
        return s;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "homecount")
    public String homecount(@WebParam(name = "deid") String deid) {
        String neworder="0",acorder="0",deliverypending="0",itemretrun="0";
        int total=0,total1=0;
        String sel="select count(cart_id) as cunt from tbl_carthead where cart_status='1' and da_id='0' and cart_delvmod='0' and cart_delvstat='1'";
        System.out.println(sel);
        ResultSet rs=con.selectCommand(sel);
       
        try {
            if(rs.next())
            {
                  neworder = rs.getString("cunt");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        String sel1="select count(cart_id) as cunt from tbl_carthead where cart_status='1' and da_id='"+deid+"' and cart_delvmod='0' and cart_delvstat='2' and cart_date=curdate() ";
        System.out.println(sel1);
        ResultSet rs1=con.selectCommand(sel1);
       
        try {
            if(rs1.next())
            {
                  deliverypending = rs1.getString("cunt");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String sel2="select count(cart_id) as cunt from tbl_carthead where cart_status='1' and da_id='"+deid+"' and cart_delvmod='0' and cart_delvstat='3' and cart_date=curdate() ";
        System.out.println(sel2);
        ResultSet rs2=con.selectCommand(sel2);
       
        try {
            if(rs2.next())
            {
                  acorder = rs2.getString("cunt");
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
          String sel3="select count(cart_id) as cunt from tbl_carthead where cart_status='1' and da_id='"+deid+"' and cart_delvmod='0' and cart_delvstat='4' and cart_date=curdate() ";
        System.out.println(sel3);
        ResultSet rs3=con.selectCommand(sel3);
       
        try {
            if(rs3.next())
            {
                  itemretrun = rs3.getString("cunt");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
         JSONArray J=new JSONArray();
        JSONObject a=new JSONObject();
        try {
            a.put("neworder", neworder);
             a.put("acorder", acorder);
              a.put("deliverypending", deliverypending);
               a.put("itemretrun", itemretrun);
               J.put(a);
            
        } catch (JSONException ex) {
            Logger.getLogger(AndroidWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return J.toString();

    }
  
}
