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
    <title>Shopper | Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
</head>

<body>
<sql:setDataSource var="connection" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/shopper" user="root" password="Guhan@2001"/>

<c:choose>
    <c:when test="${sessionScope.get('userType') == 1}">
        <sql:query dataSource="${connection}" var="history">
            SELECT fullName, email, mobileNumber, grandTotal, DATE_FORMAT(purchaseDate, "%d-%M-%Y") as purchaseDate, invoiceName FROM users, history WHERE users.id = history.userId;
        </sql:query>
    </c:when>
    <c:when test="${sessionScope.get('userType') == 0}">
        <sql:query dataSource="${connection}" var="history">
            SELECT fullName, email, mobileNumber, grandTotal, DATE_FORMAT(purchaseDate, "%d-%M-%Y") as purchaseDate, invoiceName FROM users, history
            WHERE users.id = history.userId AND users.id = <c:out value="${sessionScope.get('userId')}"/>;
        </sql:query>
    </c:when>
</c:choose>

<%--<sql:query dataSource="${connection}" var="products">--%>
<%--    SELECT * FROM history WHERE name LIKE "%<c:out value="${param.search.trim()}"/>%"--%>
<%--</sql:query>--%>

<% if(request.getAttribute("isError") != null && (boolean) request.getAttribute("isError")) { %>
<div class="error-message">
    <p><%= request.getAttribute("errorMessage") %></p>
</div>
<% } %>

<header class="navbar">
    <h2>Shopper</h2>
</header>
<div class="catalouge-page">
    <header>
        <h2>Purchase History</h2>
    </header>
    <table>
        <tr>
            <c:if test="${sessionScope.get('userType') == 1}">
                <th>Customer Name</th>
                <th>Email</th>
                <th>Mobile Number</th>
            </c:if>
            <th>Purchase Date</th>
            <th>Grand Total</th>
            <th>Actions</th>
        </tr>

        <c:forEach var="entry" items="${history.rows}">
            <tr>
                <c:if test="${sessionScope.get('userType') == 1}">
                    <td><c:out value="${entry.fullName}"/></td>
                    <td><c:out value="${entry.email}"/></td>
                    <td><c:out value="${entry.mobileNumber}"/></td>
                </c:if>
                <td><c:out value="${entry.purchaseDate}"/></td>
                <td><c:out value="Rs. ${entry.grandTotal}"/></td>
                <td>
                    <a href="download?value=${entry.invoiceName}" class="button-primary button-small">Download Invoice</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>

</html>