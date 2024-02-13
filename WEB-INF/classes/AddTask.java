import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.logging.Logger;

@WebServlet("/AddTask")
public class AddTask extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project",
                "postgres", "Rajdr039*")) {

            String projectId = request.getParameter("ProjectId");
            String userId = request.getParameter("userId");
            String taskName = request.getParameter("taskName");
            String taskDescription = request.getParameter("taskDescription");
            String taskDeadlineString = request.getParameter("taskDeadline");
            String email=null;
            String username=null;

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date taskDeadline = dateFormat.parse(taskDeadlineString);
            java.sql.Date sqlDeadline = new java.sql.Date(taskDeadline.getTime());

            String query = "INSERT INTO task (projectid, empno, taskname, description, deadline, status) VALUES (?, ?, ?, ?, ?, ?)";
            String query1="SELECT EMAIL,USERNAME FROM users WHERE empno=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, Integer.parseInt(projectId));
                preparedStatement.setInt(2, Integer.parseInt(userId));
                preparedStatement.setString(3, taskName);
                preparedStatement.setString(4, taskDescription);
                preparedStatement.setDate(5, sqlDeadline);
                preparedStatement.setString(6, "In-Progress");

                preparedStatement.executeUpdate();
                logger.info(taskName+" created in sucessfully");

            }
            try(PreparedStatement preparedStatement = connection.prepareStatement(query1))
            {
             preparedStatement.setInt(1,Integer.parseInt(userId));   
             ResultSet resultSet = preparedStatement.executeQuery();
             while (resultSet.next()) {
                    email=resultSet.getString("email");
                    username=resultSet.getString("username");
                }
            }
            catch(Exception e)
            {
                System.out.println(e);
            }

            sendMail(taskName,taskDescription,sqlDeadline,email,username);

            response.sendRedirect("AdminDashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
    public void sendMail(String taskName, String taskDescription,java.sql.Date Date,String email,String username)
    {
        String to = email; 

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


        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Task Assigned for you- Reg");
            message.setText("Hello "+ username + ", this is a automated mail sent from Admin to inform you that you have been assigned with a task.The task details are mentioned below \nTask name:"+taskName+"\nTask Decription:"+taskDescription+"\nTask Deadline:"+ Date);
            Transport.send(message);

            System.out.println("Email sent Successfully");
            logger.info("Email sent to "+from+" sucessfully");

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
