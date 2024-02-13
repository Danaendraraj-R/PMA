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
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Task</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<style>
    body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    background-image: linear-gradient(to left, #8811d1, #fac1ef);
}

form {
    background-color:transparent;
    padding: 20px;
    border-radius: 20px;
    border: 1px solid black;
    box-shadow: 20px 20px 20px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    width: 300px;
}

h2 {
    text-align: center;
    color: whitesmoke;
}

label {
    display: block;
    margin: 10px 0 5px;
    color: whitesmoke;
}

input, select {
    width: calc(100% - 12px);
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type=submit] {
    width: 100%;
    padding: 10px;
    background-color: #4caf50;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}

a{
    color: black;
}

</style>
<body>

<h2>Update Task</h2>

<form id="updateTaskForm" action="UpdateTask" method="post">
    <label for="taskId">Task ID:</label>
    <input type="hidden" id="empno" name="empno" value="<%= session.getAttribute("empno") %>" readonly><br>
    <input type="text" id="taskId" name="taskId" readonly><br>

    <label for="taskName">Task Name:</label>
    <input type="text" id="taskName" name="taskName" readonly><br>

    <label for="status">Status:</label>
    <select id="status" name="status">
        <option value="In-Progress">In-Progress</option>
        <option value="Completed">Completed</option>
    </select><br>

    <input type="submit" value="Update Task">
</form>

<script type="text/javascript">
        $(document).ready(function () {
        var urlParams = new URLSearchParams(window.location.search);
        var taskId = urlParams.get("taskId");
        var taskName = urlParams.get("taskName");
        var status = urlParams.get("status");

        setTaskDetails(taskId, taskName, status);
    })

    function setTaskDetails(taskId, taskName, status) {
        $("#taskId").val(taskId);
        $("#taskName").val(taskName);
        $("#status").val(status);
    }
</script>

</body>
</html>
