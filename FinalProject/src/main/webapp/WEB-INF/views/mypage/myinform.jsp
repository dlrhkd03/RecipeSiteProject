<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"  %>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오늘 뭐 해먹지? : MY INFORM</title>
    
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
	
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
					
					
		<script type="text/javascript">	
				/* 우편번호 찾기 api */
				function execPostCode() {
				    new daum.Postcode({
				        oncomplete: function(data) {
				           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
				           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				           var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	
				           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				               extraRoadAddr += data.bname;
				           }
				           // 건물명이 있고, 공동주택일 경우 추가한다.
				           if(data.buildingName !== '' && data.apartment === 'Y'){
				              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				           }
				           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				           if(extraRoadAddr !== ''){
				               extraRoadAddr = ' (' + extraRoadAddr + ')';
				           }
				           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				           if(fullRoadAddr !== ''){
				               fullRoadAddr += extraRoadAddr;
				           }
	
				           // 우편번호와 주소 정보를 해당 필드에 넣는다.
				           console.log(data.zonecode);//우편번호
				           console.log(fullRoadAddr);//도로명주소
				           
				           
				           $("#user_address1").val(data.zonecode);
				           $("#user_address2").val(fullRoadAddr);
				           
				           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
				           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
				           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
				       }
				    }).open();
				}
	
				
				
			</script>
	
<script>
				
					
				const regex = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
				const regex2 = /^[가-힣a-zA-Z]+$/;
				const regex3 = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
				
				function updatecheck() {
				var test1 = $("#user_name").val();
				var test2 = $("#user_pw").val();
				var test3 = $("#user_pw_c").val();
				var test4 = $("#user_phone").val();
				
						if (test2 == ""){
						alert("변경 비밀번호를 입력해주세요.");
						$("#user_pw").focus();
						return false;

						}
						
						if (test3 == ""){
							alert("변경비밀번호확인을 입력해주세요.");
							$("#user_pw_c").focus();
							return false;
							
							}
						
						if (!regex.test(test2)) {
							alert("변경비밀번호 조건 오류.")
							$("#user_pw").focus();
							return false;
						}	
						
						if (!regex.test(test3)) {
							alert("변경비밀번호확인 조건 오류.")
							$("#user_pw_c").focus();
							return false;
						}	
						
						if (test1 == ""){
							alert("이름을 입력해주세요.");
							$("#user_name").focus();
							return false;
						}
						
						if (!regex2.test(test1)) {
							alert("이름을 잘못 입력하셨습니다.")
							$("#user_name").focus();
							return false;
						}	
						
						if(test2 != test3) {
							alert("변경비밀번호가 서로 다르게 입력하셨습니다. ")
							$("#user_pw").focus();
							return false;
						}
							
						if ($("#user_phone").val() == ""){
								alert("전화번호를 입력해주세요.");
								$("#user_phone").focus();
								return false;
							}
						
						if(!regex3.test(test4)){
							alert("-을 입력해주세요.");
							$("#user_phone").focus();
							return false;
						}
							
						if ($("#user_address").val() == ""){
								alert("주소를 입력해주세요.");
								$("#user_address").focus();
								return false;
							}

							
						if(confirm("회원수정을 하시겠습니까?")){
							// alert("회원가입이 완료되었습니다. 감사합니다.");
					         $("form").submit();
					    }

						
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
        </div>
        
  <div id="main">
<div class="page-heading" style="margin-top:90px;">    

<div class="col-lg-7 mx-auto text-center mb-4">
<h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">회원정보 수정</h5></div>  
		 
 <div class="modal-content w-75" style="margin-left:180px;">
     <form action="/myinform" method="post" >
         <div class="modal-body">
       	  <input class="form-control" type="hidden" id="user_no" name="user_no" value="${login_info.user_no}" />
             <label>이메일: </label>
             <div class="form-group">
                 <input class="form-control" type="text" id="user_email" name="user_email" value="${login_info.user_email}" readonly="readonly"/>
             </div>
             
             <label>비밀번호: </label>
             <div class="form-group">
                 <input class="form-control" type="password" id="user_pw_u" name="user_pw_u" value="${login_info.user_pw}"  readonly="readonly"/>
             </div>
             
             
             <label>변경 비밀번호: </label>
             <div class="form-group">
                 <input class="form-control" type="password" id="user_pw" name="user_pw"  />
             </div>
             <label>(8~16자내에서 영문 대 소문자, 숫자, 특수문자를 전부 사용하세요.)</label><br><br>
             
             <label>변경 비밀번호 확인: </label>
             <div class="form-group">
                 <input class="form-control" type="password" id="user_pw_c" name="user_pw_c"  />
             </div>
             <label>(8~16자내에서 영문 대 소문자, 숫자, 특수문자를 전부 사용하세요.)</label><br><br>
             
             <label>이름: </label>
             <div class="form-group">
                 <input class="form-control" type="text" id="user_name" name="user_name" value="${login_info.user_name}"/>
             </div>
             <label>(한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가))</label><br><br>
             
             <label>휴대전화: </label>
             <div class="form-group">
                 <input class="form-control" type="text" id="user_phone" name="user_phone" value="${login_info.user_phone}"/>
             </div>
             <label>(반드시 하이픈'-'을 포함해주세요)</label><br><br>
             
             <c:set var="imsi" value="${login_info.user_address}"/>
			<c:set var="address" value="${fn:split(imsi,',')}"/>					
             <label>주소: </label>
             <div class="form-group">
             	<input class="form-control w-25" style="display:inline;" type="text" id="user_address1" name="user_address" value ="${address[0]}"  placeholder="우편번호" />
                     <button type='button' class="btn btn-primary ml-1 " style="display:inline;" onclick="execPostCode();">우편번호</button>
                 <input class="form-control mt-1" type="text" id="user_address2" name="user_address" value ="${address[1]}"  placeholder="주소" />
             </div>
         </div>
         <div class="modal-footer">
             <button class="btn btn-primary" type="button"  onclick="updatecheck()">완 료</button>
			<button class="btn btn-primary" type="button" onclick = "location.href='/main'">취 소</button>
			<button class="btn btn-primary" type="button"  onclick="location.href='/delete'">회원탈퇴</button>  
         </div>
     </form>
 </div>
                                         
		 <!-- 준혁님 것 -->
		 <%-- 	<form action="/myinform" method="post" >
			<input class="form-control" type="hidden" id="user_no" name="user_no" value="${login_info.user_no}" />
				<div class="form-group has-feedback">
			<h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">		<label class="control-label" for="user_email">이메일</label> </h5>
					<input class="form-control" type="text" id="user_email" name="user_email" value="${login_info.user_email}" readonly="readonly"/>
				</div>
				<div class="form-group has-feedback">
				<h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">	<label class="control-label" for="user_pw">비밀번호</label> </h5>
					<input class="form-control" type="password" id="user_pw_u" name="user_pw_u" value="${login_info.user_pw}"  readonly="readonly"/>
			</div>
			<div class="form-group has-feedback">
		<h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">			<label class="control-label" for="user_pw">변경비밀번호</label> </h5>
					<input class="form-control" type="password" id="user_pw" name="user_pw"  />
			<h6>(8~16자내에서 영문 대 소문자, 숫자, 특수문자를 전부 사용하세요.)</h6>	</div>
			<div class="form-group has-feedback">
		<h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">			<label class="control-label" for="user_pw">변경비밀번호확인</label> </h5>
					<input class="form-control" type="password" id="user_pw_c" name="user_pw_c"  />
			<h6>(8~16자내에서 영문 대 소문자, 숫자, 특수문자를 전부 사용하세요.)</h6>	</div>
				<div class="form-group has-feedback">
		<h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">			<label class="control-label" for="user_name">성명</label> </h5>
					<input class="form-control" type="text" id="user_name" name="user_name" value="${login_info.user_name}"/>
			<h6>(한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가))</h6>	</div>
				<div class="form-group has-feedback">
		<h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">			<label class="control-label" for="user_phone">전화번호</label> </h5>
					<input class="form-control" type="text" id="user_phone" name="user_phone" value="${login_info.user_phone}"/>
			<h3>-를 포함하여 적어주세요!!!!</h3>	</div>
				<div class= "form-group has-feedback">	
					<c:set var="imsi" value="${login_info.user_address}"/>
					<c:set var="address" value="${fn:split(imsi,',')}"/>		
					<label class="control-label" for="user_address">주소</label>
					<input class="form-control" type="text" id="user_address1" name="user_address" value ="${address[0]}"  placeholder="우편번호" />
					<button type='button' onclick="execPostCode();">우편번호</button>
					<input class="form-control" type="text" id="user_address2" name="user_address" value ="${address[1]}"  placeholder="주소" />
			</div>		 <br>
				<div class="form-group has-feedback">

					<button type="button" onclick="updatecheck()">회원정보수정</button>
					<button type="button" onclick = "location.href='/main'">취소</button>
					<button type="button"  onclick="location.href='/delete'">회원탈퇴</button>
				</div>
				
			</form> --%>
			
		
</div>
</div>
	<script src="adminassets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="adminassets/js/bootstrap.bundle.min.js"></script>
	<script src="adminassets/js/main.js"></script>

	</body>
	
</html>