<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
.modal{ position:absolute; width:50%; height:50%; background: rgba(255,255,255,1); top:5; left:10;display:none;  }
.modalbox{ border: 1px solid; top: 10; bottom: 10;}

#tooltip {
    width: 600px;
    background: #f3f3f3;
    border: 1px solid #d8d8d8;
    text-align: center;
}
#tooltip div {
    position: relative;
    display: inline-block;
}

span {
    display: block;
    width: 37px;
    padding: 2px 16px;
    cursor: pointer;
}
.tooltip_box {
  display: none;
  position: absolute;
  width: 200px;
  padding: 8px;
  left: -73px;
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
</head>
<body>
<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
<%
String[] ingredient = {"소고기","돼지고기","닭고기","양고기","무슨고기"};
%>
<!-- 1. recipe_title, recipe_name, 사진, recipe_date, recipe_emotion  -->
<form action="recipemodify" method="post" enctype="multipart/form-data" name="frm" onsubmit="return send()">
<input type="hidden" name="recipe_no" value="${recipe.recipe_no }">
<table border="1">
	<!-- 종류 -->
	<tr>
		<th rowspan="2">분류</th>
		<td colspan="3">
		<input type="radio" name="recipe_cate" id="육류" value="육류">육류
		<input type="radio" name="recipe_cate" id="해물류" value="해물류">해물류
		<input type="radio" name="recipe_cate" id="채소류" value="채소류">채소류
		<input type="radio" name="recipe_cate" id="달걀유제품류" value="달걀유제품류">달걀/유제품류
		<input type="radio" name="recipe_cate" value="기타">기타
		</td>
	</tr>
	<tr>
		<td colspan="3">
		<input type="radio" name="recipe_nation" id="한식" value="한식">한식
		<input type="radio" name="recipe_nation" id="일식" value="일식">일식
		<input type="radio" name="recipe_nation" id="양식" value="양식">양식
		<input type="radio" name="recipe_nation" id="중식" value="중식">중식
		<input type="radio" name="recipe_nation" value="기타">기타
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td colspan="3"><input type="text" name="recipe_title" id="recipe_title" value="${recipe.recipe_title }"></td>
	</tr>
	<tr>
		<th>썸네일 사진</th>
		<td colspan="3">
		<input type="file" name="recipe_img" id="recipe_img" accept="image/*" onchange="view(event, 'img');"><br>
		<table border ="1">
			<tr>
			<th>기존 이미지</th>
			<td>
			<c:set var="recipe_img" value="${recipe.recipe_img }"/>
			<c:if test="${fn:contains(recipe_img, 'https')}">
				<img src="${recipe.recipe_img }" height="200" width="200">
			</c:if>
			<c:if test="${not fn:contains(recipe_img, 'https')  }">
				<img src="/upload/${recipe.recipe_img }" height="200" width="200">
			</c:if>
			</td>
			<input type="hidden" name="img" value="${recipe.recipe_img }">
			<th>변경 이미지</th>
			<td><div id="img"></div></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<th>음식 이름</th>
		<td colspan="3"><input type="text" name="recipe_name" id="recipe_name" value="${recipe.recipe_name }"></td>
	</tr>
	<tr>
		<th>음식 설명</th>
		<td colspan="3"><textarea rows="5" cols="50" id="recipe_desc" name="recipe_desc">${desc.recipe_desc }</textarea></td>
		
	</tr>
	<!-- 분류 -->
<!-- 팝업창 재료 -->
	<tr>
		<th>재료</th>
		<td colspan="3">
		<div>
			<button class="openingred" type="button" id="ingredient">재료 선택</button>
			<div class="modal" >
				<div class="modalbox">
				<!-- 보낼것 2. 재료 -->
<!-- Tab을 구성할 영역 설정-->
<div style="margin:10px;">
<!-- Tab 영역 태그는 ul이고 클래스는 nav와 nav-tabs를 설정한다. -->
<ul class="nav nav-tabs">
<!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
<li><a href="#grains" data-toggle="tab">곡물류</a></li>
<li><a href="#noodles" data-toggle="tab">면/만두류</a></li>
<li><a href="#vegetables" data-toggle="tab">채소류</a></li>
<li><a href="#fruits" data-toggle="tab">과일류</a></li>
<li><a href="#meats" data-toggle="tab">육류</a></li>
<li><a href="#eggs" data-toggle="tab">달걀/유제품류</a></li>
<li><a href="#seafoods" data-toggle="tab">해물류</a></li>
<li><a href="#spices" data-toggle="tab">양념류</a></li>
<li><a href="#drinks" data-toggle="tab">음료/주류</a></li>
</ul>
<!-- Tab이 선택되면 내용이 보여지는 영역이다. -->
<!-- 태그는 div이고 class는 tab-content로 설정한다. -->
<div class="tab-content">
<!-- 각 탭이 선택되면 보여지는 내용이다. 태그는 div이고 클래스는 tab-pane이다. -->
<!-- active 클래스는 현재 선택되어 있는 탭 영역이다. -->
<div class="tab-pane fade in active" id="grains">
	<c:forEach items="${ingredvo.grains }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
<!-- id는 고유한 이름으로 설정하고 tab의 href와 연결되어야 한다. -->
<!-- fade 클래스는 선택적인 사항으로 트랜지션(transition)효과가 있다.
<!-- in 클래스는 fade 클래스를 선언하여 트랜지션효과를 사용할 때 in은 active와 선택되어 있는 탭 영역의 설정이다. -->
<div class="tab-pane fade" id="noodles">
	<c:forEach items="${ingredvo.noodles }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
<div class="tab-pane fade" id="vegetables">
	<c:forEach items="${ingredvo.vegetables }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
<div class="tab-pane fade" id="fruits">
	<c:forEach items="${ingredvo.fruits }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
<div class="tab-pane fade" id="meats">
	<c:forEach items="${ingredvo.meats }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
<div class="tab-pane fade" id="eggs">
	<c:forEach items="${ingredvo.eggs }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
<div class="tab-pane fade" id="seafoods">
	<c:forEach items="${ingredvo.seafoods }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
<div class="tab-pane fade" id="spices">
	<c:forEach items="${ingredvo.spices }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
<div class="tab-pane fade" id="drinks">
	<c:forEach items="${ingredvo.drinks }" var="ingred">
		<input id="${ingred }" type="checkbox" name="ingredient" value="${ingred }">${ingred }
	</c:forEach>
</div>
</div>
</div>
				<!-- 모달 박스 안에서 검색 기능을 만들 수 있을까? -->
				</div>
				<button class="closeingred" type="button">재료 저장</button>
			</div>
		</div>
		${recipe.recipe_ingredient }
		</td>
	</tr>
<!-- 감정 -->
	<tr>
		<th>이런 감정일 때 먹으면 좋아요</th>
		<td colspan="3">
		<div id="tooltip">
		<input type="radio" name="recipe_emotion" id="좋음" value="좋음"><div><span>😀</span><p class="tooltip_box">기분이 좋을 땐 손이 조금 가더라도 근사한 음식이 알맞아요</p></div>
		<input type="radio" name="recipe_emotion" id="입맛없음" value="입맛없음"><div><span>😐</span><p class="tooltip_box">입맛이 없을 땐 입맛을 돋궈주는 상큼한 음식이 알맞아요</p></div>
		<input type="radio" name="recipe_emotion" id="우울" value="우울"><div><span>😥</span><p class="tooltip_box">우울할 땐 마그네슘, 비타민 B, 엽산 등이 풍부한 음식이 알맞아요</p></div>
		<input type="radio" name="recipe_emotion" id="화남" value="화남"><div><span>🤬</span><p class="tooltip_box">화가 날 땐 비타민 D, 오메가 3 등이 들어간 음식이나, 매운음식이 알맞아요</p></div>
		<input type="radio" name="recipe_emotion" id="아픔" value="아픔"><div><span>😷</span><p class="tooltip_box">아플 땐 든든한 고기류나 염분이 많지 않은 속편한 음식이 알맞아요</p></div>
		</div>
		</td>
	</tr>
<!-- 사진 및 레시피 내용 -->
		<tr>
			<th>사진1</th>
			<td>
			<input type="file" name="recipe_img1" id="recipe_img1" accept="image/*" onchange="view(event, 'img1');"><br>
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
					<c:set var="recipe_img1" value="${img.recipe_img1 }"/>
					<c:if test="${fn:contains(recipe_img1, 'https')}">
						<img src="${img.recipe_img1 }" height="200" width="200">
					</c:if>
					<c:if test="${not fn:contains(recipe_img1, 'https')  }">
						<img src="/upload/${img.recipe_img1 }" height="200" width="200">
					</c:if>
				</td>
				<input type="hidden" name="img1" value="${img.recipe_img1 }">
				<th>변경 이미지</th>
				<td><div id="img1"></div></td>
				</tr>
			</table>
			</td>
			<th>레시피 내용1</th>
			<td><textarea rows="5" cols="50" id="recipe_desc1" name="recipe_desc">${desc.recipe_desc1}</textarea></td>
		</tr>
		
		<tr>
			<th>사진2</th>
			<td>
			<input type="file" name="recipe_img2" accept="image/*" onchange="view(event, 'img2');">
	<c:if test="${!empty img.recipe_img2 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
				<c:set var="recipe_img2" value="${img.recipe_img2 }"/>
				<c:if test="${fn:contains(recipe_img2, 'https')}">
					<img src="${img.recipe_img2 }" height="200" width="200">
				</c:if>
				<c:if test="${not fn:contains(recipe_img2, 'https')  }">
					<img src="/upload/${img.recipe_img2 }" height="200" width="200">
				</c:if>
				</td>
				<input type="hidden" name="img2" value="${img.recipe_img2 }">
				<th>변경 이미지</th>
				<td><div id="img2"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img2"></div>
			</td>
			<th>레시피 내용2</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc2}</textarea></td>
		</tr>
		
		<tr>
			<th>사진3</th>
			<td>
			<input type="file" name="recipe_img3" accept="image/*" onchange="view(event, 'img3');">
	<c:if test="${!empty img.recipe_img3 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
					<c:set var="recipe_img3" value="${img.recipe_img3 }"/>
					<c:if test="${fn:contains(recipe_img3, 'https')}">
						<img src="${img.recipe_img3 }" height="200" width="200">
					</c:if>
					<c:if test="${not fn:contains(recipe_img3, 'https')  }">
						<img src="/upload/${img.recipe_img3 }" height="200" width="200">
					</c:if>
				</td>
				<input type="hidden" name="img3" value="${img.recipe_img3 }">
				<th>변경 이미지</th>
				<td><div id="img3"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img3"></div>
			</td>
			<th>레시피 내용3</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc3}</textarea></td>
		</tr>
		
		<tr>
			<th>사진4</th>
			<td>
			<input type="file" name="recipe_img4" accept="image/*" onchange="view(event, 'img4');">
	<c:if test="${!empty img.recipe_img4 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
				<c:set var="recipe_img4" value="${img.recipe_img4 }"/>
				<c:if test="${fn:contains(recipe_img4, 'https')}">
					<img src="${img.recipe_img4 }" height="200" width="200">
				</c:if>
				<c:if test="${not fn:contains(recipe_img4, 'https')  }">
					<img src="/upload/${img.recipe_img4 }" height="200" width="200">
				</c:if>
				</td>
				<input type="hidden" name="img4" value="${img.recipe_img4 }">
				<th>변경 이미지</th>
				<td><div id="img4"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img4"></div>
			</td>
			<th>레시피 내용4</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc4}</textarea></td>
		</tr>
		
		<tr>
			<th>사진5</th>
			<td>
			<input type="file" name="recipe_img5" accept="image/*" onchange="view(event, 'img5');">
	<c:if test="${!empty img.recipe_img5 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
					<c:set var="recipe_img5" value="${img.recipe_img5 }"/>
					<c:if test="${fn:contains(recipe_img5, 'https')}">
						<img src="${img.recipe_img5 }" height="200" width="200">
					</c:if>
					<c:if test="${not fn:contains(recipe_img5, 'https')  }">
						<img src="/upload/${img.recipe_img5 }" height="200" width="200">
					</c:if>
				</td>
				<input type="hidden" name="img5" value="${img.recipe_img5 }">
				<th>변경 이미지</th>
				<td><div id="img5"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img5"></div>
			</td>
			<th>레시피 내용5</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc5}</textarea></td>
		</tr>
		
		<tr>
			<th>사진6</th>
			<td>
			<input type="file" name="recipe_img6" accept="image/*" onchange="view(event, 'img6');">
	<c:if test="${!empty img.recipe_img6 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
					<c:set var="recipe_img6" value="${img.recipe_img6 }"/>
					<c:if test="${fn:contains(recipe_img6, 'https')}">
						<img src="${img.recipe_img6 }" height="200" width="200">
					</c:if>
					<c:if test="${not fn:contains(recipe_img6, 'https')  }">
						<img src="/upload/${img.recipe_img6 }" height="200" width="200">
					</c:if>
				</td>
				<input type="hidden" name="img6" value="${img.recipe_img6 }">
				<th>변경 이미지</th>
				<td><div id="img6"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img6"></div>
			</td>
			<th>레시피 내용6</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc6}</textarea></td>
		</tr>
		<tr>
			<th>사진7</th>
			<td>
			<input type="file" name="recipe_img7" accept="image/*" onchange="view(event, 'img7');">
	<c:if test="${!empty img.recipe_img7 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
					<c:set var="recipe_img7" value="${img.recipe_img7 }"/>
					<c:if test="${fn:contains(recipe_img7, 'https')}">
						<img src="${img.recipe_img7 }" height="200" width="200">
					</c:if>
					<c:if test="${not fn:contains(recipe_img7, 'https')  }">
						<img src="/upload/${img.recipe_img7 }" height="200" width="200">
					</c:if>
				</td>
				<input type="hidden" name="img7" value="${img.recipe_img7 }">
				<th>변경 이미지</th>
				<td><div id="img7"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img7"></div>
			</td>
			<th>레시피 내용7</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc7}</textarea></td>
		</tr>
		<tr>
			<th>사진8</th>
			<td>
			<input type="file" name="recipe_img8" accept="image/*" onchange="view(event, 'img8');">	
			<c:if test="${!empty img.recipe_img8 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
					<c:set var="recipe_img8" value="${img.recipe_img8 }"/>
					<c:if test="${fn:contains(recipe_img8, 'https')}">
						<img src="${img.recipe_img8 }" height="200" width="200">
					</c:if>
					<c:if test="${not fn:contains(recipe_img8, 'https')  }">
						<img src="/upload/${img.recipe_img8 }" height="200" width="200">
					</c:if>
				</td>
				<input type="hidden" name="img8" value="${img.recipe_img8 }">
				<th>변경 이미지</th>
				<td><div id="img8"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img8"></div>
			</td>
			<th>레시피 내용8</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc8}</textarea></td>
		</tr>
		<tr>
			<th>사진9</th>
			<td>
			<input type="file" name="recipe_img9" accept="image/*" onchange="view(event, 'img9');">
	<c:if test="${!empty img.recipe_img9 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
					<c:set var="recipe_img9" value="${img.recipe_img9 }"/>
					<c:if test="${fn:contains(recipe_img9, 'https')}">
						<img src="${img.recipe_img9 }" height="200" width="200">
					</c:if>
					<c:if test="${not fn:contains(recipe_img9, 'https')  }">
						<img src="/upload/${img.recipe_img9 }" height="200" width="200">
					</c:if>
				</td>
				<input type="hidden" name="img9" value="${img.recipe_img9 }">
				<th>변경 이미지</th>
				<td><div id="img9"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img9"></div>
			</td>
			<th>레시피 내용9</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc9}</textarea></td>
		</tr>
		<tr>
			<th>사진10</th>
			<td>
			<input type="file" name="recipe_img10" accept="image/*" onchange="view(event, 'img10');">
	<c:if test="${!empty img.recipe_img10 }">
			<table border ="1">
				<tr>
				<th>기존 이미지</th>
				<td>
					<c:set var="recipe_img10" value="${img.recipe_img10 }"/>
					<c:if test="${fn:contains(recipe_img10, 'https')}">
						<img src="${img.recipe_img10 }" height="200" width="200">
					</c:if>
					<c:if test="${not fn:contains(recipe_img10, 'https')  }">
						<img src="/upload/${img.recipe_img10 }" height="200" width="200">
					</c:if>
				</td>
				<input type="hidden" name="img10" value="${img.recipe_img10 }">
				<th>변경 이미지</th>
				<td><div id="img10"></div></td>
				</tr>
			</table>
	</c:if>
			<div id="img10"></div>
			</td>
			<th>레시피 내용10</th>
			<td><textarea rows="5" cols="50" name="recipe_desc">${desc.recipe_desc10}</textarea></td>
		</tr>

</table>
<!-- 저장이 완료되었습니다 함수 만들기 -->
	<input type="submit" value="저장">
	<a href="javascript:history.go(-1)">취소</a>
</form>
<script>
//재료 선택 팝업창
$(function(){
	$(".openingred").click(function(){
		$(".modal").fadeIn();
	});
	
	$(".closeingred").click(function(){
		$(".modal").fadeOut();
	})
	
})
//레시피 사진 미리보기
function view(event, img_name){
	var reader = new FileReader();
	reader.onload = function(event){
		var img = document.createElement("img"); 
		img.setAttribute("src", event.target.result);
		$("div#"+img_name).empty();
		document.querySelector("div#"+img_name).appendChild(img);
	}
	reader.readAsDataURL(event.target.files[0]);
}
//분류 체크 되었던 거 체크
var cate = document.getElementById("${recipe.recipe_cate }");
cate.setAttribute("checked", "checked");

//재료 체크 되었던 거 체크
var arr = "${recipe.recipe_ingredient }".split(",");
for(var i = 0 ; i < arr.length ; i++){
	var ingredient = document.getElementById(arr[i])
	ingredient.setAttribute("checked", "checked");
}
ingredient.setAttribute("checked", "checked");
//감정 체크되었던 거 체크
var emotion = document.getElementById("${recipe.recipe_emotion }");
emotion.setAttribute("checked", "checked");

//종류 체크되었던 거 체크
var nation = document.getElementById("${recipe.recipe_nation }");
nation.setAttribute("checked", "checked");

//정규식
function send(){
	//제목	
	const title = document.getElementById('recipe_title').value;
	const regex1 = /^.{3,}$/;
	if(regex1.test(title) == false) {
		alert("제목은 3글자 이상 작성해주세요")
		$("#recipe_title").focus();
		return false;
	}
	//썸네일 사진
	const img = document.getElementById('recipe_img').value;
	const regex6 = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/;
	if(img){
		if(!regex6.test(img)){
			alert("해당 파일은 이미지 파일이 아닙니다");
			$("#recipe_img").focus();
			return false;
		}
	}
	//음식이름
	const name = document.getElementById('recipe_name').value;
	const regex2 = /^.{1,}$/;
	const regex3 = /^[가-힣]+$/;
	if(regex2.test(name) == false) {
		alert("음식 이름은 1글자 이상 작성해주세요")
		$("#recipe_name").focus();
		return false;
	}
	else if(regex3.test(name) == false) {
		alert("음식 이름은 한글로만 작성해주세요")
		$("#recipe_name").focus();
		return false;
	}
	//음식설명
	const desc = document.getElementById('recipe_desc').value;
	const regex4 = /^.{10,}$/;
	if(regex4.test(desc) == false) {
		alert("음식 설명은 10글자 이상 작성해주세요")
		$("#recipe_desc").focus();
		return false;
	}
	//분류
	let cnt1 = 0;
	const frm = document.frm;
	for(let i=0 ; i<frm.recipe_cate.length ; i++){
		if(frm.recipe_cate[i].checked){
			cnt1++
		}
	}
	if(cnt1 == 0){
		alert("분류는 꼭 선택해주세요.");
		$("#recipe_cate").focus();
		return false;
	}
	//음식 종류
	let cnt2 = 0;
	for(let i=0 ; i<frm.recipe_nation.length ; i++){
		if(frm.recipe_nation[i].checked){
			cnt2++
		}
	}
	if(cnt2 == 0){
		alert("음식종류는 꼭 선택해주세요.");
		$("#한식").focus();
		return false;
	}
	//재료 선택
	let cnt3 = 0;
	for(let i=0 ; i<frm.ingredient.length ; i++){
		if(frm.ingredient[i].checked){
			cnt3++
		}
	}
	if(cnt3 == 0){
		alert("재료는 1개 이상 선택해주세요.");
		$("#ingredient").focus();
		return false;
	}
	//감정
	let cnt4 = 0;
	for(let i=0 ; i<frm.recipe_emotion.length ; i++){
		if(frm.recipe_emotion[i].checked){
			cnt4++
		}
	}
	if(cnt4 == 0){
		alert("감정 요소는 꼭 선택해주세요.");
		$("#좋음").focus();
		return false;
	}
	//레시피 사진1
	const img1 = document.getElementById('recipe_img1').value;
	if(img1){
		if(!regex6.test(img1)){
			alert("해당 파일은 이미지 파일이 아닙니다");
			$("#recipe_img1").focus();
			return false;
		}
	}
	//레시피 설명1
	const desc1 = document.getElementById('recipe_desc1').value;
	const regex5 = /^.{10,}$/;
	if(regex5.test(desc1) == false) {
		alert("레시피 내용1은 10글자 이상 작성해주세요.")
		$("#recipe_desc1").focus();
		return false;
	}
	alert('저장이 완료되었습니다.')
	
	return true;
}
</script>
</body>
</html>