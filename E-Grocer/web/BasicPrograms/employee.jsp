<%-- 
    Document   : employee
    Created on : Apr 8, 2021, 4:20:28 PM
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
            String fname = "First Name",lname = "Last Name", gender = "", mstatus = "", dept = "";
            int sal = 0;
            
            String name = "";
            double ta = 0, da = 0, hra = 0, lic = 0, pf = 0, net = 0;
            
            if(request.getParameter("submit")!=null){
                
                fname = request.getParameter("fname");
                lname = request.getParameter("lname");
                gender = request.getParameter("gender");
                mstatus = request.getParameter("mstatus");
                dept = request.getParameter("dept");
                sal = Integer.parseInt(request.getParameter("sal"));
                
                //Name = Mr/Ms/Mrs. firstName + lastName
                if(gender.equals("F") && mstatus.equals("Single")){
                    name = "Ms. " + fname + " " + lname;
                }
                else if(gender.equals("F")){
                    name = "Mrs. " + fname + " " + lname;
                }
                else{
                    name = "Mr. " + fname + " " + lname;
                }
                
                //Gender in words
                if(gender.equals("F")){
                    gender = "Female";
                }
                else{
                    gender = "Male";
                }
                
                //Salary & allowance calculations
                if(dept.equals("Administration")){
                    ta = sal * 0.5;
                    da = sal * 0.45;
                    hra = sal * 0.4;
                    lic = sal * 0.35;
                    pf = sal * 0.3;
                }
                else if(dept.equals("Production")){
                    ta = sal * 0.45;
                    da = sal * 0.4;
                    hra = sal * 0.35;
                    lic = sal * 0.3;
                    pf = sal * 0.25;
                }
                else{
                    ta = sal * 0.4;
                    da = sal * 0.35;
                    hra = sal * 0.3;
                    lic = sal * 0.25;
                    pf = sal * 0.2;
                }                
                net = sal + ta + da + hra - lic - pf;
                
            }
        %>
        
        <form>
            <table>
                <tr>
                    <td>First Name: </td>
                    <td>
                        <input type="text" name="fname"/>
                    </td>
                </tr>
                <tr>
                    <td>Last Name: </td>
                    <td>
                        <input type="text" name="lname"/>
                    </td>
                </tr>
                <tr>
                    <td>Gender: </td>
                    <td>
                        <input type="radio" name="gender" value="M"/>M
                        <input type="radio" name="gender" value="F"/>F
                    </td>
                </tr>
                <tr>
                    <td>Marital Status: </td>
                    <td>
                        <input type="radio" name="mstatus" value="Single"/>Single
                        <input type="radio" name="mstatus" value="Married"/>Married
                    </td>
                </tr>
                <tr>
                    <td>Department: </td>
                    <td>
                        <select name="dept">
                            <option>---Select your department---</option>
                            <option>Administration</option>
                            <option>Production</option>
                            <option>Marketing</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Basic Salary: </td>
                    <td>
                        <input type="text" name="sal"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" name="submit" value="Submit"/>
                        <input type="reset" name="cancel" value="Cancel"/>
                    </td>
                </tr>
                <tr>
                    <td>Name: </td>
                    <td>
                        <input type="text" name="name" value="<%=name%>"/>
                    </td>
                </tr>
                <tr>
                    <td>Gender: </td>
                    <td>
                        <input type="text" name="genderr" value="<%=gender%>"/>
                    </td>
                </tr>
                <tr>
                    <td>Marital Status: </td>
                    <td>
                        <input type="text" name="mastatus" value="<%=mstatus%>"/>
                    </td>
                </tr>
                <tr>
                    <td>Department: </td>
                    <td>
                        <input type="text" name="dname" value="<%=dept%>"/>
                    </td>
                </tr>
                <tr>
                    <td>TA: </td>
                    <td><%=ta%></td>
                </tr>
                <tr>
                    <td>DA: </td>
                    <td><%=da%></td>
                </tr>
                <tr>
                    <td>HRA: </td>
                    <td><%=hra%></td>
                </tr>
                <tr>
                    <td>LIC: </td>
                    <td><%=lic%></td>
                </tr>
                <tr>
                    <td>PF: </td>
                    <td><%=pf%></td>
                </tr>
                <tr>
                    <td>Net: </td>
                    <td><%=net%></td>
                </tr>
            </table>
        </form>
        
        
        
    </body>
</html>
