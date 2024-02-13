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
    <title>Pie Chart</title>
    <style>
       body{
            background-image: linear-gradient(to left,#f0e065,#f572ffe2);
    }
    #chartContainer {
    margin-top: 200px;    
    background-color:transparent;
    padding: 20px;
    border-radius: 20px;
    border: 1px solid black;
    box-shadow: 20px 20px 20px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    width: 300px;
    }

        #pieChartContainer {
            position: relative;
            width: 200px;
            height: 200px;
            margin: 20px auto;
            background: conic-gradient(
                #9d04b8 0%,
                #9d04b8 var(--completedPercentage),
                #e3c30d var(--completedPercentage),
                #e3c30d 100%
            );
            border-radius: 50%;
        }

        #taskInfo {
            margin-top: 20px;
            font-family: Arial, sans-serif;
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
        #chartContainer{
            background-color:#fff;
        }
        body{
            background-image: linear-gradient(to left, #8bdbf3, #fac1ef);
        }
        .Completed{
            height:20px;
            width:20px;
            background-color: #9d04b8;

        }
        .In-Progress{
            height:20px;
            width:20px;
            background-color:#e3c30d;

        }
        ul{
            list-style-type: none;
        }
        .Legend{
            display:flex;
            margin-left:30px;
            width:110px;
            justify-content: space-between;
        }

        
    </style>
</head>
<body>
<center>
<div id="chartContainer">
    <h2>Task Progress</h2>
    <div id="pieChartContainer"></div>

        <div class="Legend"><div class="Completed"></div>Completed </div>
        <br>
        <div class="Legend"> <div class="In-Progress"></div>In-Progress </div>
        <br>
    

    <table>
        <tr>
            <td>Total number of Task Assigned:  </td>
            <td> <div id="Totaltask"></div> </td>
        </tr>
        <tr>
            <td> Total number of Task Completed: </td>
            <td>  <div id="Completedtask"></div></td>
        </tr>
    </table>
    
    
</div>
<a href="UserDashboard.jsp">Back</a>
</center>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    $(document).ready(function () {
        var empno = '<%= session.getAttribute("empno") %>';

        $.ajax({
            url: "TaskData",
            type: "GET",
            dataType: "json",
            success: function (data) {
                var filteredTasks = data.filter(function (task) {
                    return task.empNo == empno;
                });

                var totalTasks = filteredTasks.length;
                var completedTasks = filteredTasks.filter(function (task) {
                    return task.status === 'Completed';
                }).length;

                var completedPercentage = (completedTasks / totalTasks) * 100;

                
                $("#pieChartContainer").css("--completedPercentage", completedPercentage + "%");

                document.getElementById("Totaltask").innerHTML = totalTasks;
                document.getElementById("Completedtask").innerHTML = completedTasks;
            
            },
            error: function (error) {
                console.log("Error fetching data: " + error);
            }
        });
    });
</script>

</body>
</html>
