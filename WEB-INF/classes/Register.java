import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;

import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Logger;

@WebServlet("/Register")
public class Register extends HttpServlet {

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

            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project", "postgres", "Rajdr039*");
            System.out.println("connection successful");
            int lastEmpNo = getLastEmpNo(conn);
            int newEmpNo = lastEmpNo + 1;

            PreparedStatement st = conn.prepareStatement("insert into users(EMPNO, USERNAME, EMAIL, PASSWORD, ROLE) values(?, ?, ?, ?, ?)");
            st.setInt(1, newEmpNo);
            st.setString(2, request.getParameter("Username"));
            st.setString(3, request.getParameter("Email"));
            st.setString(4, request.getParameter("Password"));
            st.setString(5, "user");
            st.executeUpdate();

            logger.info(request.getParameter("Username") +" registered as user sucessfully");

            st.close();
            conn.close();
            response.sendRedirect("index.html");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private int getLastEmpNo(Connection conn) {
        int lastEmpNo = 0;
        try {
            PreparedStatement getLastEmpNoStatement = conn.prepareStatement("SELECT MAX(EMPNO) FROM users");
            ResultSet resultSet = getLastEmpNoStatement.executeQuery();
            if (resultSet.next()) {
                lastEmpNo = resultSet.getInt(1);
            }
            getLastEmpNoStatement.close();
        } catch (Exception e) {
            System.out.println("Error getting last EMPNO: " + e);
        }
        return lastEmpNo;
    }
}
