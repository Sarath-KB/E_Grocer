<%-- 
    Document   : minmax
    Created on : Apr 5, 2021, 8:53:25 PM
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
            int a=0,b=0,c=0,max=0,min=0;
            
            if (request.getParameter("find")!=null){
                a=Integer.parseInt(request.getParameter("num1"));
                b=Integer.parseInt(request.getParameter("num2"));
                c=Integer.parseInt(request.getParameter("num3"));
                if(a>b && a>c){
                    max=a;
                    if(b<c){
                        min=b;
                    }
                    else{
                        min=c;
                    }
                }
                if(b>a && b>c){
                    max=b;
                    if(a<c){
                        min=a;
                    }
                    else{
                        min=c;
                    }
                }
                else{
                    max=c;
                    if(a<b){
                        min=a;
                    }
                    else{
                        min=b;
                    }
                }
            }
        %>
        
        <form>
            <table>
                <tr>
                    <td>Num 1</td>
                    <td><input type="text" name="num1" value="<%=a%>"/></td>
                </tr>
                <tr>
                    <td>Num 2</td>
                    <td><input type="text" name="num2" value="<%=b%>"/></td>
                </tr>
                <tr>
                    <td>Num 3</td>
                    <td><input type="text" name="num3" value="<%=c%>"/></td>
                </tr>
                <tr>
                    <td colspan="2"><center><input type="submit" value='Find' name="find"/></center></td>
                </tr>
                <tr>
                    <td>Maximum</td>
                    <td>
                        <input type="text" name="maxm" value="<%=max%>"></td>
                </tr>
                <tr>
                    <td>Minimum</td>
                    <td>
                        <input type="text" name="minm" value="<%=min%>"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
