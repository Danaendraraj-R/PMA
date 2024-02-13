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

@WebServlet("/DeleteProject")
public class DeleteProject extends HttpServlet {

    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int projectId =Integer.parseInt(request.getParameter("projectId"));
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project","postgres", "Rajdr039*");
            String sql = "DELETE FROM project WHERE projectid = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, projectId);
                statement.executeUpdate();
            }
            logger.info("ProjectID:"+projectId+" Deleted sucessfully");
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }


        response.sendRedirect("ManageProjects.jsp");
    }

}
