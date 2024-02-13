import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Logger;


@WebServlet("/Login")
@SuppressWarnings("unchecked")
public class Login extends HttpServlet {
   
    private static final Logger logger = Logger.getLogger(Login.class.getName());

    public void doPost(HttpServletRequest req, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        String username = "username";
        String password = "password";
        String email = "email";
        String role = "users";
        int empno = 0;

        try {

            String user = req.getParameter("Email");
            String pass = req.getParameter("Password");

            Class.forName("org.postgresql.Driver");
            Connection conn = null;
            Statement stmt = null;
            conn = DriverManager
                    .getConnection("jdbc:postgresql://localhost:5432/project", "postgres", "Rajdr039*");
            int allow = 0;
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM USERS;");
            while (rs.next()) {
                email = rs.getString("email");
                password = rs.getString("password");
                role = rs.getString("role");
                empno = rs.getInt("empno");

                if (email.equals(user) && password.equals(pass)) {
                    if (role.equals("admin")) {
                        allow = allow + 2;
                    }
                     else if(role.equals("project-manager")) 
                    {
                        allow=allow+3;
                    }
                    else
                    {
                        allow++;
                    }

                    username = rs.getString("username");

                    byte[] imageData = rs.getBytes("image");

                    logger.info(username+" Logged in sucessfully");

                    HttpSession httpSession = req.getSession(true);
                    httpSession.setAttribute("email", email);
                    httpSession.setAttribute("username", username);
                    httpSession.setAttribute("role", role);
                    httpSession.setAttribute("empno", empno);
                    httpSession.setAttribute("avatar", imageData); 
                    break;
                }

            }
            rs.close();
            stmt.close();
            conn.close();
            if (allow == 1) {
                System.out.println("Login Successful!");
                response.sendRedirect("UserDashboard.jsp");
            } else if (allow == 2) {
                System.out.println("Login Successful!");
                response.sendRedirect("AdminDashboard.jsp");
            }
            else if (allow == 3) {
                System.out.println("Login Successful!");
                response.sendRedirect("PMDashboard.jsp");
            } else {
                response.sendRedirect("Error.jsp");
            }

        } catch (Exception e) {
            out.println(e);
        }
    }
}
