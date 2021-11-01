<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"  %>
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

	
	<script>
	function deleteCheck() {
		 if (confirm("정말로 삭제하시겠습니까?") == true){    //확인
		     location.replace('/noticedelete?no=${notice_one.notice_no}');
		 }else{   //취소
		     return;
		 }
	}
	</script>
	
	
	<style>
		.dropdown-menu{
			min-width: 8rem;
		}
		.input-group-text{
			background-color: #F5F5F5;
		}
		.form-control:disabled{
			background-color: white;
			color:black;
		}
		div.editable {
			padding : 10px;
		    height: 400px;
		    border: 1px solid #dcdcdc;
		    overflow-y: auto;
		}
		.btn{
			font-weight: 700;
		
		}
		
	</style>
	
</head>


  <body>
	
    <!-- ===============================================-->
    <!--    Main Content-->
    <!-- ===============================================-->
    <main class="main" id="top">
     
     <jsp:include page="/WEB-INF/views/main/header.jsp"/>
	
      <section class="py-4 overflow-hidden">
        <div class="container">
          <div class="row h-100">  
            <div class="col-12">

            <div class="page-heading" style="margin-top:90px;">
                <div class="page-title">
                    <div class="row" >
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>공지 사항</h3>
                        </div>
                    </div>
                </div>
                <section class="section" style="padding-top:1rem;">
                    <div class="card">
                        <div class="card-body">

							<form name="modifyform" action="/noticmodify" method="post" enctype="multipart/form-data" >
                                <div class="input-group mb-3" style="border-color: black">
                                    <input style="width:100px;" type="text" class="form-control" value="${notice_one.notice_title}" id="disabledInput" disabled>
                                    <span class="input-group-text" id="basic-addon1">${notice_one.notice_date}</span>
                                    <span class="input-group-text" id="basic-addon1">조회수 ${notice_one.notice_hits}회</span>
                                </div>
                            	
                            	<c:if test="${notice_one.notice_file ne '' && notice_one.notice_file ne null}">
	                            	<div class="input-group mb-3">
	                            		<span class="input-group-text" id="basic-addon1"><i class="fas fa-download"></i></span>
	                                    <span class="input-group-text" id="basic-addon1"><a href="/notice/${notice_one.notice_file}" download > ${notice_one.notice_file} </a></span> 
	                                </div>
                            	</c:if>
                            	<div class="editable" contenteditable="true">${notice_one.notice_desc}</div>
                                <%-- <textarea class="form-control" id="exampleFormControlTextarea1"rows="10" disabled>${notice_one.notice_desc}</textarea> --%>
                               
							<br>
							<div>
								
							 <c:forEach items="${notice_list}" var="notice" varStatus="status">
								<c:if test="${notice_one.notice_no == notice.notice_no}">
									<c:set var="before1" value="${status.index -1}" />
									<c:set var="after1" value="${status.index + 1}" />
									
									<c:set var="before" value="${notice_list[before1].notice_no}" />
									<c:set var="after" value="${notice_list[after1].notice_no}" />
									
								</c:if>
								
								<c:if test="${status.first}">
									<c:set var="begin" value="${notice.notice_no}" />
								</c:if>
								
								<c:if test="${status.last}">
									<c:set var="end" value="${notice.notice_no}" />
								</c:if>
							</c:forEach>
							
								<c:if test="${begin < notice_one.notice_no}">
									<a href="/noticedetail?no=${before}" class="btn btn-primary">이전글</a>	
								</c:if>
								<c:if test="${end > notice_one.notice_no}">
									<a href="/noticedetail?no=${after}" class="btn btn-primary">다음글</a>
								</c:if>
								<a style="float:right;" href="/noticelist" class="btn btn-primary">목록보기</a>
								<c:if test="${login_info.user_no < 11}">
									<a style="float:right;" id="deletebtn"  onclick="script:deleteCheck()" class="btn btn-primary ms-1 me-3"> 삭제하기 </a>
									<a style="float:right;" id="modifybtn" onclick="script:location.replace('/noticemodify?no=${notice_one.notice_no}')" class="btn btn-primary">수정하기</a>
									
                        		</c:if>
                        	
                        	</div>
                        	</form>
                        </div>
                    </div>

                </section>
            </div>
              

		       </div>
		    </div><!-- end of .container -->
		</div>
      </section>
      <!-- <section> close ============================
      ============================================ -->

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


    </main>
    <!-- ===============================================-->
    <!--    End of Main Content-->
    <!-- ===============================================-->
	<script src="adminassets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="adminassets/js/bootstrap.bundle.min.js"></script>
	
    <script src="adminassets/js/main.js"></script>
    
    <script>
	$('.editable').each(function(){
	    this.contentEditable = false;
	});
	</script>

    
  </body>

</html>