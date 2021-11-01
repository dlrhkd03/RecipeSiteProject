<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>405 - Mazer Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="adminassets/css/bootstrap.css">
    <link rel="stylesheet" href="adminassets/css/bootstrap.css/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="adminassets/css/bootstrap.css/css/app.css">
    <link rel="stylesheet" href="adminassets/css/bootstrap.css/css/pages/error.css">
</head>

<body>
    <div id="error">


        <div class="error-page container">
            <div class="col-md-8 col-12 offset-md-2 mt-5">
                
                <div class="text-center">
                    <h1 class="error-title">세션 만료</h1>
                    <p class="fs-5 text-gray-600">로그인 세션이 만료되었습니다. 다시 로그인 해주세요.</p>
                    <a href="/main" class="btn btn-lg btn-outline-primary mt-3">홈으로</a>
                </div>
            </div>
        </div>


    </div>
</body>
</html>