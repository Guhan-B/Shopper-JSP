<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html lang="en">

<%
    if(session.getAttribute("userId") != null) {
        if((int) session.getAttribute("userType") != 1)
            response.sendRedirect("catalouge.jsp");
    }
    else {
        response.sendRedirect("login.jsp");
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopper | Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
</head>

<body>
<sql:setDataSource var="connection" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/shopper" user="root" password="Guhan@2001"/>

<sql:query dataSource="${connection}" var="products">
    SELECT * FROM products WHERE name LIKE "%<c:out value="${param.search.trim()}"/>%"
</sql:query>


<% if(request.getAttribute("isError") != null && (boolean) request.getAttribute("isError")) { %>
<div class="error-message">
    <p><%= request.getAttribute("errorMessage") %></p>
</div>
<% } %>

<header class="navbar">
    <h2>Shopper</h2>
    <form class="nav" method="post" action="logout">
        <a href="#" class="profile">
            <i class="far fa-user"></i>
        </a>
        <a href="history.jsp" style="color: #FFFFFF; text-decoration: none; font-weight: bold">History</a>
        <button type="submit" class="logout">
            <p>Logout</p>
            <i class="fas fa-sign-out-alt"></i>
        </button>
    </form>
</header>
<div class="catalouge-page">
    <header>
        <h2>Available Product</h2>
        <form style="display: flex; align-items: stretch; width: 40%;" method="get" action="dashboard.jsp">
            <input type="text" name="search" required placeholder="Search Here">
            <button class="button-primary">Search</button>
        </form>
    </header>
    <table>
        <tr>
            <th>Produce ID</th>
            <th>Product Name</th>
            <th>Stock</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>

        <c:forEach var="product" items="${products.rows}">
            <tr>
                <td><c:out value="${product.id}"/></td>
                <td><c:out value="${product.name}"/></td>
                <td><c:out value="${product.stock} ${product.unit}"/></td>
                <td><c:out value="Rs. ${product.price} per ${product.per} ${product.unit}"/></td>
                <td id="admin-actions">
                    <form method="post" action="update.jsp">
                        <input hidden type="text" value="${product.id}" name="productID"/>
                        <button>
                            <i class="far fa-edit"></i>
                        </button>
                    </form>
                    <form method="post" action="delete">
                        <input hidden type="text" value="${product.id}" name="productID"/>
                        <button type="submit">
                            <i class="far fa-trash-alt"></i>
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <a class="button-primary" style="display: block; width: 20%;text-align: center;margin: 2rem auto;" href="add.jsp">Add Product</a>
</div>
</body>

</html>