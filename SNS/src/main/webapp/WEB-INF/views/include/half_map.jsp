<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
					<div class="padding">
						<div class="full col-sm-9" id="full1">
							<div class="row">
								<div class="col-sm-6" id="col-sm-6">
									<!-- 글 영역 -->
								</div>
								<div class="col-sm-6">
									<div class="panel panel-default"></div>
									<div class="panel panel-default">
										<div id="map" style="width: 40%; height: 100%;"></div>
										<script type="text/javascript"
											src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
										<script>
										var mapContainer = document.getElementById('map'), // 지도의 중심좌표
										    mapOption = { 
										        center: new daum.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
										        level: 15 // 지도의 확대 레벨
										    };
										var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
										</script>
									</div>
								</div>
							</div>
						</div>
					</div>
</body>
</html>