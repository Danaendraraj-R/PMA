import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Logger;

@WebServlet("/Logout")
public class Logout extends HttpServlet {

    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {

            logger.info(session.getAttribute("username") +" Logged out sucessfully");

            session.setAttribute("username", null);
            session.setAttribute("email", null);
            session.setAttribute("role",null);
            session.setAttribute("empno",null);
            
            session.invalidate();
        }
        response.sendRedirect("Login.html");
    }
}
