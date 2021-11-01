<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
#tooltip {
    width: 800px;
    background: #f3f3f3;
    border: 1px solid #d8d8d8;
    text-align: center;
    
}
#tooltip div {
    position: relative;
    display: inline-block;
    z-index: 6;
}

span {
    display: block;
    width: 87px;
    padding: 2px 16px;
    cursor: pointer;
}
.tooltip_box {
  display: none;
  position: absolute;
  width: 88px;
  padding: 8px;
  left: 0px;
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;  
  border-radius: 8px;
  background: #333;
  color: #fff;
  font-size: 14px;
}

.tooltip_box:after {
  position: absolute;
  bottom: 100%;
  left: 50%;
  width: 0;
  height: 0;
  margin-left: -10px;
  border: solid transparent;
  border-color: rgba(51, 51, 51, 0);
  border-bottom-color: #333;
  border-width: 10px;
  pointer-events: none;
  content: " ";
}

span:hover + p.tooltip_box {
  display: block;
  

}
</style>
<script>
$(document).ready(function(){
	$("#more_list_btn").on("click", function(){
		$.ajax({
			type:"post",
			url:"/morerecipelist",
			data: {"number": $("#number").val(), "emotion":$("#emotion").val(), "nation":$("#nation").val(), "cate":$("#cate").val(), "type":$("#type").val(), "search":$("#search").val()},
			success: function(serverdata){
				const data=$.trim(serverdata);
				if(data.length != 0){
					for(var i=0 ; i<serverdata.length ; i++){
						if(serverdata[i].recipe_img.indexOf("https")!= -1){
							
							$("#more_list").append("<tr>"+
							"<td><a href='/recipedetail?no=" + serverdata[i].recipe_no + "'><img src='" + serverdata[i].recipe_img + "' height='200' width='200'></a></td></tr>"+
							"<tr><td><a href='/recipedetail?no=" + serverdata[i].recipe_no + "'>" + serverdata[i].recipe_title + "</a></td>"+
							"</tr>");
						}else{
							$("#more_list").append("<tr>"+
							"<td><a href='/recipedetail?no=" + serverdata[i].recipe_no + "'><img src='/upload/" + serverdata[i].recipe_img + "' height='200' width='200'></a></td>"+
							"<td><a href='/recipedetail?no=" + serverdata[i].recipe_no + "'>" + serverdata[i].recipe_title + "</a></td>"+
							"</tr>");
						}
					}
					$("#number").val( parseInt($("#number").val()) + 6 );
					
				}
				else if(data.length == 0){
					alert("게시글이 더이상 없습니다.");
				}
				
			},
			error:function(request, status, error){

				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
	})
})
</script>

</head>
<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
<body>
<div id="main">
<div class="page-heading" style="margin-top:90px;">	
                <div class="page-title">
                    <div class="row" >
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>레시피 게시판</h3>
                        </div>
                    </div>
                </div>
               
<!-- 필터 -->	
<div class="col-lg-7 mx-9 text-center mb-8" style="background-color:#fff;border-radius:2rem;padding:1.2rem;">
<form id="condition" name="recipelist_page" action="/recipelist">
	<input type="hidden" name="nation" value="">
	<input type="hidden" name="cate" value="">
	<input type="hidden" name="emotion" value="">
</form>
<table border="1">
	<tr>
		<th>
			종류별<br><br>
			재료별<br><br>
			기분별
		</th>
		<td>
			<div id="tooltip">
			<div><span><a href="javascript:goSearchRecipe('nation','')">전체</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('nation','한식')">한식</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('nation','일식')">일식</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('nation','양식')">양식</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('nation','중식')">중식</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('nation','기타')">기타</a></span></div>
			</div>
			<div id="tooltip">
			<div><span><a href="javascript:goSearchRecipe('cate','')">전체</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('cate','육류')">육류</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('cate','채소류')">채소류</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('cate','해물류')">해물류</a> </span></div>
			<div><span><a href="javascript:goSearchRecipe('cate','달걀유제품')">달걀/유제품</a></span></div>
			<div><span><a href="javascript:goSearchRecipe('cate','기타')">기타</a></span></div>
			</div>
			<div id="tooltip">
				<div><span><a href="javascript:goSearchRecipe('emotion','')">전체</a></span></div>
				
				<div><span><a href="javascript:goSearchRecipe('emotion','좋음')">😀</a></span>
				<p class="tooltip_box">기분 좋은 날엔 손이 조금 가더라도 근사한 음식을 해먹어봐요!</p></div>
				
				<div><span><a href="javascript:goSearchRecipe('emotion','입맛없음')">😐</a></span>
				<p class="tooltip_box">입맛이 없을 땐 입맛을 돋궈주는 상큼한 음식을 먹어봐요</p></div>
				
				<div><span><a href="javascript:goSearchRecipe('emotion','우울')"> 😥</a></span> 
				<p class="tooltip_box">우울함엔 마그네슘, 비타민 B, 엽산 등이 풍부한 음식을 추천드려요!</p></div>
				
				<div><span><a href="javascript:goSearchRecipe('emotion','화남')">🤬</a></span>
				<p class="tooltip_box">화가 나는 날엔  비타민 D, 오메가 3 등이 들어간 음식을 먹어봐요! 또한, 매운음식은 아드레날린과 엔도르핀을 분비합니다.</p></div>
				
				<div><span><a href="javascript:goSearchRecipe('emotion','아픔')">😷</a></span>
				<p class="tooltip_box">아플 땐 든든한 고기류나 염분이 많지 않은 속편한 음식을 먹어보세요</p></div>
			</div>
			
		</td>
	</tr>

</table>

<!-- 게시물 띄우기 + 검색 -->
<ul class = "recipelist">
<li>
<table id ="more_list" border="1" >
	<c:forEach items="${recipelist_search }" var="recipe">
				<tr>
			<td><a href="/recipedetail?recipe_no=${recipe.recipe_no }">

			<c:set var="recipe_img" value="${recipe.recipe_img }"/>
			<c:if test="${fn:contains(recipe_img, 'https')}">
				<img src="${recipe.recipe_img }" height="200" width="200">
			</c:if>
			<c:if test="${not fn:contains(recipe_img, 'https')  }">
				<img src="/upload/${recipe.recipe_img }" height="200" width="200">
			</c:if>
			</a>
			</td>
		</tr>
			<tr>
			<td><a href="/recipedetail?recipe_no=${recipe.recipe_no }">${recipe.recipe_title }</a></td>
		</tr>
	</c:forEach>
	

</table>
</li>
</ul>
<!-- 글 더보기 기능 -->

<button id="more_list_btn" class="btn btn-lg btn-outline-primary mt-3">더보기</button>
<input type="hidden" id="number" value="12">
 <div id = "list">
 <div class="page-heading" style="margin-top:0px; background-color: #FFF;">	
<table>
<div id="more_list"></div>

</table>
</div>
</div>
<!-- 검색 -->
<form action="/recipelist" onSubmit="return form_submit()">

	<input type="hidden" name="nation" id="nation" value="${nation }">
	<input type="hidden" name="cate" id="cate" value="${cate }">
	<input type="hidden" name="emotion" id="emotion" value="${emotion }">
<select name="type" id="type">
	<option value="recipe_title">레시피 제목</option>
	<option value="recipe_name">음식명</option>
	<option value="recipe_ingredient">재료명</option>
</select>
<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                      <div class="row gx-1 gy-1 align-items-center">
                        <div class="col">
                          <div class="input-group-icon"><i class="fas fa-utensils text-danger input-box-icon"></i>
                            <input type="search" class="form-control input-box form-foodwagon-contro" id="search" name="search" value="${search }" />
                          </div>
                        </div>
<input type="submit" class="btn btn-lg btn-outline-primary mt-2" value="검색">
</div>
</div>

</form>


<!-- 로그인 하지 못하면 글 작성 버튼 안보이도록 -->
<c:if test="${not empty login_info.user_email }">
	<li style="list-style: none"><a class="btn" href="/recipewrite">작성</a></li>
</c:if>
</div>

<script src="adminassets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="adminassets/js/bootstrap.bundle.min.js"></script>
	<script src="adminassets/js/main.js"></script>
	 </div>
 </div>
</body>
<script>
function goSearchRecipe(kinds, val){
	$("#condition [name='emotion']").val("${emotion}")
	$("#condition [name='cate']").val("${cate}")
	$("#condition [name='nation']").val("${nation}")
	$("#condition [name='" + kinds + "']").val(val);
	$("#condition").submit();
}


function form_submit(){
	if($("#search").val().length > 1){
		return true;
	}
	else {
		alert("두 글자 이상 검색할 수 있습니다!")
		return false;
	}
}

</script>

     <!-- ============================================-->
      <!-- <section> begin ============================-->
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
      <!-- <section> close ============================-->
      <!-- ============================================-->
</html>