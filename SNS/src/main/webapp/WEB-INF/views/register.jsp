  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Register an Account</title>
  <!-- Bootstrap core CSS-->
  <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Custom styles for this template-->
  <link href="resources/css/sb-admin.css" rel="stylesheet">
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
<html>
<head>
  <script type="text/javascript">
  $(function(){
	    $("#date1").datepicker({
	        dateFormat: "yy-mm-dd"
	    });
	});
  </script>
  
</head>

<body class="bg-dark">
	<div class="container">
		<div class="card card-register mx-auto mt-5">
			<div class="card-header">Register an Account</div>
			<div class="card-body">
				<form>
					<div class="form-group">
						<div class="form-row">
							<label for="exampleInputEmail1">Email address</label>
							<input class="form-control" name="ID" type="email"
								aria-describedby="emailHelp" placeholder="Enter email">
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<label for="exampleInputName">User Name</label>
							<input class="form-control" name="NAME" type="text"
								aria-describedby="nameHelp" placeholder="Enter user name">
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="exampleInputPassword1">Password</label>
								<input class="form-control" name="PASSWORD" type="password"
									placeholder="Password">
							</div>
							<div class="col-md-6">
								<label for="exampleConfirmPassword">Confirm password</label>
								<input class="form-control" name="exampleConfirmPassword"
									type="password" placeholder="Confirm password">
							</div>
						</div>
						<div class="form-group">
							<div class="form-row">
								<label for="exampleInputName">Birthday</label>
								<input	class="form-control" name="BIRTHDAY" id="date1" type="text"
									aria-describedby="dayHelp" placeholder="Enter user birthday">
							</div>
						</div>
					</div>
					<a class="btn btn-primary btn-block" href="login.html">Register</a>
				</form>
				<div class="text-center">
					<a class="d-block small mt-3" href="login.html">Login Page</a>
					<a class="d-block small" href="forgot-password.html">Forgot	Password?</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript-->
	<script src="resources/vendor/jquery/jquery.min.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- Core plugin JavaScript-->
	<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
</body>

</html>