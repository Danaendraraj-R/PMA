<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Log Hours Analytics</title>
    <style>
        #chartContainer {
            margin-top: 20px;
            background-color: transparent;
            padding: 20px;
            border-radius: 20px;
            border: 1px solid black;
            box-shadow: 20px 20px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            width: 300px;
        }

        #barChartContainer {
            width: 400px;
            height: 300px;
            margin: 20px auto;
        }

        #logHoursInfo {
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
    </style>
    <!-- Include Chart.js library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <center>
        <div id="chartContainer">
            <h2>Log Hours Analytics</h2>
            <div id="barChartContainer">
                <canvas id="myBarChart"></canvas>
            </div>

            <table>
                <tr>
                    <td>Total Hours Logged in Project:</td>
                    <td><div id="TotalHoursLogged"></div></td>
                </tr>
            </table>
        </div>
        <a href="ManageProjects.jsp">Back</a>
    </center>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            var projectId = '<%= request.getParameter("projectId") %>';

            $.ajax({
                url: "TaskData",
                type: "GET",
                dataType: "json",
                success: function (data) {
                    var taskData = data.tasks;
                    var logHoursData = data.logHours;

                    
                    var totalHoursLogged = logHoursData.reduce(function (acc, log) {
                        return acc + log.hoursLogged;
                    }, 0);

                    $("#barChartContainer").css("--completedPercentage", completedPercentage + "%");
                    document.getElementById("TotalHoursLogged").innerHTML = totalHoursLogged;

                    var ctxBar = document.getElementById('myBarChart').getContext('2d');
                    var myBarChart = new Chart(ctxBar, {
                        type: 'bar',
                        data: {
                            labels: ['Total Hours Logged in Project'],
                            datasets: [{
                                label: 'Log Hours Analytics',
                                data: [totalHoursLogged],
                                backgroundColor: ['rgba(255, 99, 132, 0.2)'],
                                borderColor: ['rgba(255, 99, 132, 1)'],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                },
                error: function (error) {
                    console.log("Error fetching data: " + error);
                }
            });
        });
    </script>
</body>
</html>
