<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopper | Forgot Password</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <% if(request.getAttribute("isError") != null && (boolean) request.getAttribute("isError")) { %>
            <div class="error-message">
                <p><%= request.getAttribute("errorMessage") %></p>
            </div>
        <% } %>

        <div class="authentication-page container">
            <form method="post" action="forgot">
                <h2>Forgot Password</h2>
                <div class="form-field">
                    <label for="dob">Date of Birth</label>
                    <input type="date" required id="dob" name="dob">
                </div>
                <div class="form-field">
                    <label for="email">Email</label>
                    <input required id="email" name="email" type="email">
                </div>
                <button class="button-primary" type="submit">Verify</button>
                <p><a href="login.jsp">Back to Login</a></p>
            </form>
        </div>
    </body>
</html>