<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- HIỂN THỊ USER ĐĂNG NHẬP -->
<c:if test="${not empty sessionScope.user}">
    <h3>Xin chào: ${sessionScope.user.fullname}</h3>
    <a href="logout">Đăng xuất</a>
    <hr>
</c:if>

<!-- MENU CHỨC NĂNG -->

<a href="<c:url value='/favorite-videos'>
            <c:param name='id' value='admin'/>
         </c:url>">
    Video yêu thích của admin
</a>
<br><br>

<a href="<c:url value='/share-summary'/>">
    Thống kê chia sẻ
</a>
<br><br>

<a href="<c:url value='/login'/>">
    Đăng nhập
</a>
<br><br>

<a href="<c:url value='/search-video'>
            <c:param name='keyword' value='java'/>
         </c:url>">
    Search video (test)
</a>
<br>
