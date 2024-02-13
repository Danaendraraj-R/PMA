import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Logger;

@WebServlet("/AddProject")
public class AddProject extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Class not found " + e);
        }

        try {
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project", "postgres",
                    "Rajdr039*");
            System.out.println("connection successful");
            PreparedStatement st = conn.prepareStatement(
                    "insert into project(PROJECTNAME, DESCRIPTION, STATUS) values(?, ?, ?)");
            st.setString(1, request.getParameter("ProjectName"));
            st.setString(2, request.getParameter("Description"));
            st.setString(3, "In-Progress");
            st.executeUpdate();

            logger.info("Project created sucessfully");

            st.close();
            conn.close();
            response.sendRedirect("AdminDashboard.jsp");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
