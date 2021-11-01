<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오늘 뭐 해먹지? : MY RECIPE</title>

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

	<script>
		/* 비번, 이름 정규식 체크 */
		const regex = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		const regex2 = /^[가-힣a-zA-Z]+$/;
	</script>
	
	<script>
	/* 레시피 분류 */
	var nation = ['all', 'korea', 'japan', 'western', 'china'];
	$(document).ready(function(){
		$("#nation a").each(function(index, item){
				$("#" + nation[index]).on("click", function(){
					text = $("#" + nation[index]).data("value");
					$.ajax({
						url : "/myrecipenation",
						type : "post",
						data : {"recipe_nation" : text},
						dataType : "json", 
						success : function(answer){
							if(answer.length == 0){
								$("#dis").empty();
							}else{
								for(var i=0; i<answer.length; i++){
									var length = answer.length;
									if(i == 0){
										$("#dis").empty();
									}
									if(i < 8){
										$("#dis").append("<div class='col-sm-6 col-md-4 col-lg-3 h-100 mb-5'>" + 
									              "<div class='card card-span h-100 text-white rounded-3' style='margin-bottom:0rem;'>" + 
							              "<a href='javascript:void(0);' onclick='detail(" + answer[i].recipe_no + ");'>" + 
							              "<img title='상세 페이지로 이동' class='img-fluid rounded-3' src='mainassets/assets/img/gallery/" + answer[i].recipe_img + "' alt='...' style='width:333px;height:283px;object-fit: cover;' /></a>" + 
							                "<div class='card-body p-2'>" + 
							                  "<div class='d-flex align-items-center mb-1'>" + 
							                    "<div class='flex-1'>" + 
							                      "<h5 class='mb-0 fw-bold text-1000'>" + answer[i].recipe_title + "</h5>" + 
							                      "<div><span style='color:black;'>" + answer[i].recipe_name + "</span></div>" + 
							                      "<span class='text-primary fs--1' style='justify-content: flex-end;'>조회수</span>" + 
							                      "<span class='mb-0 text-primary'>" + answer[i].recipe_hits + "</span>" + 
							                    "</div>" + 
							                  "</div>" + 
							                "</div>" + 
							              "</div>" + 
							            "</div>");
									}else{
										$("#dis").append("<div class='col-sm-6 col-md-4 col-lg-3 h-100 mb-5 hide' style='display:none;'>" + 
									              "<div class='card card-span h-100 text-white rounded-3' style='margin-bottom:0rem;'>" + 
									              "<a href='javascript:void(0);' onclick='detail(" + answer[i].recipe_no + ");'>" + 
									              "<img title='상세 페이지로 이동' class='img-fluid rounded-3' src='mainassets/assets/img/gallery/" + answer[i].recipe_img + "' alt='...' style='width:333px;height:283px;object-fit: cover;' /></a>" + 
									                "<div class='card-body p-2'>" + 
									                  "<div class='d-flex align-items-center mb-1'>" + 
									                    "<div class='flex-1'>" + 
									                      "<h5 class='mb-0 fw-bold text-1000'>" + answer[i].recipe_title + "</h5>" + 
									                      "<div><span style='color:black;'>" + answer[i].recipe_name + "</span></div>" + 
									                      "<span class='text-primary fs--1' style='justify-content: flex-end;'>조회수</span>" + 
									                      "<span class='mb-0 text-primary'>" + answer[i].recipe_hits + "</span>" + 
									                    "</div>" + 
									                  "</div>" + 
									                "</div>" + 
									              "</div>" + 
									            "</div>");
									}
		
							}			
						}
							
						if(answer.length > 8){
							$("#div_add").html("<a class='btn btn-lg btn-primary' href='#' id='add'>더보기 <i class='fas fa-chevron-right ms-2'> </i></a>");
						}else{
							$("#div_add").empty();
						}
						
						$("#add").on("click", function(){
							$(".hide").attr("style", "display:block");
							$("#div_add").empty();
						});
						
	
							
					}
				});
			});
		
		});
	
	}); 
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
        <div id="sidebar" class="active" style="z-index:3;">
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

                        <li class="sidebar-item active">
                            <a href="/myrecipelist" class='sidebar-link'>
                                <i class="fas fa-utensils"></i>
                                <span>내가 작성한 레시피</span>
                            </a>
                        </li>

                        <li class="sidebar-item">
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
      <section id="testimonial" style="padding-top:4rem;">
        <div class="container">
          <div class="row h-100">
            <div class="col-lg-7 mx-auto text-center mb-4">
              <h5 class="fw-bold fs-3 fs-lg-5 lh-sm mb-1">내가 작성한 레시피 목록</h5>
            </div>
          </div>
          
          <div class="list-group list-group-horizontal-sm mb-1 text-center" id="nation" style="position:relative;z-index:1;">
              <a class="list-group-item list-group-item-action active" id="all" href="#" data-value="전체" role="tab" data-bs-toggle="list">전 체</a>
              <a class="list-group-item list-group-item-action" id="korea" href="#" data-value="한식" role="tab" data-bs-toggle="list">한 식</a>
              <a class="list-group-item list-group-item-action" id="japan" href="#" data-value="일식" role="tab" data-bs-toggle="list">일 식</a>
              <a class="list-group-item list-group-item-action" id="western" href="#" data-value="양식" role="tab" data-bs-toggle="list">양 식</a>
              <a class="list-group-item list-group-item-action" id="china" href="#" data-value="중식" role="tab" data-bs-toggle="list">중 식</a>
          </div>
          <br>
          
          <div class="row gx-2" id="dis">
          	<c:forEach items="${myrecipelist }" var="myrecipelist" varStatus="status">
          	
          	<c:if test="${status.index < 8}">
            <div class="col-sm-6 col-md-4 col-lg-3 h-100 mb-5">
              <div class="card card-span h-100 text-white rounded-3" style="margin-bottom:0rem;">
              <a href="javascript:void(0);" onclick="detail('${myrecipelist.recipe_no}');">
          		<img title="상세 페이지로 이동" alt="오류" class="img-fluid rounded-3" src="mainassets/assets/img/gallery/${myrecipelist.recipe_img }" style="width:333px;height:283px;object-fit: cover;" />
              </a>
             
                <div class="card-body p-2 " >
                  <div class="d-flex align-items-center mb-1">
                    <div class="flex-1">
                      <h5 class="mb-0 fw-bold text-1000">${myrecipelist.recipe_title }</h5>
                      <div><span style="color:black;">${myzzimrecipelist.recipe_name }</span></div>
                      <span class="text-primary fs--1" style="justify-content: flex-end;">조회수</span>
                      <span class="mb-0 text-primary"> ${myrecipelist.recipe_hits}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            </c:if>
            
            <c:if test="${status.index > 7}">
            <div class="col-sm-6 col-md-4 col-lg-3 h-100 mb-5 hide" style="display:none;">
              <div class="card card-span h-100 text-white rounded-3" style="margin-bottom:0rem;">
              <a href='javascript:void(0);' onclick="detail('${myrecipelist.recipe_no}');">
              <img class="img-fluid rounded-3 h-100" src="mainassets/assets/img/gallery/${myrecipelist.recipe_img }" alt="..." />
              </a>
            
                <div class="card-body p-2 " >
                  <div class="d-flex align-items-center mb-1">
                    <div class="flex-1">
                      <h5 class="mb-0 fw-bold text-1000">${myrecipelist.recipe_title }</h5>
                      <div><span style="color:black;">${myzzimrecipelist.recipe_name }</span></div>
                      <span class="text-primary fs--1" style="justify-content: flex-end;">조회수</span>
                      <span class="mb-0 text-primary"> ${myrecipelist.recipe_hits}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            </c:if>
            </c:forEach>
          </div>
          
          <c:if test="${fn:length(myrecipelist) > 8}">
            	<div class="col-12 d-flex justify-content-center" id="div_add"> 
            		<a class="btn btn-lg btn-primary" href="#" id="add">더보기 <i class="fas fa-chevron-right ms-2"></i></a>
            	</div>
         	</c:if>
        </div>
      </section>
            	

               <section class="py-0 pt-7 bg-1000">

		        <div class="container">
		
		          <hr class="border border-800" />
		          <div class="row flex-center pb-3">
		            <div class="col-md-6 order-0">
		              <p class="text-200 text-center text-md-start">All rights Reserved &copy; Your Company, 2021</p>
		            </div>
		            <div class="col-md-6 order-1">
		              <p class="text-200 text-center text-md-end"> Made with
		                &nbsp;by&nbsp;<a class="text-200 fw-bold" href="/main" target="_blank">multicampus </a>
		              </p>
		            </div>
		          </div>
		        </div><!-- end of .container-->
		
		      </section>
      
        </div>
    </div>
    <script src="adminassets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="adminassets/js/bootstrap.bundle.min.js"></script>

    <script src="adminassets/js/main.js"></script>
    
	<script>
			/* 더보기 기능 */
			$("#add").on("click", function(){
				$(".hide").attr("style", "display:block");
				$("#div_add").empty();
			});
			
			/* 레시피 클릭했을때 해당 레시피 상세로 이동 */
			function detail(recipe_no){
				var result = confirm("해당 레시피로 이동하시겠습니까?");
				if(result){
					location.href = "http://localhost:9009/recipedetail?recipe_no=" + recipe_no;
				}
			}
			
	</script>
    
    
    
</body>

</html>