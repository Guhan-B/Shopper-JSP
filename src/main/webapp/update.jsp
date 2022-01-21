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

    System.out.println(request.getParameter("productID"));
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
    <sql:setDataSource var="connection" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/shopper" user="root" password="srijayan"/>

    <c:set var="productID" scope="request" value='${param.productID}' />

    <sql:query dataSource="${connection}" var="product">
        SELECT * from products WHERE id = ?;
        <sql:param value="${productID}"/>
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
    <div class="add-page container">
        <form method="post" action="update">
            <h2>Edit Product</h2>
            <div class="form-field">
                <label for="product-name">Product Name</label>
                <input required type="text" id="product-name" name="product-name" value="${product.rows[0].name}">
            </div>
            <div class="form-field">
                <label for="product-cost">Product Cost</label>
                <input required type="number" min="0" id="product-cost" name="product-cost" value="${product.rows[0].price}">
            </div>
            <div class="form-field">
                <label for="product-stock">Product Stock</label>
                <input required type="number" min="0" id="product-stock" name="product-stock" value="${product.rows[0].stock}">
            </div>
            <div class="form-field">
                <label for="product-unit">Product Unit</label>
                <select style="outline: none;padding: 0.65rem;border: 1px solid #dfe6e9;border-radius: 2px;width: 100%;" required id="product-unit" name="product-unit" >
                    <option value="" ></option>
                    <option value="kg">kilogram</option>
                    <option value="g">Gram</option>
                    <option value="mg">Milligram</option>
                    <option value="l">Liter</option>
                    <option value="ml">Milliliter</option>
                    <option value="pack">pack</option>
                </select>
            </div>
            <div class="form-field">
                <label for="cost-per">Product cost for how many unit?</label>
                <input required type="number" min="0" id="cost-per" name="cost-per" value="${product.rows[0].per}">
            </div>
            <%
                out.print("<input hidden type=\"text\" name=\"productID\" value=" + request.getParameter("productID") + ">");
            %>
            <div class="controls">
                <button class="button-primary" type="reset">Clear</button>
                <button class="button-primary" type="submit">Save</button>
            </div>
        </form>
    </div>
</body>

</html>