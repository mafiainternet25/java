<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirecting…</title>
    <meta http-equiv="refresh" content="0; url=${pageContext.request.contextPath}/home" />
</head>
<body>
<p>Redirecting to <a href="${pageContext.request.contextPath}/home">home</a>...</p>
</body>
</html>












