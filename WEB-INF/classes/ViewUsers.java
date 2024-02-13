import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Logger;

@WebServlet("/ViewUsers")
public class ViewUsers extends HttpServlet {

    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        List<Data> dataList = new ArrayList<>();

        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project",
                    "postgres", "Rajdr039*");
            String sql = "SELECT * FROM users WHERE role <> 'admin'";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int empno = resultSet.getInt("empno");
                String username = resultSet.getString("username");
                String email = resultSet.getString("email");
                String role = resultSet.getString("role");

                Data data = new Data(empno, username, email, role);
                dataList.add(data);
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        StringBuilder jsonBuilder = new StringBuilder("[");
        for (int i = 0; i < dataList.size(); i++) {
            Data data = dataList.get(i);
            jsonBuilder.append("{")
                    .append("\"name\":\"").append(data.getName()).append("\",")
                    .append("\"empno\":\"").append(data.getEmpno()).append("\",")
                    .append("\"email\":\"").append(data.getEmail()).append("\",")
                    .append("\"role\":\"").append(data.getRole()).append("\"")
                    .append("}");
            if (i < dataList.size() - 1) {
                jsonBuilder.append(",");
            }
        }
        jsonBuilder.append("]");
        String json = jsonBuilder.toString();

        out.println(json);
        logger.info("User Details sucessfully");
    }

    private static class Data {
        private String username;
        private String email;
        private String role;
        private int empno;

        public Data(int empno, String username, String email, String role) {
            this.username = username;
            this.empno = empno;
            this.email = email;
            this.role = role;
        }

        public String getName() {
            return username;
        }

        public int getEmpno() {
            return empno;
        }

        public String getRole() {
            return role;
        }

        public String getEmail() {
            return email;
        }
    }
}
