import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Logger;

@WebServlet("/LogHours")
public class Loghours extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        int taskId =Integer.parseInt(request.getParameter("taskId"));
        int empNo = Integer.parseInt(request.getParameter("empNo"));
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        int hours = Integer.parseInt(request.getParameter("hours"));

        try {
            Class.forName("org.postgresql.Driver");
            try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project", "postgres", "Rajdr039*")) {
                    int existingHours = getExistingLogHours(connection, taskId);
                    int newHours = existingHours + hours;
                    updateLogHours(connection, taskId, newHours);
                
            }
            logger.info("Hours Logged sucessfully");
               response.sendRedirect("ViewTask.jsp?empno=" + request.getParameter("empNo"));
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
    }


    private int getExistingLogHours(Connection connection, int taskId) throws SQLException {
        String query = "SELECT loghours FROM task WHERE taskid = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, taskId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("loghours");
                }
            }
        }
        return 0;
    }

    private void updateLogHours(Connection connection, int taskId, int newHours) throws SQLException {
        String query = "UPDATE task SET loghours = ? WHERE taskid = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, newHours);
            preparedStatement.setInt(2, taskId);
            preparedStatement.executeUpdate();
        }
    }
}
