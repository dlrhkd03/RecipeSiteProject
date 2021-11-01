<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html>
<html>

<head>

<script type="text/javascript">
$(document).ready(function lo() {
	$("#btn_login").on("click", function login(){
		if($('#email').val() ==''){
			alert('아이디를 입력하세요!');
			$('#email').focus();
			return;
		} else if($('#pw').val() ==''){
			alert('비밀번호를 입력하세요!');
			$('#pw').focus();
			return;
		}
		
		$.ajax({
			type: 'post',
			url:'header',
			data:{ email:$("#email").val(), pw:$("#pw").val()},
			success: function(server){
				if(server=="true"){
					location.reload();
				}else{
					alert("아이디나 비밀번호가 일치하지 않습니다.");
					$("#email").focus();
				}
			},
			error: function(req, text) {
				 alert(text + ': ' + req.status);
		 	}
		});
	})
	/* email 텍스트에서 엔터치면 password 포커스 */
	$("#email").keydown(function(key){
		if(key.keyCode==13){
			$("#pw").focus();
		}
	})
	
	/* password에서 엔터치면 로그인 버튼 클릭 */
	$("#pw").keydown(function(key){
		if(key.keyCode==13){
			$("#btn_login").click();
		}
	})
});

$(document).ready(function(){
	$("#btn_logout").on("click", function(){
		$.ajax({
			type:"post",
			url:"logout",
			success:function(){
				location.reload();
			}
		})
	});
});



</script>


</head>


  <body>
     
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top" data-navbar-on-scroll="data-navbar-on-scroll" style="z-index:2;">
        <div class="container"><a class="navbar-brand d-inline-flex" href="/main"><img width="340" height="70" class="d-inline-block" src="imgs/logo.png" alt="logo" /></a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"> </span></button>
          <div class="collapse navbar-collapse border-lg-0 my-2 mt-lg-0" id="navbarSupportedContent">
            <div class="ms-auto">
				<div class="btn-group"><a href="#"><i class="fas fa-comment-medical fa-2x text-warning input-box-icon"></i></a></div>&emsp;
              <button class="btn btn-white shadow-warning text-warning" type="button" onclick="location.href='/noticelist'">공지사항</button>
              <button class="btn btn-white shadow-warning text-warning" type="button" onclick="location.href='/recipelist'">레시피 게시판</button>&emsp;&emsp;
              <div class="btn-group" >
              <c:if test="${empty login_info }">
              <div class="btn-group">
              	<input class="input-box form-foodwagon-control" id="email" type="text" placeholder="아이디" />&emsp;
              	<input class="input-box form-foodwagon-control" id="pw" type="password" placeholder="패스워드" />
             	 <button id="btn_login" class="btn btn-white shadow-warning text-warning" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="fas fa-user me-2"></i>로그인</button>
             	 <button class="btn btn-white shadow-warning text-warning" type="button" onclick = "location.href='/email'">회원가입</button>
             	 </div>
              </c:if>
              <c:if test="${!empty login_info }">
              <div class="dropdown">
              	   <button class="btn btn-white shadow-warning text-warning" type="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user me-2"></i>${login_info.user_name }님</button>
				  <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuButton2">
				  	<c:if test="${login_info.user_no == 1 }">
				  		<li><a class="dropdown-item" href="/usermanager">마이페이지</a></li>
				  	</c:if>
				  	<c:if test="${login_info.user_no != 1 }">
				  		<li><a class="dropdown-item" href="/myzzimrecipelist?${login_info.user_no }">마이페이지</a></li>
				  	</c:if>
				    
				    <li><a class="dropdown-item" href="#" id="btn_logout">로그아웃</a></li>
				  </ul>
			  </div>
              </c:if>
              </div>
          	</div>
          </div>
        </div>
      </nav>




    
  </body>

</html>