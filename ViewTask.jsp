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
    <title>View Tasks</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.3.0/papaparse.min.js"></script>
    <style>
        body
        {
            background-image: linear-gradient(to left, #8bdbf3, #fac1ef);
        }
        .task-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .task-column {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            border-radius: 5px;
            min-height: 100px;
        }

        .task-card {
            border: 1px solid #4caf50;
            padding: 10px;
            margin: 10px 0;
            background-color: #fff;
            border-radius: 5px;
            cursor: move;
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

        .task-card {
            border: 1px solid #4caf50;
            padding: 10px;
            margin: 10px;
            width: 300px;
            display: inline-block;
            vertical-align: top;
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

        button {
            background-color: rgb(204, 156, 26);
            color: #000;
            cursor: pointer;
            width: 120px;
            display: inline-block;
            text-align: center;
            padding: 8px;
            border: 1px;
        }
    .btn-container{
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .button-container {
        display: flex;
    }

    .button-container button {
        margin-right: 10px;
        background-color: darkcyan;
    }

    .export-container button {
        margin-left: 10px;
        background-color: darkred;
        color:#f9f9f9;
    }
    .search-container button {
        margin-left: 10px;
        background-color: rgb(23, 14, 83);
        color:#f9f9f9;
    }
    .search-container{
        display:flex;
    }
    


    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jspdf-autotable@3.7.0/dist/jspdf.plugin.autotable.js"></script>
    

</head>
<body>

<h2>View Tasks</h2>

<div class="btn-container">
<div class="button-container">
    <button onclick="showTableFormat()">Table View</button>
    <button onclick="showCardFormat()">Card View</button>
</div>

    <div class="export-container">
        <button onclick="exportToPDF()">Export to PDF</button>
        <button onclick="exportToExcel()">Export to Excel</button>
        <button onclick="exportToCSV()">Export to CSV</button>
    </div>
</div>

<div class="search-container">
    <input type="text" id="searchInput" placeholder="Search tasks...">
    <button onclick="searchTasks()">Search</button>
    <div class="manual-filter-sort-container">
        <button onclick="applySort()">Apply Sort</button>
  </div>
</div>





<div id="tableContainer"></div>

<div class="task-container" id="cardContainer">
    <div class="task-column" id="inProgressColumn">
        <h3>In Progress</h3>
        <div class="task-cards" id="inProgressCards"></div>
    </div>
    <div class="task-column" id="completedColumn">
        <h3>Completed</h3>
        <div class="task-cards" id="completedCards"></div>
    </div>
</div>

<center><a href="UserDashboard.jsp">Back</a></center>

<script type="text/javascript">
    $(document).ready(function () {
        var empno = '<%= session.getAttribute("empno") %>';
        var empname = '<%= session.getAttribute("username") %>';
         console.log(empname);
        
        var data;
        var filteredTasks;

        $.ajax({
            url: "TaskData",
            type: "GET",
            dataType: "json",
            success: function (responsedata) {
                filteredTasks = responsedata.filter(function (task) {
                    return task.empNo == empno;
                });
                data=filteredTasks;

                displayTableData(filteredTasks);
                displayCardData(filteredTasks);

            },
            error: function (error) {
                console.log("Error fetching data: " + error);
            }
        });


        window.exportToExcel = function () {
            var ws = XLSX.utils.json_to_sheet(filteredTasks);
            var wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, 'Filtered Tasks');
            XLSX.writeFile(wb, 'tasks.xlsx');
        };

        window.exportToCSV = function () {
            var csv = Papa.unparse(filteredTasks);
            var blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
            var link = document.createElement("a");
            var url = URL.createObjectURL(blob);
            link.setAttribute("href", url);
            link.setAttribute("download", "tasks.csv");
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        };

        window.exportToPDF = function () {
        var doc = new jspdf.jsPDF();

        doc.text("Tasks assigned for "+empname, 14, 10);
        var headers = ["Task ID", "Task Name", "Description", "Status", "Deadline" ];
        var yPosition = 20;
        doc.autoTable({
        startY: yPosition,
        head: [headers],
        body: filteredTasks.map(task => [task.taskId, task.taskName, task.description, task.status, task.deadline]),
        });
        doc.save('tasks.pdf');
        };


        function displayTableData(data) {
            var tableContainer = $("#tableContainer");
            tableContainer.empty();

            if (data.length === 0) {
                tableContainer.append("<p>No tasks available for this project</p>");
            } else {
                var table = "<table border='1'><tr><th>Task ID</th><th>Task Name</th><th>Description</th><th>Status</th><th>Deadline</th><th>Logged Hours</th><th>Actions</th><th>Time Log</th></tr>";
                for (var i = 0; i < data.length; i++) {
                    table += "<tr><td>" + data[i].taskId + "</td><td>" + data[i].taskName + "</td><td>" + data[i].description + "</td><td>" + data[i].status + "</td><td>" + data[i].deadline + "</td><td>" + data[i].loghours + "</td>";
                    table += "<td><button onclick='openUpdateTaskForm(" + data[i].taskId + ", \"" + data[i].taskName + "\", \"" + data[i].status + "\")'>Update Task</button></td>";
                    table += "<td><button onclick='logHours(" + data[i].taskId +","+data[i].projectId+","+data[i].empNo+ ")'>Log Hours</button></td></tr>";
                }
                table += "</table>";
                tableContainer.append(table);
            }
        }

        function displayCardData(data) {
            var inProgressCards = $("#inProgressCards");
            var completedCards = $("#completedCards");

            inProgressCards.empty();
            completedCards.empty();

            if (data.length === 0) {
                inProgressCards.append("<p>No tasks available for this project</p>");
                completedCards.append("<p>No tasks available for this project</p>");
            } 
            else {
                for (var i = 0; i < data.length; i++) {
                    var card = "<div class='task-card' data-task-id='" + data[i].taskId + "' data-task-name='" + data[i].taskName + "' data-status='" + data[i].status + "'>";
                    card += "<h4>Task ID: " + data[i].taskId + "</h4><p>Task Name: " + data[i].taskName + "</p><p>Description: " + data[i].description + "</p><p>Status: " + data[i].status + "</p>";
                    card += "<button onclick='openUpdateTaskForm(" + data[i].taskId + ", \"" + data[i].taskName + "\", \"" + data[i].status + "\")'>Update Task</button>";
                    card += "<button onclick='logHours(" + data[i].taskId +","+data[i].projectId +","+data[i].empNo+")'>Log Hours</button></div>";

                    if (data[i].status === "In-Progress") {
                        inProgressCards.append(card);
                    } else if (data[i].status === "Completed") {
                        completedCards.append(card);
                    }
                }

        inProgressCards.sortable({
            placeholder: "task-card-placeholder",
            forcePlaceholderSize: true,
            tolerance: "pointer",
            revert: 150,
            cursor: "move"
        });

           completedCards.sortable({
            placeholder: "task-card-placeholder",
            forcePlaceholderSize: true,
            tolerance: "pointer",
            revert: 150,
            cursor: "move"
        });

            }
        }

        window.showTableFormat = function () {
            $("#tableContainer").show();
            $("#cardContainer").hide();
        };

        window.showCardFormat = function () {
            $("#tableContainer").hide();
            $("#cardContainer").show();
        };

        window.searchTasks = function () {
            var searchTerm = $("#searchInput").val().toLowerCase();

            var filteredTasks = data.filter(function (task) {
                return (
                    task.taskName.toLowerCase().includes(searchTerm) ||
                    task.description.toLowerCase().includes(searchTerm) ||
                    task.status.toLowerCase().includes(searchTerm)
                );
            });

            displayTableData(filteredTasks);
            displayCardData(filteredTasks);
        };

        var isSortAscending = true; 


              window.applySort = function () {
                isSortAscending = !isSortAscending;
                var sortedTasks = data.sort(function (a, b) {
                 return isSortAscending ? a.taskId - b.taskId : b.taskId - a.taskId;
              });

              displayTableData(sortedTasks);
              displayCardData(sortedTasks);
               };


        
        showTableFormat();
    });

            window.logHours = function (taskId,projectId,empNo) {
            var logHoursUrl = "Loghours.jsp?taskId=" + taskId + "&empNo=" + empNo + "&projectId=" + projectId;
            window.location.href = logHoursUrl;
            };

</script>


<script type="text/javascript">
            function openUpdateTaskForm(taskId, taskName, status) {
                    window.location.href = "UpdateTask.jsp?taskId=" + taskId + "&taskName=" + encodeURIComponent(taskName) + "&status=" + encodeURIComponent(status);
            }
</script>

</body>
</html>

