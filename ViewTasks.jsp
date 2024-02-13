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
    <title>View Tasks</title>
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
            color: #fff;
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
        .heading{
            display:flex;
            justify-content: space-between;
        }
       .heading .loggedhours{
            display:flex;
            text-align: right;
            border: 1px solid #4caf50;
            padding: 8px;
            border-radius: 4px;
            margin-right:20px;
            background-color: aliceblue;
        }
        body
        {
            background-image: linear-gradient(to left, #8bdbf3, #fac1ef);
        }
    </style>
</head>
<body>
<div class="heading">
    <h2>View Tasks</h2>

    <div class="loggedhours">
        <p>Total hours Logged for this project:<span id="Totalhours"></span></p>      
    </div>
</div>


<div id="dataContainer"></div>

<center><a href="ManageProjects.jsp">Back</a></center>

<script type="text/javascript">
    var totalhours=0;
    $(document).ready(function () {
        var projectId = '<%= request.getParameter("projectId") %>';
        

        $.ajax({
            url: "TaskData",
            type: "GET",
            dataType: "json",
            success: function (data) {
                var filteredTasks = data.filter(function (task) {
                    
                    return task.projectId == projectId;
                });

                displayData(filteredTasks);
                document.getElementById("Totalhours").innerHTML = totalhours;
                console.log(totalhours);
            },
            error: function (error) {
                console.log("Error fetching data: " + error);
            }
        });

        function displayData(data) {
            var container = $("#dataContainer");
            container.empty();

            if (data.length === 0) {
                container.append("<p>No tasks available for this project</p>");
            } else {
                var table = "<table border='1'><tr><th>Task ID</th><th>Task Name</th><th>Description</th><th>Status</th><th>Logged hours</th></tr>";
                for (var i = 0; i < data.length; i++) {
                    table += "<tr><td>" + data[i].taskId + "</td><td>" + data[i].taskName + "</td><td>" + data[i].description + "</td><td>" + data[i].status + "</td><td>" + data[i].loghours + "</td></tr>";
                    totalhours+=data[i].loghours;
                }
                table += "</table>";
                container.append(table);
            }
        }

      
        
    });
</script>

</body>
</html>
