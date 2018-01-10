<%@page import="com.project.sns.addr.vo.AddrVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<div id="map" style="width:100%;height:850px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커를 표시할 위치와 title 객체 배열입니다 
var positions =  [
	<%
	   List<AddrVO> list = (List<AddrVO>) request.getAttribute("list");
	   for (int i = 0; i < list.size(); i++) {
	%>
	{latlng : new daum.maps.LatLng(<%=list.get(i).getMapy()%>,<%=list.get(i).getMapx()%>)
	}

	<%
	   if (list.size() - 1 > i) {
	         out.append(",");
	      }
	   }
	%>
	];
	selectedMarker = null; // 클릭한 마커를 담을 변수
	
	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new daum.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new daum.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	    addMarker(positions[i].latlng);
	}
	
function addMarker(position) {	

daum.maps.event.addListener(marker, 'click', function() {

    // 클릭된 마커가 없고,click된 마커가 클릭된 마커가 아니면
    // 마커의 이미지를 오버 이미지로 변경합니다
    
    if (!selectedMarker || selectedMarker !== marker) {
    	
    <%
 	   List<AddrVO> list2 = (List<AddrVO>) request.getAttribute("list");
 	   for (int i = 0; i < list2.size(); i++) {
 	%>
 	
	String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro?ServiceKey=";
	String serviceKey = "429e9l%2BRPBvvMYSqI0TIu0JgvFl1vio2dcUfXj7d66%2F%2B2glco1EDs1HDHJBssw9U7HAt1A11Cy6N0Hbk2INDfQ%3D%3D";
	String parameter = "";
	// serviceKey = URLEncoder.encode(serviceKey,"utf-8");

	PrintWriter out = response.getWriter();
	// PrintWriter out = new PrintWriter(new OutputStream
	// Writer(response.getOutputStream(),"KSC5601"));
	// ServletOutputStream out = response.getOutputStream();
	parameter = parameter + "&" + "contentId=<%=list2.get(i).getContentId()%>";
	parameter = parameter + "&" + "contentTypeId=<%=list2.get(i).getContentTypeId()%>";
	parameter = parameter + "&" + "MobileOS=ETC";
	parameter = parameter + "&" + "MobileApp=aa";
	parameter = parameter + "&" + "_type=json";

	addr = addr + serviceKey + parameter;
	URL url = new URL(addr);
 	
    	var popUrl = url;	//팝업창에 출력될 페이지 URL
    	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
    <%

 	   }
 	%>
		window.open(popUrl,"",popOption);

    }
    
    // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
   
});

	}
<%-- var linePath =  [
	<%
	   List<AddrVO> list2 = (List<AddrVO>) request.getAttribute("list");
	   for (int i = 0; i < list.size(); i++) {
	%>
	 new daum.maps.LatLng(<%=list2.get(i).getMapY()%>,<%=list2.get(i).getMapX()%>)
	

	<%
	   if (list2.size() - 1 > i) {
	         out.append(",");
	      }
	   }
	%>
	];
 var polyline = new daum.maps.Polyline({
    path: linePath, // 선을 구성하는 좌표배열 입니다
    strokeWeight: 5, // 선의 두께 입니다
    strokeColor: '#FFAE00', // 선의 색깔입니다
    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
    strokeStyle: 'solid' // 선의 스타일입니다
});

// 지도에 선을 표시합니다 
polyline.setMap(map);    --%>


</script>
</body>
</html>