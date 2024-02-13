<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Retrieve values from the session
String email = (String) session.getAttribute("email");
String username = (String) session.getAttribute("username");
String role=(String) session.getAttribute("role");

if (email == null || username == null) {
    response.sendRedirect("Login.html");
}
else if(role.equals("user"))
{
    response.sendRedirect("UserDashboard.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Project</title>
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
        background-color: transparent;
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

    a {
        color: black;
    }
</style>
<body>

<h2>Update Project</h2>

<form id="updateProjectForm" action="UpdateProject" method="post">
    <label for="projectId">Project ID:</label>
    <input type="text" id="projectId" name="projectId" readonly><br>

    <label for="projectName">Project Name:</label>
    <input type="text" id="projectName" name="projectName" readonly><br>

    <label for="status">Status:</label>
    <select id="status" name="status">
        <option value="In-Progress">In-Progress</option>
        <option value="Completed">Completed</option>
    </select><br>

    <input type="submit" value="Update Project">
</form>

<script type="text/javascript">
    $(document).ready(function () {
        var urlParams = new URLSearchParams(window.location.search);
        var projectId = urlParams.get("projectId");
        var projectName = urlParams.get("projectName");
        var status = urlParams.get("status");

        setProjectDetails(projectId, projectName, status);
    })

    function setProjectDetails(projectId, projectName, status) {
        $("#projectId").val(projectId);
        $("#projectName").val(projectName);
        $("#status").val(status);
    }
</script>

</body>
</html>
