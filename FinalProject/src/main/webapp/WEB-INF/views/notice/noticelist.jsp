<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html>
<html>

<head>

	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오늘 뭐 해먹지? : NOTICE</title>
    
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

								<table class="table table-striped" id="table1" >
								<thead >
									<tr>
										<th style="text-align: center;">번호</th>
										<th style="text-align: center;">제 목</th>
										<th style="text-align: center;">작성자</th>
										<th style="text-align: center;">날짜</th>
										<th style="text-align: center;">조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(notice_list) > 0}">
									<c:forEach items="${notice_list}" var="notice" varStatus="status">
								 		<tr>
								 			<td style="text-align: center;"><c:out value="${status.count}" /></td>
								 			<td>
								 				<i class="fas fa-bullhorn" style="color:red;"></i>&nbsp;
								 				<a href="/noticedetail?no=${notice.notice_no }">
								 				<c:out value="${notice.notice_title }"/>
												</a> 	
								 			</td>
								 			<td style="text-align: center;">관리자</td>
								 			<td style="text-align: center;"><c:out value="${notice.notice_date }"/></td>
								 			<td style="text-align: center;"><c:out value="${notice.notice_hits }"/></td>
								 		</tr>
								 	</c:forEach>
								 	</c:if>
							 	</tbody>
							 	
							</table>
							<c:if test="${login_info.user_no eq 1}">
								<div style="text-align: right;" >
									<a href="/noticewrite" class="btn btn-secondary">글쓰기</a>
	                        	</div>
                        	</c:if>
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

    <script src="adminassets/vendors/simple-datatables/simple-datatables.js"></script>
    <script>
        // Simple Datatable
        let table1 = document.querySelector('#table1');
        let dataTable = new simpleDatatables.DataTable(table1);
    </script>

    <script src="adminassets/js/main.js"></script>
    

    
  </body>

</html>