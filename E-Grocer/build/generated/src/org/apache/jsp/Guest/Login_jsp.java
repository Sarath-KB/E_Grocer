package org.apache.jsp.Guest;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.ResultSet;

public final class Login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      DB.ConnectionClass con = null;
      synchronized (_jspx_page_context) {
        con = (DB.ConnectionClass) _jspx_page_context.getAttribute("con", PageContext.PAGE_SCOPE);
        if (con == null){
          con = new DB.ConnectionClass();
          _jspx_page_context.setAttribute("con", con, PageContext.PAGE_SCOPE);
        }
      }
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Login</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        \n");
      out.write("        ");

            if(request.getParameter("btn_submit")!=null){
                String qry ="select * from tbl_user where (email='"+request.getParameter("txt_loginid")+"'"
                           +" or contact='"+request.getParameter("txt_loginid")+"')"
                           +" and password='"+request.getParameter("txt_pwd")+"'";
                String sqry="select * from tbl_shop where (shop_email='"+request.getParameter("txt_loginid")+"'"
                           +" or shop_contact='"+request.getParameter("txt_loginid")+"')"
                           +" and shop_pwd='"+request.getParameter("txt_pwd")+"' and shop_status=1";
                String qry1="select * from tbl_deliveryagent where (da_email='"+request.getParameter("txt_loginid")+"'"
                           +" or da_contact='"+request.getParameter("txt_loginid")+"')"
                           +" and da_pwd='"+request.getParameter("txt_pwd")+"' and da_status=1";
                ResultSet rs =con.selectCommand(qry);
                ResultSet rs1=con.selectCommand(sqry);
                ResultSet rs2=con.selectCommand(qry1);
                if(rs.next()){
                    session.setAttribute("username",rs.getString("user_name"));
                    session.setAttribute("userid",rs.getString("user_id"));
                    
                    response.sendRedirect("../User/HomePage.jsp");
                   
                }
                else if(rs1.next()){
                    
                    session.setAttribute("username",rs1.getString("shop_name"));
                    session.setAttribute("userid",rs1.getString("shop_id"));
                    
                    response.sendRedirect("../Grocer/HomePage.jsp");
                }
                else if(rs2.next()){
                    
                    session.setAttribute("username",rs2.getString("da_name"));
                    session.setAttribute("userid",rs2.getString("da_id"));
                    
                    response.sendRedirect("../DeliveryBoy/HomePage.jsp");
                }
                else{
                    out.println("<script>alert('Login Failed')</script>");
                }
            }
        
      out.write("\n");
      out.write("        \n");
      out.write("        <center><h3>Login</h3></center>\n");
      out.write("        \n");
      out.write("        <table border=\"2\" align=\"center\">\n");
      out.write("            <form method=\"POST\">\n");
      out.write("                <tr>\n");
      out.write("                    <td>Login ID: </td>\n");
      out.write("                    <td><input type=\"text\" name=\"txt_loginid\" required=\"required\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td>Password: </td>\n");
      out.write("                    <td><input type=\"password\" name=\"txt_pwd\" required=\"required\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"2\" align=\"center\">\n");
      out.write("                        <input type=\"submit\" name=\"btn_submit\" value=\"Login\"/>\n");
      out.write("                        <input type=\"reset\" name=\"btn_reset\" value=\"Reset\"/>\n");
      out.write("                    </td>\n");
      out.write("                </tr>\n");
      out.write("            </form>\n");
      out.write("        </table>\n");
      out.write("        \n");
      out.write("        <h1> </h1>\n");
      out.write("        \n");
      out.write("        <center>\n");
      out.write("            Register as:\n");
      out.write("            <a href=\"NewUser.jsp\">Customer</a>\n");
      out.write("            <a href=\"NewShop.jsp\">Grocer</a>\n");
      out.write("            <a href=\"NewDeliveryAgency.jsp\">Delivery Agent</a>\n");
      out.write("        </center>\n");
      out.write("        \n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
