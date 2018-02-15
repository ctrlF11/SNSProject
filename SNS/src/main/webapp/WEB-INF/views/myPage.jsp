<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>가즈아 - 회원 화면</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
	href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
	href="resources/facebook/assets/css/facebook2.css">
<link rel="stylesheet" href="resources/facebook/assets/css/original.css">
<script src="resources/facebook/assets/js/check.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(
					function() {
						$('[data-toggle=offcanvas]')
								.click(
										function() {
											$(this).toggleClass(
													'visible-xs text-center');
											$(this)
													.find('i')
													.toggleClass(
															'glyphicon-chevron-right glyphicon-chevron-left');
											$('.row-offcanvas').toggleClass(
													'active');
											$('#lg-menu').toggleClass(
													'hidden-xs').toggleClass(
													'visible-xs');
											$('#xs-menu').toggleClass(
													'visible-xs').toggleClass(
													'hidden-xs');
											$('#btnShow').toggle();
										});
						mmm();
						$.ajax({
							url : 'getCounts.do',
							data : {
								id : id
							},
							success : function(data) {
								$("#counts").html("<a>"+data[0]+"</a> | "
												+ 	"<a>"+data[1]+"</a> | "
												+	"<a>"+data[2]+"</a>");
							},
							error:function(request,status,error){
						        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
							}
						})
					});
	var id = (String)("<%=session.getAttribute("id")%>");
	
	var mmm = function() {
		$.ajax({
			url : 'getStoryList.do',
			data : {
				index : index,
				id : id
			},
			success : function(data) {
				$("#col-sm-8").html(data);
			}
		})
	}
	
	var index = 0;
	
	/* function togglethis(num) {
		var replyDiv = document.getElementById("replyDiv"+num);
		if(replyDiv.style.display == "none") {
			replyDiv.style.display = "block";
		} else {
			replyDiv.style.display = "none";
		}
	} */


</script>
</head>
<body>
	<div class="wrapper">
		<div class="box">
			<div class="row row-offcanvas row-offcanvas-left">
						<!--
		                     원본 왼쪽에 있던 사이드바.
		                     다만 밑의 메인 화면의 가로 길이를 100%로 하였기 때문에
		                     글씨가 겹쳐 보이는 문제가 발생함.
		                  -->
						<!--
		                  col-sm-12, col-xs-12 둘 다 같은 width 설정 class.
		                  col-xs-12는 disable된 상태
		                  
		                  맨 뒤의 숫자를 변경하면(col-sm-10) 회색 화면의 가로가 줄어들어 
		                  백그라운드의 회색 화면이 나타남.                  
		                -->
						<div id="main" class="column col-sm-12 col-xs-12"
							style="overflow-y: auto;">
							<!-- 
		                  Topbar. 기존 부트스트랩보다 height를 늘림.
		                -->
							<%@ include file="include/topbar.jsp"%>
							<div class="padding">
								<div class="full col-sm-12">
									<div class="row">
										<div class="panel panel-default">
											<div class="card-body">
												<div class="card-body-top">
													<img>
													<%= session.getAttribute("name") %> 님
													<hr>
													<ul>
														<li>
															<a>스토리 수</a> | 
															<a>팔로잉 수</a> | 
															<a>팔로워 수</a>
														</li>
														<li id="counts">
														</li>
													</ul>
													<hr>
													<ul style="height: 55px;">
														<li>
															<a>1</a> | 
															<a>1</a> | 
															<a>1</a>
														</li>
													</ul>
												</div>	
											</div>
									<div class="col-sm-12">
										<div class="col-sm-8" id="col-sm-8" style="position: fixed; left: 40px">
					
										</div>
											
										<div class="col-sm-2" style="position: fixed; right: 40px">
											<div class="row">
												<div class="panel panel-default">
													<div class="card-body" >
														<p class="lead-myBar">
															<a href="myPage.do">스토리 목록</a>
														</p>
													</div>
													<hr>
													<div class="card-body">
														<p class="lead-myBar">
															<a href="myPage.do">더미</a>
														</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		
		function checkgo() {
			var check = document.getElementById("search_category").value;
			var keyword = document.getElementById("srch-term").value;
			alert(check);
			alert(keyword);
			if (keyword == "") {
				alert("키워드를 입력해주세요.");
				return false;
			}
			if (check == "user") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=1";
			}
			if (check == "map") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=2";
			}
			if (check == "board") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=3";
			}
			return false;
		}
	</script>
</body>
</html>
