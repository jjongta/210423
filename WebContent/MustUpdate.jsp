<%@page import="dto.MustEatDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="dto.MemberDto"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
 <%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
if(ologin == null){
	%>	
	<script>
	alert('로그인 해 주십시오');
	location.href = "login.jsp";
	</script>	
	<%
}
mem = (MemberDto)ologin;
request.setAttribute("mem", mem);
%> 

<%
String getseq = request.getParameter("seq");
System.out.println(getseq);
int seq = Integer.parseInt(getseq);

String id = request.getParameter("id");

MustEatDto dto = (MustEatDto)request.getAttribute("dto");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MustWrite</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  
  <!-- 부트 -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="" />
	<meta name="author" content="" />
	<meta name="robots" content="" />
	<meta name="description" content="LeMars : Blog HTML Template" />
	<meta property="og:title" content="LeMars : Blog HTML Template" />
	<meta property="og:description" content="LeMars : Blog HTML Template" />
	<meta property="og:image" content="http://lemars.dexignzone.com/xhtml/social-image.png" />
	<meta name="format-detection" content="telephone=no">
  
  
	<!-- 상단 작은 아이콘 -->
	<link rel="icon" href="images/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" />
	
	<!-- 페이지 타이틀 -->
	<title>Tripia</title>
	
	<!-- 모바일 사이즈 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!-- 스타일 시트 -->
	<link rel="stylesheet" type="text/css" href="css/plugins.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/templete.css">
	<link class="skin" rel="stylesheet" type="text/css" href="css/skin/skin-1.css">
	
	<!-- 이전에 사용했던 시트 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha256-YLGeXaapI0/5IgZopewRJcFXomhRMlYYjugPLSyNjTY=" crossorigin="anonymous" />

	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="./css/business-casual.min.css" rel="stylesheet">
</head>




<body>
 <header class="site-header mo-left header style-1">
    <!-- header -->
    <header class="site-header mo-left header style-1">
		<!-- main header -->
        <div class="sticky-header main-bar-wraper navbar-expand-lg">
        	<!-- 상단을 담는 큰 박스-->
            <div class="main-bar clearfix" style="padding-top: 15px;padding-bottom: 15px;">
            	<!-- 상단바 전체 -->
                <div class="container" style="margin-left : 240px">
					<div class="header-content-bx no-bdr" style="width: 1390px; padding: 0px">
						<!-- 웹사이트 로고 -->
						<div class="logo-header"  style="margin-right: 50px">
							<a href="index.jsp"><img src="images/logo.png" alt=""/></a>
						</div>
						<!-- nav toggle button 버튼 -->
						<button class="navbar-toggler collapsed navicon justify-content-end" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
							<span></span>
							<span></span>
							<span></span>
						</button>
						<!-- main nav 메인 상단바-->
						<div class="header-nav navbar-collapse collapse justify-content-center" id="navbarNavDropdown" style=" margine-right : 50px " >
							<div class="logo-header">
								<a href="index.jsp"><img src="" alt="images/logo-white.png"/></a>
							</div>
							<ul class="nav navbar-nav">	
								<!-- 추천 여행지 -->
								<li>
									<a href="TpList?param=Tplistr">Recommended <i class="fa fa-chevron-down"></i></a>
								</li>
								<!-- 자유게시판  -->
								<li class="has-mega-menu post-slider life-style">
									<a href="bbs?param=bbslist">Forum<i class="fa fa-chevron-down"></i></a>
									</li>
								<!-- 여행지 목록  -->	
								<li>
									<a href="TpList?param=Tplist">Destination<i class="fa fa-chevron-down"></i></a>
									<ul class="sub-menu">
										<li><a href="TpList?param=Tplist1">서울</a></li>
										<li><a href="TpList?param=Tplist2">제주</a></li>
										<li><a href="TpList?param=Tplist3">인천</a></li>
										<li><a href="TpList?param=Tplist4">부산</a></li>
										<li><a href="TpList?param=Tplist5">강원도</a></li>
									</ul>
								
								</li>
								<!-- 트리피아는? -->
								<li>
									<a href="about-us.jsp">Tripia?</a>
									<!-- 공지사항 -->
									<ul class="sub-menu">
										<li><a href="notice?param=list">Notice</a></li>
										
									</ul>
								</li>
								<li>
									<a href="match?param=Matchlist">Find Mate</a> <!-- 매칭 -->
								</li>

								<!-- 로그인 -->
							
								<li>
									
										
									<c:choose>
									<c:when test="${login.id == null}">  
									
									<a href="login_resist_form.jsp">Login</a>
									</c:when>
									
									<c:when test="${login.id != null}">
									${login.id}님 반갑습니다.
									<a href="logout.jsp">Logout</a>
									<a href="member?param=mapageAf&userID=${login.id}">My page</a>
									<a href="qna?param=qnalist">Q&A</a>									
									</c:when>	
									</c:choose>
									
								</li>
							</ul>

					
						
						

				</div>
            </div>
        </div>
	</div>
</div>
		<!-- 전체 공통 header 끝 -->

        <!-- main header END -->
    </header>



<h1 class="site-heading text-center text-white d-none d-lg-block">
    <span class="site-heading-upper text-primary mb-3">Recommended for travel destinations</span>
    <span class="site-heading-lower">MUSTEAT</span>
  </h1>





  <section class="page-section cta">
    <div class="container">
      <div class="row">
        <div class="col-xl-9 mx-auto">
          <div class="cta-inner text-center rounded">
            <h4 class="section-heading mb-4">
              <span class="section-heading-upper">Update Now</span>
              <br>
              <span style="font-weight:  blod" class="section-heading-lower">MUSTEAT CONTENT UPDATE</span>
            </h4>
            <p class="mb-0">기억에 남는 여행지 맛집을 공유하세요!</p>
            <br>
          <!-- write -->
        <div align="center"  class = "container">

<br>
<form action="fileupdate?param=mustUpdate" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="${dto.seq}">

<table class="table table-hover">
<col width="200"><col width="500">

<tr>
	<th>아이디</th>
	<td>
		${dto.id}
		<input type="hidden" name="id" value="${dto.id}">
	</td>
</tr>
<tr>
	<th>닉네임</th>
	<td>
		${dto.name}
		<input type="hidden" name="nameN" value="${dto.name}">
	</td>
</tr>

<tr>
<th>맛집 장소</th>
		<td>
			
				<select class="form-select" aria-label="Default select example" name = "place">
 				 <option>여행지 맛집의 위치를 선택하세요!</option>
 				 <option value="강릉" <%="강릉".equals(dto.getPlace())?"selected":"" %>>강릉</option>
				  <option value="인천" <%="인천".equals(dto.getPlace())?"selected":"" %>>인천</option>
  					<option value="제주" <%="제주".equals(dto.getPlace())?"selected":"" %>>제주</option>
  					<option value="부산" <%="부산".equals(dto.getPlace())?"selected":"" %>>부산</option>
  					<option value="서울" <%="서울".equals(dto.getPlace())?"selected":"" %>>서울</option>
  					<option value="광주" <%="광주".equals(dto.getPlace())?"selected":"" %>>광주</option>
  					<option value="전주" <%="전주".equals(dto.getPlace())?"selected":"" %>>전주</option>
  					<option value="여수" <%="여수".equals(dto.getPlace())?"selected":"" %>>여수</option>
  					<option value="가평" <%="가평".equals(dto.getPlace())?"selected":"" %>>가평</option>
  					<option value="남양주" <%="남양주".equals(dto.getPlace())?"selected":"" %>>남양주</option>
  					<option value="대구" <%="대구".equals(dto.getPlace())?"selected":"" %>>대구</option>
  					<option value="대전" <%="대전".equals(dto.getPlace())?"selected":"" %>>대전</option>
					</select>
		</td>

</tr>

<tr>
	<th>음식점 이름</th>
	<td>
		<input type="text" name="title" size="50" value="${dto.title}">
	</td>
</tr>
<tr>
	<th>업로드했던 파일</th>
	<td>
		<input type="text" name="oldfile" size="50" value="${dto.filename}">
		<input type="hidden" name="oldnewfile" size="50" value="${dto.newFilename}">
	</td>
</tr>
<tr>
	<th>변경할 파일 업로드</th>
	<td>
		<input type="file" name="fileload" style="widows: 400px">
	</td>	
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="50" name="content">${dto.content}</textarea>
	</td>
</tr>

<tr align="center">
	<td colspan="2">
		<input type="submit" class="btn btn-secondary" value="Update completed">
	</td>
</tr>

</table>

</form>
</div>
					          
					          
					          </div>
					          
        </div><!-- 상자 안 -->
      </div>
    </div>
  </section>
<!-- footer -->
	<footer class="site-footer">
		<div class="footer-top">
			<div class="container">
				<div class="row">
					<div class="col-xl-3 col-lg-2 col-md-6 d-md-none d-lg-block">
						<div class="widget">
							<img src="images/logo-white.png" alt=""/>
						</div>
					</div>
					<div class="col-xl-3 col-lg-4 col-md-6">
						<h6 class="m-b30 footer-title"><span>Recent Post</span></h6>
						<div class="widget recent-posts-entry">
							<div class="widget-post-bx">
								<div class="widget-post clearfix">
									<div class="dlab-post-media"> <img src="images/blog/recent-blog/pic1.jpg" alt=""> </div>
									<div class="dlab-post-info">
										<div class="dlab-post-header">
											<h6 class="post-title"><a href="post-quote.html">Winter Fairytale</a></h6>
										</div>
										<div class="dlab-post-meta">
											<ul>
												<li class="post-date">25 January, 2020</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="widget-post-bx">
								<div class="widget-post clearfix">
									<div class="dlab-post-media"> <img src="images/blog/recent-blog/pic2.jpg" alt=""> </div>
									<div class="dlab-post-info">
										<div class="dlab-post-header">
											<h6 class="post-title"><a href="post-link.html">Fruit & Flamingos</a></h6>
										</div>
										<div class="dlab-post-meta">
											<ul>
												<li class="post-date">25 January, 2020</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="widget-post-bx">
								<div class="widget-post clearfix">
									<div class="dlab-post-media"> <img src="images/blog/recent-blog/pic3.jpg" alt=""> </div>
									<div class="dlab-post-info">
										<div class="dlab-post-header">
											<h6 class="post-title"><a href="post-gallery.html">Hawai Beaches</a></h6>
										</div>
										<div class="dlab-post-meta">
											<ul>
												<li class="post-date">25 January, 2020</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-lg-3 col-md-6">
						<h6 class="m-b30 footer-title"><span>My Blogs</span></h6>
						<a class="video widget relative popup-youtube overlay-black-middle" href="https://www.youtube.com/watch?v=VjlATH_rzYg">
							<img src="images/footer-video.jpg" alt=""/>
							<span class="play-video"><i class="la la-play"></i></span>
						</a>
					</div>
					<div class="col-xl-3 col-lg-3 col-md-12">
						<h6 class="m-b30 footer-title"><span>Subscribe</span></h6>
						<ul class="d-flex widget-social-ic">
							<li><a href="#" class="site-button-link"><i class="fa fa-facebook"></i></a></li>
							<li><a href="#" class="site-button-link"><i class="fa fa-twitter"></i></a></li>
							<li><a href="#" class="site-button-link"><i class="fa fa-pinterest-p"></i></a></li>
							<li><a href="#" class="site-button-link"><i class="fa fa-instagram"></i></a></li>
						</ul>
					</div>
				
				
				
				
				
				
				<!--여기다넣기  -->
				</div><!-- ROW END -->
			</div>
		</div>
		<div class="footer-bottom">
			<div class="container">
				<div class="row">
					<div class="col-12 text-center">
						<span>Copyright © 2020 DexignZone.</span>
					</div>
				</div>
			</div>
		</div>
	</footer>
    <!-- Footer END-->

  <!-- Bootstrap core JavaScript -->
  <script src="./vendor/jquery/jquery.min.js"></script>
  <script src="./vendor/bootstrap/js/bootstrap.bundle.min.js"></script>



</body>
</html>