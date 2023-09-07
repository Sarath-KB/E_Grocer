<%-- 
    Document   : UploadAction
    Created on : 20 Jan, 2018, 11:20:40 AM
    Author     : Swathy
--%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="org.apache.commons.fileupload.servlet.*" %>
<%@page import="org.apache.commons.fileupload.disk.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <%
           
             FileItem f_item=null;
             File savedFile=null;
             
       String field_name="";
       String fn="",pf="",proof="",fn1="",fn2="";
       String file_name="";


String field[] = new String[20];
String value[] = new String[20];

//checking if request cotains multipart data
boolean isMultipart=ServletFileUpload.isMultipartContent(request);//true/false

if(isMultipart)
{
   

    FileItemFactory factory=new DiskFileItemFactory();
    ServletFileUpload upload=new ServletFileUpload(factory);

    //declaring a list of form fields.everything on form adding t itemlist
    List items_list=null;

    //assigning fields to list 'items_list'
    try
    {
    items_list=upload.parseRequest(request);//requeat contains evrything on form this is parsed and stored to item_list
    }
    catch(FileUploadException ex)
    {
        out.println(ex);
    }

          //declaring iterator used to iterate through all positions in item_lists
   Iterator itr=items_list.iterator();
    int k=0;
    //iterating through the list 'items_list'
    while(itr.hasNext())//checking if there is any value in the position like rs.next()
    {
       
        //typecasting next element in items_list as fileitem
        f_item=(FileItem)itr.next();// value to which the iterator points  and is coverted to fileitem format

        //checking if 'f_item' contains a formfield(common controls like textbox,dropdown,radio buttonetc) or multipath
       if(f_item.isFormField())
        {
          
            //getting fieldname and value
            field[k]=f_item.getFieldName();//field
            value[k]=f_item.getString();//user typing value
                
                k++;//
        }
       else//when it is an image or multipart
       {
		   
		   
            //f_item=(FileItem)itr.next();
            
           file_name=f_item.getName();
           field_name=f_item.getFieldName();
           if(field_name.equals("fl_photo"))//write the name of image here it is img_product
           {
           String ext=file_name.substring(file_name.lastIndexOf("."));//means the extension is stored to variable ext
            //setting path to store image
            File proj_path=new File(config.getServletContext().getRealPath("/"));
            String file_path=proj_path.getParentFile().getParentFile().getPath()+"\\Web\\Assets\\Delivery Agent\\";//path for storing image
            Random r=new Random();//to generate random number
             int r_num=r.nextInt(1111)+999;//values between this are generated
             
            fn="fl_photo_"+r_num+ext;//generating random number for images so this name and format of imagewil be stored inside the server
            //creating a file object
            savedFile=new File(file_path+fn);//fn contains name of file
             try
            {
                //writing the file object
                f_item.write(savedFile);  //writing to server means the folder             
                
            }
            catch(Exception ex)
            {
                out.println(ex);
            }
            }
           if(field_name.equals("fl_drvlic"))//write the name of image here it is img_product
           {
           String ext=file_name.substring(file_name.lastIndexOf("."));//means the extension is stored to variable ext
            //setting path to store image
            File proj_path=new File(config.getServletContext().getRealPath("/"));
            String file_path=proj_path.getParentFile().getParentFile().getPath()+"\\Web\\Assets\\Delivery Agent\\";//path for storing image
            Random r=new Random();//to generate random number
             int r_num=r.nextInt(1111)+999;//values between this are generated
             
            fn1="fl_drvlic_"+r_num+ext;//generating random number for images so this name and format of imagewil be stored inside the server
            //creating a file object
            savedFile=new File(file_path+fn1);//fn contains name of file
             try
            {
                //writing the file object
                f_item.write(savedFile);  //writing to server means the folder             
                
            }
            catch(Exception ex)
            {
                out.println(ex);
            }
            }
           if(field_name.equals("fl_vehproof"))//write the name of image here it is img_product
           {
           String ext=file_name.substring(file_name.lastIndexOf("."));//means the extension is stored to variable ext
            //setting path to store image
            File proj_path=new File(config.getServletContext().getRealPath("/"));
            String file_path=proj_path.getParentFile().getParentFile().getPath()+"\\Web\\Assets\\Delivery Agent\\";//path for storing image
            Random r=new Random();//to generate random number
             int r_num=r.nextInt(1111)+999;//values between this are generated
             
            fn2="fl_vehproof_"+r_num+ext;//generating random number for images so this name and format of imagewil be stored inside the server
            //creating a file object
            savedFile=new File(file_path+fn2);//fn contains name of file
             try
            {
                //writing the file object
                f_item.write(savedFile);  //writing to server means the folder             
                
            }
            catch(Exception ex)
            {
                out.println(ex);
            }
            }
           
           
           //to upload proof of doctor
           
           
           
           
  
       }
           
           }
    //Strinh str1="insert into tbl_user ()";//inserting file
    String sel1 = "select * from tbl_user where email = '" + value[3] + "'";
                String sel2 = "select * from tbl_user where contact = '" + value[2] + "'";
                String sel3 = "select * from tbl_shop where shop_email = '" + value[3] + "'";
                String sel4 = "select * from tbl_shop where shop_contact = '" + value[2] + "'";
                String sel5 = "select * from tbl_deliveryagent where da_email = '" + value[3] + "'";
                String sel6 = "select * from tbl_deliveryagent where da_contact = '" + value[2] + "'";
                ResultSet rs1 = con.selectCommand(sel1);
                ResultSet rs2 = con.selectCommand(sel2);
                ResultSet rs3 = con.selectCommand(sel3);
                ResultSet rs4 = con.selectCommand(sel4);
                ResultSet rs5 = con.selectCommand(sel5);
                ResultSet rs6 = con.selectCommand(sel6);
                if(rs1.next() || rs3.next() || rs5.next()){
                    %>
        <script type="text/javascript">
            alert("Email ID given is already in use");
            setTimeout(function(){window.location.href='DeliveryBoyReg.jsp'},40);
        </script>
        <%
                }
                else if(rs2.next() || rs4.next() || rs6.next()){
                    %>
        <script type="text/javascript">
            alert("Mobile No. given is already in use");
            setTimeout(function(){window.location.href='DeliveryBoyReg.jsp'},40);
        </script>
        <%
                }
              else{
    if(value[8].equals(value[9])){
   String str1="insert into tbl_deliveryagent(da_name,da_photo,da_dob,da_contact,da_email,da_address,place_id,da_pincode,da_drivlic,da_vehproof,da_pwd)"
              +"values('"+value[0]+"','"+fn+"','"+value[1]+"','"+value[2]+"','"+value[3]+"','"+value[4]+"','"+value[6]+"','"+value[7]+"','"+fn1+"','"+fn2+"','"+value[8]+"')";
   System.out.println(str1);
   out.println(str1);
   
    boolean status=con.executeCommand(str1);
    out.println(status);
    if(status==true)
    {
      %> 
       <script type="text/javascript">
            alert("Upload Successfully..");
        setTimeout(function(){window.location.href='DeliveryBoyReg.jsp'},40);</script>
     <%
    }
     }else{
        %>
        <script type="text/javascript">
            alert("Password MisMatch.....");
           setTimeout(function(){window.location.href='DeliveryBoyReg.jsp'},40);  </script>
        <%
    }
    }
}

        %>
    </body>
</html>
