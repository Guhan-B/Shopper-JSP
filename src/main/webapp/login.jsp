<!DOCTYPE html>
<html lang="en">

<%
    if(session.getAttribute("userId") != null) {
        int userType = (int) session.getAttribute("userType");

        if(userType == 0)
            response.sendRedirect("catalouge.jsp");

        if(userType == 1)
            response.sendRedirect("dashboard.jsp");
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopper | Login</title>
    <link rel="stylesheet" href="./CSS/style.css">
</head>

<body>
    <% if(request.getAttribute("isError") != null && (boolean) request.getAttribute("isError")) { %>
        <div class="error-message">
            <p><%= request.getAttribute("errorMessage") %></p>
        </div>
    <% } %>

    <div class="authentication-page container">
        <form method="post" action="login">
            <h2>Login</h2>
            <div class="form-field">
                <label for="email">Email</label>
                <input required id="email" name="email" type="email">
            </div>
            <div class="form-field">
                <label for="password">Password</label>
                <input required id="password" name="password" type="password">
            </div>
            <button class="button-primary" type="submit">Login</button>
            <p>New customer? <a href="register.jsp">Register</a></p>
        </form>
    </div>
</body>

</html>