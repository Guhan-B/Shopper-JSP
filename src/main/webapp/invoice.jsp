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
        <h2>Invoice</h2>
    </header>
    <table id="customers">
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>

        <%
            if(request.getAttribute("products") != null) {
                ArrayList<Checkout> products = (ArrayList<Checkout>)request.getAttribute("products");
                for(int i=0; i<products.size(); i++) {
                    out.print("<tr>");
                    out.print("<td>" + products.get(i).productId + "</td>");
                    out.print("<td>" + products.get(i).productName + "</td>");
                    out.print("<td>" + products.get(i).quantity + "</td>");
                    out.print("<td>" + Double.toString(products.get(i).price) + "</td>");
                    out.print("</tr>");
                }
            }
        %>

    </table>

    <div class="total" style="display: flex; align-items: center; margin-top: 2rem; justify-content: flex-end">
        <span style="font-weight: bold; font-size: 1rem">
            Grand Total
        </span>
        <span style="margin: 0 2.5rem 0 3rem; padding: 0.6rem 1.5rem; border: 1px solid rgba(116, 186, 255, 0.5);
  box-shadow: 0 0 0 3px rgba(116, 186, 255, 0.2); border-radius: 4px"; >

             <%
                 out.print("Rs. " + Checkout.grandTotal );
             %>

        </span>
    </div>
    <div style="display:flex;justify-content:center;margin-top:4rem;gap: 1rem;">
        <form action="redirect">
            <button class="button-primary">Back to Home</button>
        </form>
        <a class="button-primary" href=<%= "download?value=" + request.getAttribute("invoice") %>>Download Invoice</a>
    </div>
</div>
</body>

</html>