<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script>
$(function(){
	   $(window).scroll(function(){
		   var sh = $(window).scrollTop() + $(window).height();
		   var dh = $(document).height();
		   if(sh == dh)
		   {
			   for(var i = 0; i < 10; i++)
			   {
				   $('<h1>aaaa</h1>').appendTo("body");
			   }
		   }
	   })
});

   $(function(){
			   for(var i = 0; i < 20; i++)
			   {
				   $('<h1>aaaa</h1>').appendTo("body");
			   }
	
});

</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>aaaa</h1>
</body>
</html>