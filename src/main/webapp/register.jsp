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
    <title>Shopper | Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <div class="authentication-page container">

        <% if(request.getAttribute("isError") != null && (boolean) request.getAttribute("isError")) { %>
            <div class="error-message">
                <p><%= request.getAttribute("errorMessage") %></p>
            </div>
        <% } %>

        <form method="post" action="register">
            <h2>Register</h2>
            <div class="form-field">
                <label for="full-name">Full Name</label>
                <input required id="full-name" name="full-name" type="text">
            </div>
            <div class="form-field">
                <label for="dob">Date of Birth</label>
                <input type="date" required id="dob" name="dob">
            </div>
            <div class="form-field">
                <label for="mobile-number">Mobile Number</label>
                <input required id="mobile-number" name="mobile-number" type="text">
            </div>
            <div class="form-field">
                <label for="email">Email</label>
                <input required id="email" name="email" type="email">
            </div>
            <div class="form-field">
                <label for="password">Password</label>
                <input required id="password" name="password" type="password">
            </div>
            <button class="button-primary" type="submit">Register</button>
            <p>Existing customer? <a href="login.jsp">Login</a></p>
        </form>
    </div>
</body>

</html>