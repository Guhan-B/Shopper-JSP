<!DOCTYPE html>
<html lang="en">

<%
    if(session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopper | Catalouge</title>
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
    <div class="catalouge-page">
        <h2>Product Catalouge</h2>
        <table id="customers">
            <tr>
                <th>Produce ID</th>
                <th>Product Name</th>
                <th>Stock</th>
                <th>Price</th>
                <th>Action</th>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
            <tr>
                <td>1728</td>
                <td>Tarragon - Fresh</td>
                <td>5</td>
                <td>100</td>
                <td>
                    <button class="outline-button">ADD</button>
                </td>
            </tr>
        </table>
        <form class="purchase-form">
            <button class="button-primary">Purchase</button>
        </form>
    </div>
</body>

</html>