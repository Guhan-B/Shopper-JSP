<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html lang="en">

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopper | Cataloge</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
</head>

<body>
    <sql:setDataSource var="connection" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/shopper" user="root" password="srijayan"/>

    <sql:query dataSource="${connection}" var="products">
        SELECT * from products;
    </sql:query>

    <header class="navbar">
        <h2>Shopper</h2>
        <form class="nav" method="post" action="logout">
            <a href="#" class="profile">
                <i class="far fa-user"></i>
            </a>
            <button type="submit" class="logout">
                <p>Logout</p>
                <i class="fas fa-sign-out-alt"></i>
            </button>
        </form>
    </header>
    <div class="catalouge-page">
        <header>
            <h2>Product Cataloge</h2>
        </header>
        <form method="post" action="purchase">
            <table id="customers">
                <tr>
                    <th>Produce ID</th>
                    <th>Product Name</th>
                    <th>Stock</th>
                    <th>Price</th>
                    <th>Quantity</th>
                </tr>

                <c:forEach var="product" items="${products.rows}">
                    <tr>
                        <td><c:out value="${product.id}"/></td>
                        <td><c:out value="${product.name}"/></td>
                        <td><c:out value="${product.stock} ${product.unit}"/></td>
                        <td><c:out value="Rs. ${product.price} per ${product.per} ${product.unit}"/></td>
                        <td>
                            <input type="number" hidden name="product-id" value="${product.id}">
                            <input style="width: 100px;text-align: center;" type="number" value="0" min="0" name="${product.id}">
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <div class="purchase-form">
                <button class="button-primary">Purchase</button>
            </div>
        </form>
    </div>
</body>

</html>