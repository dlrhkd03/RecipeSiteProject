<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
</head>
<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include><br>
<body>


	<!-- 이동호 -->
<div id="main" style="margin-left:50px;">
<div class="page-heading" style="margin-top:90px;">	 
    <div class="col-lg-5 mx-auto text-center mb-4" style="background-color:#fff;border-radius:2rem;padding:1.5rem;">
        
            <h2>이메일 인증하기</h2>
                아래 이메일주소를 입력하시면,<br> 입력하신 이메일로 인증코드를 보내드립니다<br>
                <br>
                
            <div class="row">
				<div class="col-md-3 fw-bold fs-5 mt-1" style="text-align: left;" >이메일 입력 : </div>
				<div class="col-md-9 form-group">
					<input class="form-control" type="text" value="${email}" readonly="readonly">
				</div>
			</div>
			<div class="row">
				<div class="col-md-3 fw-bold fs-5 mt-1" style="text-align: left;">인증번호 : </div>
				<div class="col-md-9 form-group">
					<input class="form-control" id="inputCode" type="text"/>
				</div>
			</div>
			<div class="d-grid gap-2 col-6 mx-auto">
				<button class="btn btn-primary mt-2" id="submitbtn" type="button" >확 &emsp; 인</button> 
			</div>
			<div>
				<a id="join" href="http://localhost:9009/join"></a>
			</div>
        	
    </div>
    </div>
    </div>



<!-- 준혁님 -->
<%--     <div id="main">
<div class="page-heading" style="margin-top:90px;">	

 	<div>
		<h2>이메일 인증하기</h2>
		아래 이메일주소를 입력하시면,<br>입력하신 이메일로 인증코드를 보내드립니다<br>	
            <br>
         <h5>   이메일 입력 :
            <input type="text" value="${email}" ></h5>
    </div>
    <h3><p>입력하신 이메일로 인증번호를 전송하였습니다.</p></h3>
	<div class="box inputCode"> 
		<h5>인증번호 :
		<input id="inputCode" type="text"/> </h5>
		<button id="submitbtn" type="button" >확인</button> 
	</div>
	
	<div>
		<a id="join" href="http://localhost:9009/join"></a>
	</div>
	</div>
</div> --%>
<!-- 준혁님 -->

<script>
//확인 버튼 클릭시 인증번호 대조 후 일치여부 판단
	$("#submitbtn").click(function() {	
	var inputCode = $("#inputCode").val();	
	var joinCode = ${joinCode};
		if (inputCode == joinCode) {
			alert("인증번호가 일치합니다");
			$("#join").get(0).click();	
		} else {
			alert("인증번호가 일치하지 않습니다");
		}
	});
</script>



</body>
</html>