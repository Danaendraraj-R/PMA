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
    <title>Manage projects</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #1ba5f5;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #1ba5f5;
        }

        a {
            text-decoration: none;
            color: #fff;
            cursor: pointer;
            background-color: #1ba5f5;
            width: 120px;
            display: inline-block;
            text-align: center;
            padding: 8px;
        }
        .update-btn {
            background-color: rgb(246, 246, 79);
            color: #000; 
            width: 120px;
            display: inline-block;
            text-align: center;
            padding: 8px;
        }

        .delete-btn {
            background-color: rgb(250, 65, 65);
            color: #fff; 
            cursor: pointer;
            width: 120px;
            display: inline-block;
            text-align: center;
            padding: 8px;
        }

        .view-tasks-btn {
            background-color: #137e16;
            color: #fff;
        }
        .report-btn
        {
            background-color: #000;
            color: #fff;
        }
        body
        {
            background-image: linear-gradient(to left, #8bdbf3, #fac1ef);
        }
    </style>
</head>
<body>

<h2>Manage Projects</h2>

<div id="dataContainer"></div>

<center><a href="AdminDashboard.jsp">Back</a></center>

<script type="text/javascript">
    $(document).ready(function () {
        $.ajax({
            url: "ProjectData",
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
                var table = "<table border='1'><tr><th>Project ID</th><th>Project Name</th><th>Description</th><th>Status</th><th>View Tasks</th><th>Report</th><th>Update</th><th>Delete</th></tr>";
                for (var i = 0; i < data.length; i++) {
                    table += "<tr><td>" + data[i].projectId + "</td><td>" + data[i].projectName + "</td><td>" + data[i].description + "</td><td>" + data[i].status + "</td>" +
                        "<td><a class='view-tasks-btn' href='ViewTasks.jsp?projectId=" + data[i].projectId + "'>View Tasks</a></td>" +
                        "<td><a class='report-btn' href='ViewReports.jsp?projectId="+data[i].projectId + "'>View Report</a></td> " +
                        "<td><button class='update-btn' onclick=\"updateProject('" + data[i].projectId + "','" + data[i].projectName + "','" + data[i].status + "')\">Update</button></td> "+
                        "<td><button class='delete-btn' onclick='deleteProject(" + data[i].projectId + ")'>Delete</button></td></tr>"
                }
                table += "</table>";
                container.append(table);
            }
        }




    });

function updateProject(projectId,projectName,status) {
    window.location.href = "UpdateProject.jsp?projectId=" + projectId + "&projectName=" + projectName + "&status=" + status;
}

function deleteProject(projectId) {

var isConfirmed = confirm("Are you sure you want to delete this blog?");

$.ajax({
    type: "GET",
    url: "DeleteProject?projectId=" + projectId,
    success: function () {
        location.reload();
    },
    error: function (error) {
        console.log("Error:", error);
    }
});

}
</script>

</body>
</html>
