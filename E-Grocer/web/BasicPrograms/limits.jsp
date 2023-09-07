<%-- 
    Document   : limits
    Created on : Apr 8, 2021, 12:01:09 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
            int start = 0, end = 0, flag;
            String primeNo="No";
            if(request.getParameter("find")!=null){
                start = Integer.parseInt(request.getParameter("begin"));
                end = Integer.parseInt(request.getParameter("stop"));
                for(int i=start; i<end; i++){
                    flag = 0;
                    for(int j=2; j<(i/2); j++){
                        if(i%j==0){
                            flag++;
                            break;
                        }
                    }
                    if(flag==0){
                        out.print(i+"\n");
                        primeNo = "yes";
                    }
                }
                if(primeNo=="No"){
                    out.println("No prime numbers within the specified range");
                }
            }
         %>
         
         <form>
             <table>
                 <tr>
                     <td>Start:</td>
                     <td><input type="text" name="begin" value="<%=start%>"/></td>
                 </tr>
                 <tr>
                     <td>End:</td>
                     <td><input type="text" name="stop" value="<%=end%>"/></td>
                 </tr>
                 <tr>
                     <td colspan="2" align="center">
                         <input type="submit" name="find" value="Find"/>
                     </td>
                 </tr>
             </table>
         </form>
    </body>
</html>
