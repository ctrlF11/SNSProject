<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<!-- 배경 스타일  -->
<style>
#video { 
     position: absolute;
     top: 0px;
     left: 0px;
     min-width: 100%;
     min-height: 100%;
     width: auto;
     height: 100%;
     z-index: -1;
     overflow: hidden;
}

#exampleInputEmail1{
	color: black;
}
</style>
  <head>

<meta charset="utf-8">

  <!-- Bootstrap core CSS-->
  <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Custom styles for this template-->
  <link href="resources/css/sb-admin.css" rel="stylesheet">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SNS</title>

    <!-- Bootstrap core CSS -->
    <link href="resources/login/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:200,200i,300,300i,400,400i,600,600i,700,700i,900,900i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Merriweather:300,300i,400,400i,700,700i,900,900i" rel="stylesheet">
    <link href="resources/login/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="resources/login/css/coming-soon.min.css" rel="stylesheet">
  </head>

  <body>
    <div class="overlay"></div>
    <div class="masthead">
      <div class="masthead-bg"></div>
      <div class="container h-100">
        <div class="row h-100">
          <div class="col-12 my-auto">
            <div class="masthead-content text-white py-5 py-md-0">
              <h1 class="mb-3">ctrlF11-SNS</h1>
              <p class="mb-5">어떤 컨텐츠든 사용 가능한 모두의 캡슐 <strong>SNS August 2018</strong>렛츠 고고!!</p>
					  <div class="container">
					    <div class="card card-login mx-auto mt-5">
					      <div class="card-header">Login</div>
					      <div class="card-body">
					      <!-- form 태그 -->
					        <form action="./login1.do" method="post">
					          <div class="form-group">
					            <label for="exampleInputEmail1">Email address</label>
					            <input class="form-control" name="id" type="email" aria-describedby="emailHelp" placeholder="Enter email">
					          </div>
					          <div class="form-group">
					            <label for="exampleInputPassword1">Password</label>
					            <input class="form-control" name="password" type="password" placeholder="Password">
					          </div>
					          <div class="form-group">
					            <div class="form-check">
					              <label class="form-check-label">
					                <input class="form-check-input" type="checkbox"> Remember Password</label>
					            </div>
					          </div>
					          <input type="submit" value="로기인"/>
					        </form>
					        <div class="text-center">
					          <a class="d-block small mt-3" href="register.html">Register an Account</a>
					          <a class="d-block small" href="forgot-password.html">Forgot Password?</a>
					        </div>
					      </div>
					    </div>
					  </div>
					  <!-- Bootstrap core JavaScript-->
					  <script src="resources/vendor/jquery/jquery.min.js"></script>
					  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
					  <!-- Core plugin JavaScript-->
					  <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
              </div>
            </div>
          </div>
        </div>
      </div>


    <!-- Bootstrap core JavaScript -->
    <script src="resources/login/vendor/jquery/jquery.min.js"></script>
    <script src="resources/login/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="resources/login/vendor/vide/jquery.vide.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="resources/login/js/coming-soon.min.js"></script>

	<!-- 영상 배경 설정 -->
	<video id="video" preload="auto" autoplay="true" loop="loop" muted="muted" volume="0">
    <source src="resources/login/mp4/bg.mp4">
    </video>

  </body>

</html>
