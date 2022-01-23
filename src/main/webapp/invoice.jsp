<%@ page import="Utility.Checkout" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>Shopper | Invoice</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
</head>

<body>

<header class="navbar">
    <h2>Shopper</h2>
</header>
<div class="catalouge-page">
    <header>
        <h2>Invoice</h2>
    </header>

    <table id="customers">
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        <c:if test="${requestScope.get('products') != null}">
            <% ArrayList<Checkout> products = (ArrayList<Checkout>) request.getAttribute("products"); %>

            <% for (Checkout product : products) { %>
                <tr>
                    <td><%= product.productId %></td>
                    <td><%= product.productName %></td>
                    <td><%= product.quantity %></td>
                    <td><%= product.price %></td>
                </tr>
            <% } %>
        </c:if>
    </table>

    <div class="grand-total">
        <span class="span-1">Grand Total</span>
        <span class="span-2">Rs. <%= request.getAttribute("total") %></span>
    </div>

    <div class="redirect-form">
        <form action="redirect">
            <button class="button-primary">Back to Home</button>
        </form>
        <a class="button-primary" href=<%= "download?value=" + request.getAttribute("invoice") %>>Download Invoice</a>
    </div>
</div>
</body>

</html>