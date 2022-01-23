<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopper | Reset Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <%
        if(session.getAttribute("resetPassword") == null)
            response.sendRedirect("login.jsp");
    %>

    <% if(request.getAttribute("isError") != null && (boolean) request.getAttribute("isError")) { %>
        <div class="error-message">
            <p><%= request.getAttribute("errorMessage") %></p>
        </div>
    <% } %>

    <div class="authentication-page container">
        <form method="post" action="reset">
            <h2>Reset Password</h2>
            <input type='number' name='id' hidden value="${sessionScope.get('resetPassword')}"/>
            <div class="form-field">
                <label for="password">Password</label>
                <input type="password" required id="password" name="password">
            </div>
            <div class="form-field">
                <label for="cpassword">Confirm Password</label>
                <input type="password" required id="cpassword" name="cpassword">
            </div>
            <button class="button-primary" type="submit">Reset</button>
        </form>
    </div>
</body>

</html>