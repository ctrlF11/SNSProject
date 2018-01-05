<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
  <script type="text/javascript">
  $(function(){
       $("#date1").datepicker({
           dateFormat: "yy-mm-dd"
       });
   $('#emailHelp').hide();
   $('#nameHelp').hide();  
   $('#passwordHelp').hide();  
   $('#dayHelp').hide();
   $('#sexHelp').hide(); 
   
   $('#reg').click(function(event){
      if($('input[name=ID]').val().length==0){
         $('#emailHelp').show();
      } else {
         $('#emailHelp').hide();
      };
      if($('input[name=NAME]').val().length==0){
         $('#nameHelp').show();
      } else {
         $('#nameHelp').hide();
      };
      if($('input[name=PASSWORD]').val().length==0){
         $('#passwordHelp').show();
      } else {
         $('#passwordHelp').hide();
      };
      if($('input[name=BIRTHDAY]').val().length==0){
         $('#dayHelp').show();
      }
      else {
         $('#dayHelp').hide();
      };
     
      })
  });
</script>
  
</head>

<body class="bg-dark">
   <div class="container">
      <div class="card card-register mx-auto mt-5">
         <div class="card-header">회원가입</div>
         <div class="card-body">
            <form action="register.do" id="regForm">
               <div class="form-group">
                  <div class="form-row">
                     <label for="exampleInputEmail1">이메일</label>
                     <input class="form-control" name="ID" type="email"
                        aria-describedby="emailHelp" placeholder="Enter email">
                  </div>
                  <div id="emailHelp" style =color:red> 이메일을 입력해주세요.
                  </div>
               </div>
               <div class="form-group">
                  <div class="form-row">
                     <label for="exampleInputEmail1">Email test</label>
                     <input class="form-control" name="EMAIL" type="text"
                        aria-describedby="emailHelp" placeholder="Enter email">
                  </div>
               </div>
               <div class="form-group">
                  <div class="form-row">
                     <label for="exampleInputName">이름</label>
                     <input class="form-control" name="NAME" type="text"
                        aria-describedby="nameHelp" placeholder="Enter user name">
                  </div>               
                  <div id="nameHelp" style =color:red> 이름을 입력해주세요.
                  </div>
               </div>
               <div class="form-group">
                  <div class="form-row">
                         <label for="exampleInputPassword1">비밀번호</label>
                        <input class="form-control" name="PASSWORD" type="password"
                           placeholder="Password">
                  </div>
                  <div id="passwordHelp" style =color:red> 비밀번호를 입력해주세요.
                  </div>               
               </div>                        
                  <div class="form-group">
                     <div class="form-row">
                        <label for="exampleInputName">생일</label>
                        <input   class="form-control" name="BIRTHDAY" id="date1" type="text"
                           aria-describedby="dayHelp" placeholder="Enter user birthday">
                     </div>
                     <div id="dayHelp" style =color:red> 생일를 입력해주세요.
                  </div>   
                  </div>
      
               <div class="form-group">
                  <div class="form-row">
                     <div class="col-md-6">                     
                     <label><input class="form-control" name="SEX" type="radio" value = "1"/> 남자</label>
                     </div>
                     <div class="col-md-6">                        
                        <label><input class="form-control" name="SEX" type="radio" value="2">여자 </label>
                     </div>
                     
                  </div>
               </div>   
            <input type="submit" class="btn btn-primary btn-block" id="reg" value="회원등록">
            </form>
            <div class="text-center">
               <a class="d-block small mt-3" href="login.html">Login Page</a>
               <a class="d-block small" href="forgot-password.html">Forgot   Password?</a>
            </div>
         </div>
      </div>
   </div>
   <!-- Bootstrap core JavaScript
   <script src="resources/vendor/jquery/jquery.min.js"></script>
   <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    Core plugin JavaScript
   <script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script> -->
</body>

</html>