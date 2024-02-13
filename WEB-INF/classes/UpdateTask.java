import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Logger;

@WebServlet("/UpdateTask")
public class UpdateTask extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        String newStatus = request.getParameter("status");

        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project","postgres","Rajdr039*");
            String updateQuery = "UPDATE task SET status = ? WHERE taskid = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {
                preparedStatement.setString(1, newStatus);
                preparedStatement.setInt(2, taskId);
                preparedStatement.executeUpdate();
            }
            connection.close();
            logger.info("TaskID:"+taskId+" updated sucessfully");
            response.sendRedirect("ViewTask.jsp?empno=" + request.getParameter("empno"));
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
