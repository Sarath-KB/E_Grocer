    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DB;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

/**
 *
 * @author ANOOP
 */
public class mailconnection {
    public synchronized static boolean sendMail(String[] to,String subject,String text){
            
            System.out.println("mail  "+to[0]+" "+subject+" "+text);
//String host="smtp.gmail.com";
String port="587";
String starttls="true";
String auth="true";
boolean debug=true;
String socketFactoryClass="javax.net.ssl.SSLSocketFactory";
String fallback="false";
String user="noreply.egrocerapp@gmail.com";
String pass="mindyourbusiness@haha";
            System.out.println("&&&&&&&&&&&&&&&&&&&\n\n\n\nHellooo Leo, insideemailsender....");
   
            
//            Properties props = new Properties();
//                //Properties props=System.getProperties();
//        props.put("mail.smtp.user", userName);
//        props.put("mail.smtp.host", host);
//                if(!"".equals(port))
//        props.put("mail.smtp.port", port);
//                if(!"".equals(starttls))
//        props.put("mail.smtp.starttls.enable",starttls);
//        props.put("mail.smtp.auth", auth);
//                if(debug){
//                props.put("mail.smtp.debug", "true");
//                }else{
//                props.put("mail.smtp.debug", "false");
//                }
//                if(!"".equals(port))
//        props.put("mail.smtp.socketFactory.port", port);
//                if(!"".equals(socketFactoryClass))
//        props.put("mail.smtp.socketFactory.class",socketFactoryClass);
//                if(!"".equals(fallback))
//        props.put("mail.smtp.socketFactory.fallback", fallback);

             Properties props = System.getProperties();
  String host = "smtp.gmail.com";

    props.put("mail.smtp.starttls.enable", "true");

    props.put("mail.smtp.ssl.trust", host);
    props.put("mail.smtp.user", user);
    props.put("mail.smtp.password", pass);
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");


    Session session = Session.getDefaultInstance(props);
    MimeMessage message = new MimeMessage(session);

            
      try {


        message.setFrom(new InternetAddress(user));
        InternetAddress[] toAddress = new InternetAddress[to.length];

        // To get the array of addresses
        for( int i = 0; i < to.length; i++ ) {
            toAddress[i] = new InternetAddress(to[i]);
        }

        for( int i = 0; i < toAddress.length; i++) {
            message.addRecipient(Message.RecipientType.TO, toAddress[i]);
        }



        message.setSubject(subject);
        message.setText(text);


        Transport transport = session.getTransport("smtp");


        transport.connect(host, user, pass);
        transport.sendMessage(message, message.getAllRecipients());
        transport.close();
        return true;
    }
    catch (AddressException ae) {
        ae.printStackTrace();
        return  false;
    }
    catch (MessagingException me) {
        me.printStackTrace();
        return  false;
    }
    }
}

    

