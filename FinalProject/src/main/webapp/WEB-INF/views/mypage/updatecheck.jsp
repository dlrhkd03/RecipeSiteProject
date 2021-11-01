<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"  %>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오늘 뭐 해먹지?</title>
    
    <link href="mainassets/assets/css/theme.css" rel="stylesheet" />
    
	<link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="adminassets/css/bootstrap.css">
    <link rel="stylesheet" href="adminassets/vendors/simple-datatables/style.css">
    <link rel="stylesheet" href="adminassets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="adminassets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="adminassets/css/app.css">
    <link rel="shortcut icon" href="imgs/logo.ico" type="image/x-icon">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
	<script src="mainassets/vendors/fontawesome/all.min.js"></script>
	
	
<script type="text/javascript">
var result ="${result}";
if(result == "false") {
	alert("비밀번호를 확인 후 다시 입력해주세요.")
	$("#user_pw").focus();
}
function updatecheck() {
	
	if($("#user_pw").val() == ""){
		alert("비밀번호를 입력해주세요.");
		$("#user_pw").focus();
		return false;
	}
	
	$("form").submit();    
	
}
</script>

<style>
		.btn{
			font-weight: 700;
		
		}
		.navbar{
			padding-left: 320px;
		}
		.dropdown-menu{
			min-width: 8rem;
		}
		
	</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include><br>
    <div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active" style="background-color: #FFB30E">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            마이 페이지
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">

                        <li class="sidebar-item">
                            <a href="/myzzimrecipelist" class='sidebar-link'>
                           	 <i class="fas fa-heart"></i>
                              
                                <span>찜한 레시피</span>
                            </a>
                        </li>

                        <li class="sidebar-item  ">
                            <a href="/myrecipelist" class='sidebar-link'>
                                <i class="fas fa-utensils"></i>
                                <span>내가 작성한 레시피</span>
                            </a>
                        </li>

                        <li class="sidebar-item active ">
                            <a href="/check" class='sidebar-link'>
                                <i class="fas fa-user-cog"></i>
                                <span>회원정보 수정</span>
                            </a>
                        </li>

                    </ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
            </div>
        </div>
        
<div id="main">
<div class="page-heading" style="margin-top:90px;">
<!-- 이 줄 아래에다가만 추가해주세요 -->     
	<div class="col-lg-5 mx-auto text-center mb-4" style="background-color:#fff;border-radius:2rem;padding:1.5rem;">
		<form action="/check" method="post">
			<div class="col-lg-9 mx-auto text-center mb-4">
				<h3 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">회원정보 수정</h3>
			</div>
			<div class="row">
				<div class="col-md-4 fw-bold fs-5 mt-1">비밀번호 확인 : </div>
				<div class="col-md-8 form-group">
				<input class="form-control" type="password" name="user_pw" id = "user_pw"/> 
				</div>
			</div>
		</form>
		
		
		
		<button class="btn btn-primary me-2" type ="button" id ="submit" onclick = "updatecheck()"> 확인</button>
		<button class="btn btn-primary" type ="button" id ="submit" onclick = "location.href = '/main'"> 취소</button>
	
	</div>
<!-- 이 줄 위에다가만 추가해주세요 -->
</div>
</div>
</div>
<script src="adminassets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="adminassets/js/bootstrap.bundle.min.js"></script>
	<script src="adminassets/js/main.js"></script>


</body>
</html>