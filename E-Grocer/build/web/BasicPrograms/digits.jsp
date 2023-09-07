<%-- 
    Document   : digits
    Created on : Apr 7, 2021, 11:12:05 PM
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
            int num=0, summ=0, rev=0, dup;
            String palindrome="Yes";
            if(request.getParameter("find")!=null){
                num=Integer.parseInt(request.getParameter("number"));
                dup=num;
                out.println("Digits are: ");
                while(dup>0){
                    summ+=(dup%10);
                    rev=(rev*10)+(dup%10);
                    dup/=10;
                }
                if(num==rev){
                    palindrome="Yes";
                }
                else{
                    palindrome="No";
                }
                int rev1 =rev;
                while(rev1>0){
                    out.println((rev1%10));
                    rev1/=10;
                }
            }
        %>
        
        <form>
            <table>
                <tr>
                    <td>Number: </td>
                    <td>
                        <input type="text" name="number" value="<%=num%>"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="find" value="Find"/>
                    </td>
                </tr>
                <tr>
                    <td>Digit Sum: </td>
                    <td><%=summ%></td>
                </tr>
                <tr>
                    <td>Reverse: </td>
                    <td><%=rev%></td>
                </tr>
                <tr>
                    <td>Palindrome: </td>
                    <td><%=palindrome%></td>
                </tr>
            </table>
        </form>
    </body>
</html>
