<%@page import="com.project.sns.addr.vo.AddrVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>


<title>Insert title here</title>
    <style>
        #setDiv {
            padding-top: 100px;
            text-align: center;
        }
        #mask {
            position:absolute;
            left:0;
            top:0;
            z-index:9999;
            background-color:#000;
            display:none;
        }
        #window {
            display: none;
            background-color: #ffffff;
            height: 200px;
            z-index:99999;
        }
    </style>	
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
	wrapWindowByMask();
});


    // 클릭된 마커가 없고,click된 마커가 클릭된 마커가 아니면
    // 마커의 이미지를 오버 이미지로 변경합니다
    
    if (!selectedMarker || selectedMarker !== marker) {
    	
    <%
 	   List<AddrVO> list2 = (List<AddrVO>) request.getAttribute("list");
 	   for (int i = 0; i < list2.size(); i++) {
 	%>
 	

 	
    	
    <%

 	   }
 	%>

    }
    
    // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
   

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

	 function wrapWindowByMask(){ //화면의 높이와 너비를 구한다.
		 
		var maskHeight = $(document).height();
		var maskWidth = $(window).width(); //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
		
		$('#mask').css({'width':maskWidth,'height':maskHeight});	//마스크의 투명도 처리 
		$('#mask').fadeTo("slow",0.8);

		var left = ( $(window).scrollLeft() + ( $(window).width() - $('#window').width()) / 2 );
        var top = ( $(window).scrollTop() + ( $(window).height() - $('#window').height()) / 2 );
        
        $('#window').css({'left':left,'top':top, 'position':'absolute'});
        
        $('#window').show();
		}
	
</script>


<div id="setDiv">

    <div id="mask"></div>
    <div id="window"></div>
    
</div>


</body>
</html>