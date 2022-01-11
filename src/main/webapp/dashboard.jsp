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
    <title>Shopper | Login</title>
    <link rel="stylesheet" href="./CSS/style.css">
    <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
    integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc"
    crossorigin="anonymous"></script>
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
    <div class="admin-page">
        <div class="admin-center">
            <h2>Manage Products</h2>
            <form>
                <button class="button-primary" type="submit">Add Product</button>
            </form>
            <form>
                <button class="button-primary" type="submit">Remove Product</button>
            </form>
            <form>
                <button class="button-primary" type="submit">Edit Product</button>
            </form>
        </div>
    </div>
</body>

</html>