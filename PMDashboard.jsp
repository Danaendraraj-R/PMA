<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

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
else if(role.equals("admin")){
    response.sendRedirect("AdminDashboard.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Oswald:wght@400;600&display=swap" rel="stylesheet">
  <title>Project Manager Dashboard</title>
  <style>
    body {
  margin: 0;
  font-family: 'Arial', sans-serif;
}

.container {
  position: relative;
  width: 100%;
  height: 100vh;
}

.navbar {
  background-color: #333;
  padding: 15px;
  text-align: left;
}

.toggle-btn {
  background-color: #333;
  color: white;
  border: none;
  font-size: 16px;
  cursor: pointer;
}

.overlay {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.content {
  padding: 20px;
}


.sidebar {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidebar a {
  padding: 15px 15px 15px 32px;
  text-decoration: none;
  font-size: 17px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.sidebar a:hover {
  color: #f1f1f1;
}

.sidebar .close-btn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 25px;
  margin-left: 50px;
}
ul{
  list-style-type: none;
}

.container.change .sidebar {
  width: 250px;
}

.container.change .overlay {
  display: block;
}

.logout-btn {
  float: right;
  padding: 15px;
}
.logout-btn form {
  margin-top: -20px; 
}

.logout-btn input[type="submit"] {
  margin-top: 0px;  
  background-color: #f1f1f1; 
  color: #000;
  padding: 10px 15px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

            :root {
  --bg: #1d3557;
  --c1: #457b9d;
  --c2: #fff;
  --c3: #a8dadc;

  /*   
  --bg: #112;
  --c1: blue;
  --c2: white;
  --c3: #eef; 
  */
}

html, body {
  background: var(--bg);
  font-family: Montserrat, Oswald, Arial, sans-serif;
  color: #dde;
  margin: 0;
  padding: 0;
}

header {
  height: 50vh;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  align-items: center;
  position: relative;
  background-color: var(--bg);
}

@keyframes showBars {
  0% { opacity: 0; background-position: -400% 7%, 500% 21%, -400% 35%, 500% 49%, -400% 63%, 500% 77%, -400% 91% ; }
  14% { background-position: 0% 7%, 500% 21%, -400% 35%, 500% 49%, -400% 63%, 500% 77%, -400% 91% ; }
  28% { background-position: 0% 7%, 100% 21%, -400% 35%, 500% 49%, -400% 63%, 500% 77%, -400% 91% ; }
  42% { background-position: 0% 7%, 100% 21%,    0% 35%, 500% 49%, -400% 63%, 500% 77%, -400% 91% ; }
  56% { background-position: 0% 7%, 100% 21%,    0% 35%, 100% 49%, -400% 63%, 500% 77%, -400% 91% ; }
  70% { background-position: 0% 7%, 100% 21%,    0% 35%, 100% 49%,    0% 63%, 500% 77%, -400% 91% ; }
  84% { background-position: 0% 7%, 100% 21%,    0% 35%, 100% 49%,    0% 63%, 100% 77%, -400% 91% ; }
  98%, 100% { opacity: 1; background-position: 0% 7%, 100% 21%, 0% 35%, 100% 49%, 0% 63%, 100% 77%, 0% 91%; }
}

header::after {
  content: "";
  width: 100%;
  height: 20vh;
  position: absolute;
  top: 0;
  left: 0;
  background-color: inherit;
  background-repeat: no-repeat;
  background-size: 70% 7%;
  background-image:
    linear-gradient(var(--c1),var(--c1)),
    linear-gradient(var(--c2),var(--c2)),
    linear-gradient(var(--c1),var(--c1)),
    linear-gradient(var(--c2),var(--c2)),
    linear-gradient(var(--c1),var(--c1)),
    linear-gradient(var(--c2),var(--c2)),
    linear-gradient(var(--c1),var(--c1));
  background-position: 0% 7%, 100% 21%, 0% 35%, 100% 49%, 0% 63%, 100% 77%, 0% 91%;
  animation: showBars 3.5s;
}

@keyframes showText {
  0% { opacity: 0; transform: translate(0, -100%); }
  20% { opacity: 0; }
  100% { opacity: 1; transform: translate(0, 0); }
}

header > div {
  position: relative;
  transform: translate(-100%, 0);
  opacity: 0;
  animation: showText 2s 1;
  animation-fill-mode: forwards;
  animation-delay: 3.5s;
  text-align: center;
}

h1 {
  font-weight: 400;
  font-family: Oswald, Montserrat, arial, sans-serif;
  margin: 0;
  font-size: 10vw;
  color: var(--c2);
}

p {
  color: var(--c3);
  margin: 0;
  font-size: 5vw;
  margin-bottom: 5vh;
}

@media all and (min-width: 768px) {

  @keyframes showBarsBig {
    0% { opacity: 0; background-position: 7% -400%, 21% 500%, 35% -400%, 49% 500%, 63% -400%, 77% 500%, 91% -400%; }
    14% { background-position: 7% 0%, 21% 500%, 35% -400%, 49% 500%, 63% -400%, 77% 500%, 91% -400%; }
    28% { background-position: 7% 0%, 21% 100%, 35% -400%, 49% 500%, 63% -400%, 77% 500%, 91% -400%; }
    42% { background-position: 7% 0%, 21% 100%, 35% 0%, 49% 500%, 63% -400%, 77% 500%, 91% -400%; }
    56% { background-position: 7% 0%, 21% 100%, 35% 0%, 49% 100%, 63% -400%, 77% 500%, 91% -400%; }
    70% { background-position: 7% 0%, 21% 100%, 35% 0%, 49% 100%, 63% 0%, 77% 500%, 91% -400%; }
    84% { background-position: 7% 0%, 21% 100%, 35% 0%, 49% 100%, 63% 0%, 77% 100%, 91% -400%; }
    98%, 100% { opacity: 1; background-position: 7% 0%, 21% 100%, 35% 0%, 49% 100%, 63% 0%, 77% 100%, 91% 0%; }
  }

  @keyframes showTextBig {
    0% { opacity: 0; transform: translate(-100%, 0); }
    20% { opacity: 0; }
    100% { opacity: 1; transform: translate(0vw, 0); }
  }

  header {
    height: 100vh;
    flex-direction: column;
    align-items: flex-start;
    justify-content: center;
  }

  header::after {
    width: 20vw;
    height: 100%;
    background-size: 7% 70%;
    background-position: 
      7% 0%, 21% 100%, 35% 0%, 49% 100%, 63% 0%, 77% 100%, 91% 0%;
    animation-name: showBarsBig;
  }

  header > div {
    animation-name: showTextBig;
    margin-left: 22vw;
    text-align: left;
  }

  h1 {
    font-size: 8vw;
  }

  p {
    font-size: 4vw;
    margin-bottom: 0;
  }
}

@media (prefers-reduced-motion) {
  header::after {
    animation: none !important;
  }
  
  @keyframes showTextReduced {
    0% { opacity: 0; }
    100% { opacity: 1; }
  }
  
  
  header > div {
    transform: translate(0,0);
    animation-name: showTextReduced;
    animation-delay: 0.5s !important;
  }
}



  </style>
  <script>
    function toggleNav() {
  var container = document.querySelector('.container');
  container.classList.toggle('change');
}

  </script>
</head>
<body>

<div class="overlay"></div>

<div class="container">
  <div class="navbar">
    <button class="toggle-btn" onclick="toggleNav()">&#9776; Menu</button>
    <div class="logout-btn">
        <form action="Logout" method="post">
            <input type="submit" value="Logout">
        </form>
      </div>
  </div>

  <div class="sidebar">
    <a href="javascript:void(0)" class="close-btn" onclick="toggleNav()">&#10005;</a>
    <ul>
      <li><a href="AddProject.jsp">Add Project</a></li>
      <li><a href="AddTask.jsp">Add Task</a></li>
      <li><a href="ManageProjects.jsp">Manage Projects</a></li>
      <li><a href="Profile.jsp">View Profile</a></li>
    </ul>
  </div>
  
<header>
  <div>
    <h1>Welcome Back!</h1>
    <p>Let's get started with the projects</p>
  </div>
</header>


</body>
</html>
