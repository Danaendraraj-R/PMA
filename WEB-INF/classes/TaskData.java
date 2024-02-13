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

@WebServlet("/TaskData")
public class TaskData extends HttpServlet {

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

            String query = "SELECT * FROM task";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                    ResultSet resultSet = preparedStatement.executeQuery()) {

                List<Task> tasks = new ArrayList<>();

                while (resultSet.next()) {
                    Task task = new Task();
                    task.setTaskId(resultSet.getInt("taskid"));
                    task.setTaskName(resultSet.getString("taskname"));
                    task.setDescription(resultSet.getString("description"));
                    task.setStatus(resultSet.getString("status"));
                    task.setEmpNo(resultSet.getInt("empno"));
                    task.setDeadline(resultSet.getDate("deadline"));
                    task.setProjectId(resultSet.getInt("projectid"));
                    task.setLoghours(resultSet.getInt("loghours"));

                    tasks.add(task);
                }

                
                StringBuilder jsonBuilder = new StringBuilder("[");
                for (Task task : tasks) {
                    jsonBuilder.append(task.toJsonString()).append(",");
                }
                if (tasks.size() > 0) {
                    jsonBuilder.deleteCharAt(jsonBuilder.length() - 1);
                }
                jsonBuilder.append("]");

                try (PrintWriter out = response.getWriter()) {
                    out.print(jsonBuilder.toString());
                    out.flush();
                }
                logger.info(" Task Data fetched sucessfully");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static class Task {
        private int taskId;
        private String taskName;
        private String description;
        private String status;
        private int empNo;
        private java.sql.Date deadline;
        private int projectId;
        private int loghours;

            public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
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

    public int getEmpNo() {
        return empNo;
    }

    public void setEmpNo(int empNo) {
        this.empNo = empNo;
    }

    public int getLoghours() {
        return loghours;
    }

    public void setLoghours(int loghours) {
        this.loghours = loghours;
    }

    public java.sql.Date getDeadline() {
        return deadline;
    }

    public void setDeadline(java.sql.Date deadline) {
        this.deadline = deadline;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

        public String toJsonString() {
            return String.format(
                    "{\"taskId\":%d,\"taskName\":\"%s\",\"description\":\"%s\",\"status\":\"%s\",\"empNo\":%d,\"deadline\":\"%s\",\"projectId\":%d,\"loghours\":%d}",
                    taskId, taskName, description, status, empNo, deadline, projectId, loghours);
        }
    }
}
