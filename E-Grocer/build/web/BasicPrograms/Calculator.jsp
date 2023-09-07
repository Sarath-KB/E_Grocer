<%-- 
    Document   : Calculator
    Created on : Apr 5, 2021, 4:05:14 PM
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
            int a=0,b=0,c=0;

            if (request.getParameter("btnAdd") != null) {
                 a = Integer.parseInt(request.getParameter("txtno1"));
                 b = Integer.parseInt(request.getParameter("txtno2"));
                 c = a + b;
               // System.out.print(c);
            }
             if (request.getParameter("btnMinus") != null) {
                 a = Integer.parseInt(request.getParameter("txtno1"));
                 b = Integer.parseInt(request.getParameter("txtno2"));
                 c = a - b;
                //out.print(c);
            }
        %>




        <form>
            <table>
                <tr>
                    <td>Number-1</td>
                    <td>
                        <input type="text" name="txtno1" value="<%=a%>"></td>
                </tr>
                <tr>
                    <td>Number-2</td>
                    <td>
                        <input type="text" name="txtno2" value="<%=b%>"></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="btnAdd" value="+">
                        <input type="submit" name="btnMinus" value="-">
                    </td>
                </tr>
                <tr>
                    <td>Result</td>
                    <td>
                        <input type="text" name="txtresult" value="<%=c%>"></td>
                </tr>
            </table>

        </form>
    </body>
</html>
