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

@WebServlet("/UpdateProject")
public class UpdateProject extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        String newStatus = request.getParameter("status");


        try {
            Class.forName("org.postgresql.Driver");

            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project","postgres", "Rajdr039*");
            String updateProjectQuery = "UPDATE project SET status = ? WHERE projectid = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(updateProjectQuery)) {
                preparedStatement.setString(1, newStatus);
                preparedStatement.setInt(2, projectId);
                preparedStatement.executeUpdate();
            }

            String updateTaskQuery = "UPDATE task SET status = ? WHERE projectid = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(updateTaskQuery)) {
                preparedStatement.setString(1, newStatus);
                preparedStatement.setInt(2, projectId);
                preparedStatement.executeUpdate();
            }
            connection.close();

            logger.info("ProjectID:"+projectId+" updated in sucessfully");

            response.sendRedirect("ManageProjects.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
