<%@page import="notice.NoticeVO"%>
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
	function edit(){
        var modifyform = document.modifyform;
        document.getElementById('exampleFormControlTextarea1').value = CKEDITOR.instances.exampleFormControlTextarea1.getData();       
        modifyform.submit();
        
    }
	</script>
	

	<style>
		.dropdown-menu{
			min-width: 8rem;
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
							<form name="modifyform" action="/noticemodify" method="post" enctype="multipart/form-data" >
							
                                <div class="input-group mb-3" style="border-color: black">
                              	  <span class="input-group-text" id="basic-addon1">제 목</span>
                                    <input style="width:100px;" type="text" class="form-control" value="${modifynotice.notice_title}" name="notice_title">
                                </div>
                            	
                            	
	                            	<div class="input-group mb-3" id="target">
		                            	<c:if test="${modifynotice.notice_file ne '' && modifynotice.notice_file ne null}">
		                            		<span class="input-group-text" id="basic-addon1"><i class="fas fa-upload"></i></span>
		                                    <span class="input-group-text" id="basic-addon1" style="background-color:#F5F5F5;"><a href="/notice/${modifynotice.notice_file}" download > ${modifynotice.notice_file} </a></span>
		                                    <span class="input-group-text" id="basic-addon1"><a href='javascript:void(0);' onclick="script:fileCheck()"><i class="fas fa-times"></i></a></span>
		                                    <input type="hidden" id="notice_file" name="notice_file" value="${modifynotice.notice_file}">
		                                    <input type="hidden" id="notice_no" name="notice_no" value="${modifynotice.notice_no}">
		                                </c:if>
		                                <c:if test="${modifynotice.notice_file eq null || modifynotice.notice_file eq ''}">
		                              	  <span class="input-group-text" id="basic-addon1"><i class="fas fa-upload"></i></span>
		                                  <input type="hidden" id="notice_no" name="notice_no" value="${modifynotice.notice_no}">
		                                  <input type="file" class="form-control" id="inputGroupFile01" name="uploadfile" id="uploadfile">
		                                </c:if>
	                                </div>
                            	
                            	
                            
                            	
                            	<textarea class="form-control" id="exampleFormControlTextarea1"rows="10" name="notice_desc">${modifynotice.notice_desc}</textarea>
                               
							<br>
							<div>
									<input style="float:right;" type='button' value="취소" OnClick="script:location.replace('/noticelist')" class="btn btn-primary">
									<input style="float:right;" type='button' onclick="edit()" value="수정" class="btn btn-primary me-2"> 
									
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

    <script src="adminassets/vendors/ckeditor/ckeditor.js"></script>
		
  
   
	<script type="text/javascript">
	 CKEDITOR.replace('exampleFormControlTextarea1'
	                , {height: 500                                                  
	                 });
	</script>
	<script>
	function fileCheck() {
		 if (confirm("기존 첨부파일을 삭제하시겠습니까?") == true){    //확인
			 $("#target").html("<span class='input-group-text' id='basic-addon1'><i class='fas fa-upload'></i></span>" + 
                   			 "<input type='hidden' id='notice_no' name='notice_no' value='${modifynotice.notice_no}'>" + 
           					 "<input type='file' class='form-control' id='inputGroupFile01' name='uploadfile'>");
		 }else{   //취소
		     return;
		 }
	}
	
	</script>
	
	
	
    <script src="adminassets/js/main.js"></script>
    

    
  </body>

</html>