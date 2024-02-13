<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Retrieve values from the session
String email = (String) session.getAttribute("email");
String username = (String) session.getAttribute("username");
String role=(String) session.getAttribute("role");

if (email == null || username == null) {
    response.sendRedirect("Login.html");
}
else if(role.equals("admin"))
{
    response.sendRedirect("AdminDashboard.jsp");
}
else if(role.equals("project-manager")) 
{
  response.sendRedirect("PMDashboard.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Task</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .task-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #4caf50;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-top: 10px;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }
        a{
            color:black;
        }
        body{
            background-image: linear-gradient(to left,#f74049,#f8a7cb);
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <script>
        $(document).ready(function() {
            
            function fetchProjects() {
                $.ajax({
                    url: "ProjectData", 
                    type: "GET",
                    dataType: "json",
                    success: function(data) {
                        var selectField = $("#ProjectId");
                        selectField.empty();
                        $.each(data, function(projectId, data) {
                            selectField.append("<option value='" + data.projectId + "'>" + data.projectName + "</option>");
                        });
                    },
                    error: function(error) {
                        console.log("Error fetching users: " + error);
                    }
                });
            }
            fetchProjects();
        });
    </script>
</head>
<body>

<div class="task-container">
    <h2>Add Task</h2>

    <form action="AddTask" method="post">
        <label>Select Project:</label>
        <select name="ProjectId" id="ProjectId" required>
        </select>

        <label>User ID</label>
        <input type="text" id="userId" name="userId" value='<%= session.getAttribute("empno") %>' readonly>

        
        <label>User Name</label>
        <input type="text" id="username" value='<%= session.getAttribute("username") %>' readonly>

        <label>Task Name:</label>
        <input type="text" name="taskName" required>

        <label>Task Description:</label>
        <input type="text" name="taskDescription" required>

        <label>Task Deadline:</label>
        <input type="date" name="taskDeadline" required>

        <button type="submit">Add Task</button>
    </form>
<br>
    <a href="UserDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>
