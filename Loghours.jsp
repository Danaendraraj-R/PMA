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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Log Hours</title>
    <!-- Add your styles and scripts if needed -->
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

input {
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

<h2>Log Hours</h2>

<form action="LogHours" method="post">
    <input type="hidden" name="taskId" value="${param.taskId}">
    <input type="hidden" name="empNo" value="${param.empNo}">
    <input type="hidden" name="projectId" value="${param.projectId}">

    <p>Task ID: ${param.taskId}</p>
    <p>Employee Number: ${param.empNo}</p>
    <p>Project ID: ${param.projectId}</p>

    <label for="hours">Hours:</label>
    <input type="text" id="hours" name="hours" required>

    <input type="submit" value="Log Hours">
</form>


</body>
</html>
