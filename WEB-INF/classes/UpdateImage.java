import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.*;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.logging.Logger;

@WebServlet("/UpdateAvatar")
@MultipartConfig
public class UpdateImage extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        int empno=(int)session.getAttribute("empno");

        if (username == null || role == null) {
            response.sendRedirect("Login.html");
            return;
        }

        Part filePart = request.getPart("avatar");

        byte[] imageData = getByteArrayFromInputStream(filePart.getInputStream());

        if (imageData != null) {
            updateUserAvatar(empno, imageData);
        }

        logger.info("Profile Image for "+username+" updated sucessfully");

        session.setAttribute("avatar", imageData); 
        response.sendRedirect("Profile.jsp");
    }

    private byte[] getByteArrayFromInputStream(InputStream inputStream) throws IOException {
        try {
            byte[] buffer = new byte[inputStream.available()];
            inputStream.read(buffer);
            return buffer;
        } finally {
            inputStream.close();
        }
    }

    private void updateUserAvatar(int empno, byte[] imageData) {
        String updateQuery = "UPDATE users SET image = ? WHERE empno = ?";

        try (
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project", "postgres","Rajdr039*");
            PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
        ) {
            preparedStatement.setBytes(1, imageData);
            preparedStatement.setInt(2, empno);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
