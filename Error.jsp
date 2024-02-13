<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="script.js"></script>
    <title>Bloging Platform</title>
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
    background-color: #f4f4f4;
}

#blog-posts {
    margin-bottom: 20px;
}

h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

table {
    margin-top: 20px;
    border-collapse: collapse;
}

table td {
    padding: 10px;
    text-align: center;
}

table a {
    text-decoration: none;
    color: #fff;
    font-weight: bold;
    
}
button{
    padding: 10px;
    background-color: #4caf50;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

table a:hover {
    color: #4caf50;
}

</style>
<script>
    var timer = setTimeout(function() {
        window.location='Login.html'
    }, 3000);
</script>
</head>
<body>

<center> 
    <h2> Incorrect Credentials ... Redirecting to Login Page</h2>
</center>
</body>
</html>
