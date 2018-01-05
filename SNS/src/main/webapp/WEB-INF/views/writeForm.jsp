<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
<html>
<head>

<title>회원가입</title>
<script type="text/javascript">
$(function(){
    $("#date1").datepicker({
        dateFormat: "yy-mm-dd"
    });
});

/* function check(){
	if(reg.ID.value==""){
		$(this).css('background','red');
		alert("아이디입력");
		preventDefault();
		return false;
	}	
} */
</script>

</head>
<body>
<form action="write.do" name="reg">
<table>

	<tr>
		<td><input type="text" name="ID" placeholder="user ID"></td>
	</tr>
	<tr>
		<td><input type="text" name="NAME" placeholder="Username"></td>
	</tr>
	<tr>
		<td><input type="password" name="PASSWORD" placeholder="Password"></td>
	</tr>
	<tr>
		<td><input type="text" name="BIRTHDAY" id="date1" placeholder="Birthday"></td>
	</tr>
	<tr>
		<td><input type="radio" name="SEX" value="1">남자</td>
		<td><input type="radio" name="SEX" value="2">여자</td>
	</tr>
	<tr>
		<td><input type="text" name="EMAIL" placeholder="E-mail"></td>
	</tr>
</table>
<input type="submit" value="Sign up" onclick="check();">



</form>
</body>
</html>