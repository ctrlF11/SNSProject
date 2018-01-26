<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.project.sns.board.vo.BoardVO"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.wrap {
	position: absolute;
	left: 0;
	bottom: 40px;
	width: 288px;
	height: 132px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
}

.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.info .desc {
	position: relative;
	margin: 13px 0 0 90px;
	height: 75px;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.desc .jibun {
	font-size: 11px;
	color: #888;
	margin-top: -2px;
}

.info .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
	color: #5085BB;
}
</style>
<link href="resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
	href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
	href="resources/facebook/assets/css/facebook2.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script>
	var mmm = function() {
		$.ajax({
			url : 'getBoardList.do',
			data : {
				index : index
			},
			success : function(data) {
				$("#col-sm-6").html(data);
			}
		})

	}
	var index = 0;
	$(function() {
		mmm();

		$(document).on('click', '[name = "comment"]', function() {
			$(".reply").toggle();
		})

		$("#main").scroll(function() {
			var sh = $("#main").scrollTop() + $("#main").height();
			var dh = $("#main").prop("scrollHeight");
			if (sh == dh) {
				index += 3;
				$.ajax({
					url : 'getBoardList.do',
					data : {
						index : index
					},
					success : function(data) {
						$("#col-sm-6").append(data);
					}
				})
			}
		})

	});

	$(document).on(function() {
		$(".reply").hide();
	})
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
				<div class="column col-sm-2 col-xs-1 sidebar-offcanvas" id="sidebar">

					<ul class="nav">
						<li><a href="#" data-toggle="offcanvas"
							class="visible-xs text-center"><i
								class="glyphicon glyphicon-chevron-right"></i></a></li>
					</ul>

					<ul class="nav hidden-xs" id="lg-menu">
						<li class="active"><a href="#featured"><i
								class="glyphicon glyphicon-list-alt"></i> Featured</a></li>
						<li><a href="#stories"><i
								class="glyphicon glyphicon-list"></i> Stories</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-paperclip"></i>
								Saved</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-refresh"></i>
								Refresh</a></li>
					</ul>
					<ul class="list-unstyled hidden-xs" id="sidebar-footer">
						<li><a href="http://usebootstrap.com/theme/facebook"><h3>Bootstrap</h3>
								<i class="glyphicon glyphicon-heart-empty"></i> Bootply</a></li>
					</ul>

					<ul class="nav visible-xs" id="xs-menu">
						<li><a href="#featured" class="text-center"><i
								class="glyphicon glyphicon-list-alt"></i></a></li>
						<li><a href="#stories" class="text-center"><i
								class="glyphicon glyphicon-list"></i></a></li>
						<li><a href="#" class="text-center"><i
								class="glyphicon glyphicon-paperclip"></i></a></li>
						<li><a href="#" class="text-center"><i
								class="glyphicon glyphicon-refresh"></i></a></li>
					</ul>

				</div>
				<!--
                  col-sm-12, col-xs-12 둘 다 같은 width 설정 class.
                  col-xs-12는 disable된 상태
                  
                  맨 뒤의 숫자를 변경하면(col-sm-10) 회색 화면의 가로가 줄어들어 
                  백그라운드의 회색 화면이 나타남.                  
                -->
				<div id="main" class="column col-sm-10 col-xs-11" overflow-y:auto>

					<!-- 
                  Topbar. 기존 부트스트랩보다 height를 늘림.
                -->
					<div class="navbar navbar-blue navbar-static-top">
						<!-- 
                     아이콘 영역. 기존 부트스트랩보다 margin-top을 늘림.
                   -->
						<div class="navbar-header">
							<!-- 토글용 버튼인데.... collapse되어있어 비활성화된 듯 함. -->
							<button class="navbar-toggle" type="button"
								data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle</span>
							</button>
							<!-- 아이콘. margin-top을 늘림. -->
							<a href="https://www.naver.com" class="navbar-brand logo">N</a>
						</div>

						<!-- 아이콘을 제외한 오른쪽 영역. -->
						<nav class="collapse navbar-collapse" role="navigation"> <!-- 검색 폼. -->
						<form class="navbar-form navbar-left">
							<div class="input-group input-group-sm" style="width: 360px;">
								<input class="form-control" placeholder="Search"
									name="srch-term" id="srch-term" type="text">
								<div class="input-group-btn">
									<button class="btn btn-default" type="submit">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</div>
							</div>
						</form>
						<!-- 오른쪽 아이콘 모음집. -->
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#"><i class="glyphicon glyphicon-home"></i>Home</a>
							</li>
							<li><a href="#postModal" role="button" data-toggle="modal">
									<i class="glyphicon glyphicon-plus"></i>Post
							</a></li>
							<li><a href="#"><span class="badge">badge</span></a></li>
							<!-- 드롭다운(클릭하면 밑으로 튀어나오는 메뉴) -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown"> <i class="glyphicon glyphicon-user"></i></a>
								<ul class="dropdown-menu">
									<li><a href="">More</a></li>
									<li><a href="">More</a></li>
									<li><a href="">More</a></li>
									<li><a href="">More</a></li>
									<li><a href="">More</a></li>
								</ul></li>
						</ul>
						</nav>
					</div>
					<div class="padding">
						<div class="full col-sm-9" id="full1">
							<div class="row">
								<div class="col-sm-6" id="col-sm-6">

									<div class="panel panel-default"></div>


								</div>
								<div class="col-sm-6">

									<div class="panel panel-default">
										<div id="map" style="width: 100%; height: 350px;"></div>
										
										<script type="text/javascript"
											src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
										<script>
											var map = new daum.maps.Map(
													mapContainer, mapOption); // 지도를 생성합니다
										</script>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

