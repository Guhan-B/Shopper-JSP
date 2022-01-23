<%@ page import="Utility.Product" %>
<%@ page import="java.util.TreeMap" %>
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
    <title>Shopper | Cataloge</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
</head>

<body>
    <sql:setDataSource var="connection" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/shopper" user="root" password="Guhan@2001"/>

    <sql:query dataSource="${connection}" var="products">
        SELECT * FROM products WHERE name LIKE "%<c:out value="${param.search.trim()}"/>%"
    </sql:query>

    <sql:query dataSource="${connection}" var="user">
        SELECT fullName FROM users WHERE id = <c:out value="${sessionScope.get('userId')}"/>;
    </sql:query>

    <%
        if(request.getParameter("product-id") != null || request.getParameter("product-name") != null ||
                request.getParameter("product-price") != null || request.getParameter("product-stock") != null) {

            int id = Integer.parseInt(request.getParameter("product-id"));
            String name = request.getParameter("product-name");
            int price = Integer.parseInt(request.getParameter("product-price"));
            int stock = Integer.parseInt(request.getParameter("product-stock"));
            int per = Integer.parseInt(request.getParameter("product-per"));
            String unit = request.getParameter("product-unit");
            Product cart = new Product(id,price,per,unit,name,stock);

            ArrayList<Product> cartProducts;
            ArrayList<Integer> cartProductsId;
            if(session.getAttribute("cartProducts") == null && session.getAttribute("cartProductsId") == null) {
                cartProducts = new ArrayList<>();
                cartProductsId = new ArrayList<>();
                cartProducts.add(cart);
                cartProductsId.add(id);
            } else {
                cartProducts = (ArrayList<Product>)session.getAttribute("cartProducts");
                cartProductsId = (ArrayList<Integer>)session.getAttribute("cartProductsId");

                if(cartProductsId.contains(id)){
                    for(Product p:cartProducts){
                        if(p.id==id){
                            cartProducts.remove(p);
                            break;
                        }
                    }
                    cartProductsId.remove((Integer)id);
                }
                else{
                    cartProducts.add(cart);
                    cartProductsId.add(id);
                }
            }
            for(Product i:cartProducts){
                System.out.print(i.id + ",");
            }
            System.out.println("end");
            session.setAttribute("cartProducts", cartProducts);
            session.setAttribute("cartProductsId",cartProductsId);
        }
    %>

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
        <h1 style="text-align: center; margin-bottom: 4rem;">Welcome Back ! ... <c:out value="${user.rows[0].fullName}"/></h1>
        <header class="catalogue-header">
            <h2>Product Cataloge</h2>
            <form style="display: flex; align-items: stretch; width: 40%;" method="get" action="catalouge.jsp">
                <input type="text" name="search" required placeholder="Search Here">
                <button class="button-primary">Search</button>
            </form>
        </header>

        <table id="customers">
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Stock</th>
                <th>Price</th>
                <th>Action</th>
            </tr>

            <c:forEach var="product" items="${products.rows}">
                <tr>
                    <td><c:out value="${product.id}"/></td>
                    <td><c:out value="${product.name}"/></td>
                    <td><c:out value="${product.stock} ${product.unit}"/></td>
                    <td><c:out value="Rs. ${product.price} per ${product.per} ${product.unit}"/></td>
                    <td>
                        <form method="post" action="catalouge.jsp">
                            <input type="number" hidden value="${product.id}" name="product-id" />
                            <input type="text" hidden value="${product.name}" name="product-name" />
                            <input type="number" hidden value="${product.stock}" name="product-stock" />
                            <input type="number" hidden value="${product.price}" name="product-price" />
                            <input type="number" hidden value="${product.price}" name="product-per" />
                            <input type="text" hidden value="${product.unit}" name="product-unit" />

                            <%
                               if(session.getAttribute("cartProductsId") != null) {
                               TreeMap p = (TreeMap)pageContext.getAttribute("product");
                               ArrayList<Integer> ids = (ArrayList<Integer>)session.getAttribute("cartProductsId");

                               if(ids.contains(p.get("id"))){ %>
                                    <button class="button-primary button-small" style="background-color:crimson">Remove</button>
                               <% }
                               else { %>
                                    <button class="button-primary button-small">Add</button>
                               <% }
                               }
                               else{ %>
                                    <button class="button-primary button-small">Add</button>
                               <% }
                            %>

                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <div class="purchase-form">
            <form action="cart.jsp">
                <button class="button-primary">Go to Cart</button>
            </form>
        </div>
    </div>
</body>

</html>