package org.apache.jsp.Admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.ResultSet;

public final class DeliveryAgentList_002dNew_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write('\n');
      out.write('\n');
      DB.ConnectionClass con = null;
      synchronized (_jspx_page_context) {
        con = (DB.ConnectionClass) _jspx_page_context.getAttribute("con", PageContext.PAGE_SCOPE);
        if (con == null){
          con = new DB.ConnectionClass();
          _jspx_page_context.setAttribute("con", con, PageContext.PAGE_SCOPE);
        }
      }
      out.write('\n');
      out.write('\n');
      DB.mailconnection ma = null;
      synchronized (_jspx_page_context) {
        ma = (DB.mailconnection) _jspx_page_context.getAttribute("ma", PageContext.PAGE_SCOPE);
        if (ma == null){
          ma = new DB.mailconnection();
          _jspx_page_context.setAttribute("ma", ma, PageContext.PAGE_SCOPE);
        }
      }
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Delivery Agent Requests</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            if(request.getParameter("acid")!=null){
                String up="update tbl_deliveryagent set da_status=1 where da_id='"+request.getParameter("acid")+"'";
                con.executeCommand(up);
                 String toAddress[]={request.getParameter("email")};
                    String subject="Registration Details From EDriver ";
                    String text=" Your registration Accepted.Please login";
                            boolean b=ma.sendMail(toAddress, subject, text);
                response.sendRedirect("DeliveryAgentList-New.jsp");
            }
            if(request.getParameter("reid")!=null){
                String up="update tbl_deliveryagent set da_status=2 where da_id='"+request.getParameter("reid")+"'";
                con.executeCommand(up);
                 String toAddress[]={request.getParameter("email")};
                    String subject="Registration Details From EDriver ";
                    String text=" Your registration Rejected";
                            boolean b=ma.sendMail(toAddress, subject, text);
                response.sendRedirect("DeliveryAgentList-New.jsp");
            }
            String sel ="select * from tbl_deliveryagent da inner join tbl_place pl on da.place_id=pl.place_id "
                       +"inner join tbl_district dis on pl.district_id=dis.district_id "
                       +"where da_status=0";
            ResultSet rs=con.selectCommand(sel);
            if(rs.next()){
        
      out.write("\n");
      out.write("        \n");
      out.write("        <table border=\"1\" style=\"border-collapse:collapse;\">\n");
      out.write("            \n");
      out.write("            <thead>\n");
      out.write("                <th>Sl.No</th>\n");
      out.write("                <th>Candidate Name</th>\n");
      out.write("                <th>DOB</th>\n");
      out.write("                <th>Address</th>\n");
      out.write("                <th>Place</th>\n");
      out.write("                <th>District</th>\n");
      out.write("                <th>Pincode</th>\n");
      out.write("                <th>Email</th>\n");
      out.write("                <th>Contact</th>\n");
      out.write("                <th>Candidate Photo</th>\n");
      out.write("                <th>Candidate Driving License</th>\n");
      out.write("                <th>Vehicle Proof</th>\n");
      out.write("                <th>Action</th>\n");
      out.write("            </thead>\n");
      out.write("        \n");
      out.write("            <tbody>\n");
      out.write("            ");

                int i=0;
                do{
                    i++;
            
      out.write("\n");
      out.write("                    <tr>\n");
      out.write("                        <td>");
      out.print(i);
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(rs.getString("da_name"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(rs.getString("da_dob") );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(rs.getString("da_address") );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(rs.getString("place_name") );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(rs.getString("district_name") );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(rs.getString("da_pincode") );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(rs.getString("da_email") );
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(rs.getString("da_contact") );
      out.write("</td>\n");
      out.write("                        <td><img src=\"../Assets/Delivery Agent/");
      out.print(rs.getString("da_photo") );
      out.write("\" width=\"80\" height=\"80\" alt=\"Candidate Photo\"></td>\n");
      out.write("                        <td><img src=\"../Assets/Delivery Agent/");
      out.print(rs.getString("da_drivlic") );
      out.write("\" width=\"80\" height=\"80\" alt=\"Driving License\"></td>\n");
      out.write("                        <td><img src=\"../Assets/Delivery Agent/");
      out.print(rs.getString("da_vehproof") );
      out.write("\" width=\"80\" height=\"80\" alt=\"Vehicle Proof\"></td>\n");
      out.write("                        <td><a href=\"DeliveryAgentList-New.jsp?acid=");
      out.print(rs.getString("da_id"));
      out.write("&email=");
      out.print(rs.getString("da_email"));
      out.write("\">Accept</a>/<a href=\"DeliveryAgentList-New.jsp?reid=");
      out.print(rs.getString("da_id"));
      out.write("&email=");
      out.print(rs.getString("da_email"));
      out.write("\">Reject</a></td>\n");
      out.write("                    </tr>\n");
      out.write("            ");

                }while(rs.next());
            
      out.write("\n");
      out.write("            </tbody>\n");
      out.write("            \n");
      out.write("        </table>\n");
      out.write("            \n");
      out.write("        ");

            }else{
        
      out.write("\n");
      out.write("        \n");
      out.write("        <h1>No records found..</h1>\n");
      out.write("        \n");
      out.write("        ");

            }
        
      out.write("\n");
      out.write("    </body>\n");
      out.write("    \n");
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
