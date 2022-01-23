<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="Utility.Variables" %>

<!DOCTYPE html>
<html lang="en">
    <%
        if(session.getAttribute("userId") != null) {
            if((int) session.getAttribute("userType") != 0)
                response.sendRedirect("dashboard.jsp");
        }
        else {
            response.sendRedirect("login.jsp");
        }
    %>

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopper | Update</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
    </head>

    <body>
        <sql:setDataSource var="connection" driver="com.mysql.cj.jdbc.Driver" url="<%=Utility.Variables.SqlUrl%>" user="root" password="<%=Utility.Variables.SqlPassword%>"/>

        <sql:query dataSource="${connection}" var="user">
            SELECT * ,  date_format(dob, "%Y-%m-%d") as dateOfBirth from users WHERE id = <c:out value="${sessionScope.get('userId')}"/>;
        </sql:query>

        <% if(request.getAttribute("isError") != null && (boolean) request.getAttribute("isError")) { %>
        <div class="error-message">
            <p><%= request.getAttribute("errorMessage") %></p>
        </div>
        <% } %>

        <header class="navbar">
            <h2>Shopper</h2>
        </header>
        <div class="add-page container">
            <form method="post" action="profile">
                <h2>Edit Profile</h2>
                <div class="form-field">
                    <label for="full-name">Full Name</label>
                    <input required type="text" id="full-name" name="full-name" value="${user.rows[0].fullName}">
                </div>
                <div class="form-field">
                    <label for="email">Email</label>
                    <input required type="email" id="email" name="email" value="${user.rows[0].email}">
                </div>
                <div class="form-field">
                    <label for="mobile-number">Mobile Number</label>
                    <input required type="number" maxlength="10" minlength="10" id="mobile-number" name="mobile-number" value="${user.rows[0].mobileNumber}">
                </div>
                <div class="form-field">
                    <label for="dob">Date of Birth</label>
                    <input required type="date" id="dob" name="dob" value="${user.rows[0].dateOfBirth}">
                </div>
                <div class="form-field">
                    <label for="password">Change Password</label>
                    <input id="password" name="password" type="password">
                </div>
                <div class="controls">
                    <button class="button-primary" type="reset">Clear</button>
                    <button class="button-primary" type="submit">Save</button>
                </div>
            </form>
        </div>
    </body>
</html>