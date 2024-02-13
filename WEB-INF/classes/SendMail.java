import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

@WebServlet("/SendMail")
public class SendMail extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String to = "danaendraraj5@gmail.com"; 

        final String from = "aproject487@gmail.com"; 
        final String password = "tkxy fkcy xoju jnjd"; 

        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com"); 
        properties.put("mail.smtp.port", "587"); 

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Task Assigned for you- Reg");
            message.setText("Hello, this is a automated mail sent from Admin to inform you that you have been assigned with a task.The task details are mentioned below");
            Transport.send(message);

            out.println("<html><body>");
            out.println("<h2>Email sent successfully</h2>");
            out.println("</body></html>");
        } catch (MessagingException e) {
            throw new ServletException("Could not send email.", e);
        }
    }
}
