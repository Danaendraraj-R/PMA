<%@ page import="javax.xml.bind.DatatypeConverter" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Base64" %>

<%
// Retrieve values from the session
String email = (String) session.getAttribute("email");
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
byte[] avatarData = (byte[]) session.getAttribute("avatar");


if (email == null || username == null || role == null) {
    response.sendRedirect("Login.html");
}


%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
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

        .profile-container {
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

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #4caf50;
            color: #fff;
        }

        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-top: 10px;
        }

        p {
            margin: 5px 0;
            color: #666;
        }

        a {
            text-decoration: none;
            color: #4caf50;
            font-weight: bold;
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #fff;
            border: 2px solid #4caf50;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }

        a:hover {
            background-color: #4caf50;
            color: #fff;
        }

        .avatar-container {
            position: relative;
            display: inline-block;
        }

        .avatar {
            width: 100px; /* Adjust the width as needed */
            height: 100px; /* Adjust the height as needed */
            border-radius: 50%;
            margin-bottom: 7px;
        }

        .edit-icon {
            position: absolute;
            bottom: 0;
            right: 0;
            background-color: #4caf50;
            color: #fff;
            padding: 5px;
            border-radius: 50%;
            cursor: pointer;
        }

        #fileInput {
            display: none;
        }
        body{
            background-image: linear-gradient(to left,#6ff6b3e2,#69e0f8);
        }
    </style>
</head>
<body>

<div class="profile-container">

    <h2>User Profile</h2>

    <div class="avatar-container">
<% if(avatarData==null){%>
    <img class="avatar" src="https://static.vecteezy.com/system/resources/thumbnails/024/191/665/small/black-outline-profile-icon-or-symbol-vector.jpg" alt="User Avatar">
<%} else {%>
    <img class="avatar" src="data:image/png;base64, <%= DatatypeConverter.printBase64Binary(avatarData) %>" alt="User Avatar">
<%}%>     
        <div class="edit-icon" onclick="document.getElementById('fileInput').click()">✏️</div>
    </div>
    

    <form id="avatarForm" action="UpdateAvatar" method="post" enctype="multipart/form-data" style="display: none;">
        <input type="file" name="avatar" id="fileInput" onchange="document.getElementById('avatarForm').submit()">
    </form>

    

    <table>
        
        <tr>
            <td><label>Emp no:</label></td>
            <td><p><%= session.getAttribute("empno") %></p></td>
        </tr> 
        <tr>
            <td><label>Username:</label></td>
            <td><p><%= session.getAttribute("username") %></p></td>
        </tr> 
        <tr>
            <td><label>Email:</label></td>
            <td><p><%= session.getAttribute("email") %></p></td>
        </tr> 
        <tr>
            <td><label>Role:</label></td>
            <td><p><%= session.getAttribute("role") %></p></td>
        </tr>  
    </table>

    <% if (session.getAttribute("role").equals("admin")) { %>
        <a href="AdminDashboard.jsp">Back</a>
    <% } else { %>
        <a href="UserDashboard.jsp">Back</a>
    <% } %>
</div>

</body>
</html>
