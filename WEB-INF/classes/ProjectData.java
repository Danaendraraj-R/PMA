import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Logger;

@WebServlet("/ProjectData")
public class ProjectData extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(Login.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project",
                "postgres", "Rajdr039*")) {

            String query = "SELECT * FROM project";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                    ResultSet resultSet = preparedStatement.executeQuery()) {

                List<Project> projects = new ArrayList<>();

                while (resultSet.next()) {
                    Project project = new Project();
                    project.setProjectId(resultSet.getInt("projectid"));
                    project.setProjectName(resultSet.getString("projectname"));
                    project.setDescription(resultSet.getString("description"));
                    project.setStatus(resultSet.getString("status"));

                    projects.add(project);
                }

                // Convert projects to JSON using StringBuilder
                StringBuilder jsonBuilder = new StringBuilder("[");
                for (Project project : projects) {
                    jsonBuilder.append(project.toJsonString()).append(",");
                }
                if (projects.size() > 0) {
                    jsonBuilder.deleteCharAt(jsonBuilder.length() - 1); 
                }
                jsonBuilder.append("]");

                try (PrintWriter out = response.getWriter()) {
                    out.print(jsonBuilder.toString());
                    out.flush();
                }

                logger.info("Project Data fetched sucessfully");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static class Project {
        private int projectId;
        private String projectName;
        private String description;
        private String status;

        public Project() {
       
        }


        public int getProjectId() {
            return projectId;
        }

        public void setProjectId(int projectId) {
            this.projectId = projectId;
        }

        public String getProjectName() {
            return projectName;
        }

        public void setProjectName(String projectName) {
            this.projectName = projectName;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String toJsonString() {
            return String.format("{\"projectId\":%d,\"projectName\":\"%s\",\"description\":\"%s\",\"status\":\"%s\"}",
                    projectId, projectName, description, status);
        }
    }
}
