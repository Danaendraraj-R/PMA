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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
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
</head>
<body>

    <h2>Add Admin</h2>
    <form id="registerForm" method="post" action="Register1">
        <label for="registerUsername">Username:</label>
        <input type="text" id="Username" name="Username" required>

        <label for="Email">Email:</label>
        <input type="text" id="Email" name="Email" required>
        
        <label for="registerPassword">Password:</label>
        <input type="password" id="Password" name="Password" required>
        
        <input type="submit" value="Register">
         <center>
            <a href="Login.html">Already have an account</a><br><br>
            <a href="index.html">Home</a>
        </center>
    </form>
    

    <div id="result"></div>
</body>
</html>
