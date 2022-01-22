<%@ page import="java.util.ArrayList" %>
<%@ page import="Utility.Product" %>
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
    <title>Shopper | Cart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
</head>

<body>

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
        <h2>Cart</h2>
    </header>

    <% if(request.getAttribute("isError") != null && (boolean) request.getAttribute("isError")) { %>
    <div class="error-message">
        <p><%= request.getAttribute("errorMessage") %></p>
    </div>
    <% } %>

    <form action="purchase" method="post">
        <table id="customers">
            <tr>
                <th>Produce ID</th>
                <th>Product Name</th>
                <th>Stock</th>
                <th>Price</th>
                <th>Quantity</th>
            </tr>
            <c:if test="${sessionScope.get('cartProducts') != null}">
                <% ArrayList<Product> products = (ArrayList<Product>)session.getAttribute("cartProducts"); %>

                <% for (Product product : products) { %>
                    <tr>
                        <td><%= product.id %></td>
                        <td><%= product.name %></td>
                        <td><%= product.stock + " " + product.unit %></td>
                        <td><%= product.price + " per " + product.per + " " + product.unit %></td>
                        <td>
                            <input required style="width: 100px;text-align: center;" type="number" value="0" min="0" name=<%= product.id %> >
                        </td>
                    </tr>
                <% } %>
            </c:if>
        </table>
        <button style="display: block; margin: 2rem 0 0 auto;" class="button-primary">Purchase</button>
    </form>
</div>
</body>

</html>