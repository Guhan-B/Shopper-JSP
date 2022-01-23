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

        <% if(session.getAttribute("cartProducts") == null || ((ArrayList<Product>)(session.getAttribute("cartProducts"))).size()==0) { %>
            <p style="font-size:1.25rem;margin: 1.5rem 0;text-align:center;">There is no products in your cart!</p>
        <% } %>
        <div style="display:flex;justify-content:flex-end;">
            <a href="catalouge.jsp" style="margin: 2rem 1rem 0 0;" class="button-primary">Back to Home</a>
            <% if(session.getAttribute("cartProducts") != null && ((ArrayList<Product>)(session.getAttribute("cartProducts"))).size()!=0) { %>
                    <button style="margin: 2rem 0 0 0;" class="button-primary">Purchase</button>
            <% } %>

        </div>

    </form>
</div>
</body>

</html>