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
    <title>Student Data</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #4caf50;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #4caf50;
        }

        a {
            text-decoration: none;
            color: #fff;
            cursor: pointer;
            background-color: #4caf50;
            width: 120px;
            display: inline-block;
            text-align: center;
            padding: 8px;
        }
        .update-btn {
            background-color: rgb(246, 246, 79);
            color: #000; 
        }

        .delete-btn {
            background-color: rgb(250, 65, 65);
            color: #fff; 
        }
    </style>
</head>
<body>

<h2>View Users</h2>

<div id="dataContainer"></div>

<center><a href="AdminDashboard.jsp">Back</a></center>

<script type="text/javascript">
    $(document).ready(function () {
        $.ajax({
            url: "ViewUsers",
            type: "GET",
            dataType: "json",
            success: function (data) {
                displayData(data);
            },
            error: function (error) {
                console.log("Error fetching data: " + error);
            }
        });

        function displayData(data) {
            var container = $("#dataContainer");
            container.empty();

            if (data.length === 0) {
                container.append("<p>No data available</p>");
            } else {
                var table = "<table border='1'><tr><th>Emp No</th><th>Username</th><th>Email</th><th>Role</th></tr>";
                for (var i = 0; i < data.length; i++) {
                    table += "<tr><td>" + data[i].empno + "</td><td>" + data[i].name + "</td><td>" + data[i].email + "</td><td>" + data[i].role + "</td></tr>";
                }
                table += "</table>";
                container.append(table);
            }
        }

    });
</script>

</body>
</html>
