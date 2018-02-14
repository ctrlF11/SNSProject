<%@page import="com.project.sns.addr.vo.AddrVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/ls/jquery/3.1.0/jquery.min.js"></script>
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
<link rel="stylesheet"
   href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
   href="resources/facebook/assets/css/facebook2.css">
<link rel="stylesheet" href="resources/css/map.css" type="text/css"/>
<!-- <script type="text/javascript" src="resources/js/map.js"></script> -->
<script type="text/javascript" src="resources/facebook/assets/js/jquery.js"></script>
<script type="text/javascript" src="resources/facebook/assets/js/bootstrap.js"></script>

<title>TourSNS</title>
</head>
<body>   

<div class="wrapper">
      <div class="box">
         <div class="row row-offcanvas row-offcanvas-left">
               <!--
                  col-sm-12, col-xs-12 둘 다 같은 width 설정 class.
                  col-xs-12는 disable된 상태
                  
                  맨 뒤의 숫자를 변경하면(col-sm-10) 회색 화면의 가로가 줄어들어 
                  백그라운드의 회색 화면이 나타남.                  
                -->
            <div id="main" class="column col-sm-12 col-xs-12">
               
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
                     <a href="main.do" class="navbar-brand logo">N</a>
                  </div>
                  
                  <!-- 아이콘을 제외한 오른쪽 영역. -->
                  <nav class="navbar-collapse" role="navigation">
                     <!-- 검색 폼. -->
                     <div class="search_wrap">
                        <form class="navbar-form navbar-left" method="post" onsubmit="return checkgo();" id="searchForm">
                           <div class="input-group input-group-sm">
                              <select id="search_category" style="width: 55.2px; height: 30px;" >
                                 <option value="user">사람</option>
                                 <option value="map">가게</option>
                                 <option value="board">글</option>
                              </select>
                              <input class="form-control" placeholder="Search" name="srch-term" id="srch-term" type="text">
                              <div class="input-group-btn">
                                 <button class="btn btn-default" type="submit">
                                    <i class="glyphicon glyphicon-search"></i>
                                 </button>
                              </div>
                           </div>
                        </form>
                     </div>
                     <!-- 오른쪽 아이콘 모음집. 가로 957.333px에 찌그러짐-->
                     <div class="icon_wrap">
                        <ul class="nav navbar-nav navbar-right">
                           <li>
                              <a href="#">로그인</a>
                           </li>
                           <li>
                              <a href="#postModal" role="button" data-toggle="modal">
                              추천 경로+</a>
                           </li>
                           <li>
                              <a href="#">스토리</a>
                           </li>
                           <!-- 드롭다운(클릭하면 밑으로 튀어나오는 메뉴) -->
                            <li class="dropdown">
                           <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                           <i class="glyphicon glyphicon-user"></i></a>
                           <ul class="dropdown-menu">
                             <li><a href="">More</a></li>
                             <li><a href="">More</a></li>
                             <li><a href="">More</a></li>
                             <li><a href="">More</a></li>
                             <li><a href="">More</a></li>
                           </ul>
                          </li>
                        </ul>
                     </div>
                  </nav>
               </div>
   <div id="setDiv">
      <div id="mask"></div>
      <div id="window"></div>
      <div id="mapBox">
      	<div id="searchBox" style="z-index: 2;">
	      <input type="text" id="searchMap" onkeydown="enterkey();"/><input id = "searchMapBtn" type="button" value="검색" onclick="searchMap();"/>
		</div>
      	<div id="map" style="z-index: 1;" ></div> 
      </div>
      
      <!-- 오른쪽 사이드 -->  
      <div id="sidemenu">  
      	<button class="sideBtn" id="getpath" onclick="getpath()">경로 찾기</button>
      	<button class="sideBtn" id="newpath" onclick="newpath()">경로 새로고침</button>
      	<button class="sideBtn" id="savepath" onclick="savepath()">경로 저장</button>
      	<ul class="accordian">
      		<li class="accordian--box">
      			<h3 id="recommend" onclick="recommend()">추천코스</h3>
      			<h4 id="pathlist"></h4>
      		</li>
      	</ul>
      	<div id="path"></div>        
      </div>      
   </div>
            </div>         
         </div>
      </div>
   </div>
<script>



var accModule = function() {

     // private member (비공개 멤버, 고유멤버)
     var acc_wrap = $('.accodian'),
       question = acc_wrap.find('h3'),
       answer = question.next('h4');

     // privilieged member(공용 인터페이스)
     return {
       runInit: function() {
         this.accHandler();
       },
       accHandler: function() {
         var accodian = {
           targetClick: function(e) {
             var eTarget = $(e.currentTarget);
             if (eTarget.next().is(':visible')) {
               eTarget.next().slideUp();
               return;
             }
             answer.slideUp();
             eTarget.next().slideDown();
           }
         };
         question.on('click', accodian.targetClick);
       }
     }
   }();

   // 실행
   accModule.runInit();

var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 8 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
customOverlay = new daum.maps.CustomOverlay({});

// 마커를 표시할 위치와 title 객체 배열입니다 
var positions =  [
<%
   List<AddrVO> list = (List<AddrVO>) request.getAttribute("list");
   for (int i = 0; i < list.size(); i++) {
%>
{title : "<%=list.get(i).getTitle()%>",
 contenttypeid : "<%=list.get(i).getContentTypeId()%>",
 contentid : "<%=list.get(i).getContentId()%>",
 latlng : new daum.maps.LatLng(<%=list.get(i).getMapy()%>,<%=list.get(i).getMapx()%>),
 mapx : "<%=list.get(i).getMapx()%>",
 mapy : "<%=list.get(i).getMapy()%>"
}

<%
   if (list.size() - 1 > i) {
         out.append(",");
      }
   }
%>
];


//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
   $(document)
         .ready(
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
                        });


//행정구역 구분
$.getJSON("resources/json/seoul_gson.geojson", function(geojson) {

   var data = geojson.features;
   var coordinates = [];   //좌표 저장할 배열
   var name = '';         //지역 구 이름
   var gucode ='';         //행정구역 코드번호
   $.each(data, function(index, val) {

      coordinates = val.geometry.coordinates;
      name = val.properties.SIG_KOR_NM;
      gucode = val.properties.orig_ogc_fid;
      
      displayArea(coordinates, name, gucode);
//      console.log(coordinates);
   })
})
var sigungucode ='';         //function recommend()의 AJAX로 지역구 코드를 보내기 위한 변수
var polygons=[];            //function 안 쪽에 지역변수로 넣으니깐 폴리곤 하나 생성할 때마다 배열이 비어서 클릭했을 때 전체를 못 없애줌.  그래서 전역변수로 만듦.
   //행정구역 폴리곤

function displayArea(coordinates, name, gucode) {

   var path = [];         //폴리곤 그려줄 path
   var points = [];      //중심좌표 구하기 위한 지역구 좌표들
   
   $.each(coordinates[0], function(index, coordinate) {      //console 보면 [0]번째에 배열이 주로 저장이 됨.  그래서 [0]번째 배열에서 꺼내줌.
      var point = new Object(); 
      point.x = coordinate[1];
      point.y = coordinate[0];
      points.push(point);
      path.push(new daum.maps.LatLng(coordinate[1], coordinate[0]));         //new daum.maps.LatLng가 없으면 인식을 못해서 path 배열에 추가
   })
   
   // 다각형을 생성합니다 
   var polygon = new daum.maps.Polygon({
      map : map, // 다각형을 표시할 지도 객체
      path : path,
      strokeWeight : 2,
      strokeColor : '#004c80',
      strokeOpacity : 0.8,
      fillColor : '#fff',
      fillOpacity : 0.7
   });
   
   polygons.push(polygon);         //폴리곤 제거하기 위한 배열

   // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
   // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
   daum.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
      polygon.setOptions({
         fillColor : '#09f'
      });

      customOverlay.setContent('<div class="area">' + name + '</div>');

      customOverlay.setPosition(mouseEvent.latLng);
      customOverlay.setMap(map);
   });

   // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
   daum.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {

      customOverlay.setPosition(mouseEvent.latLng);
   });

   // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
   // 커스텀 오버레이를 지도에서 제거합니다 
   daum.maps.event.addListener(polygon, 'mouseout', function() {
      polygon.setOptions({
         fillColor : '#fff'
      });
      customOverlay.setMap(null);
   });

   // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 해당 지역 확대, 시군구코드 넘겨줌
   daum.maps.event.addListener(polygon, 'click', function() {
      
        // 현재 지도 레벨에서 2레벨 확대한 레벨
      var level = map.getLevel()-2;
      
        // 지도를 클릭된 폴리곤의 중앙 위치를 기준으로 확대합니다
        map.setLevel(level, {anchor: centroid(points), animate: {
            duration: 350
        }});         
        
        sigungucode = gucode;                  

        deletePolygon(polygons);               //폴리곤 제거      
   });

}

//centroid 알고리즘 (폴리곤 중심좌표 구하기 위함)
function centroid (points) {
    var i, j, len, p1, p2, f, area, x, y;

    area = x = y = 0;

    for (i = 0, len = points.length, j = len - 1; i < len; j = i++) {
            p1 = points[i];
            p2 = points[j];

            f = p1.y * p2.x - p2.y * p1.x;
            x += (p1.x + p2.x) * f;
            y += (p1.y + p2.y) * f;
            area += f * 3;
    }

    return new daum.maps.LatLng(x / area, y / area);
}

var recPath = []; //라인 이을 추천 경로들의 배열
var polylines = []; //라인 담을 배열 

var arr = new Array(); //선택한 객체들 모음 
var markersArr = [];  //클릭해서 선택한 배열(빨간색)
var markers = []; //검색 결과 마커들 모음 (노란색)
var afterSearchPath = []; //검색 후 결과 배열
var afterSearchArr = new Array(); //검색 한 결과 객체들 모음

var selectedMarker = null;

//마커 이미지와 크기지정
var marker_width = 24,
marker_height = 35,
over_marker_width = 30,
over_marker_height = 40,
sprite_marker_url = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
click_marker_url = "markerStarRed.png";

var markerSize = new daum.maps.Size(marker_width, marker_height), 
overMarkerSize = new daum.maps.Size(over_marker_width, over_marker_height),
spriteImageSize = new daum.maps.Size(marker_width, marker_height);

function createMarkerImage(src, size){
	var markerImage = new daum.maps.MarkerImage(src, size);
	return markerImage;
}

var normalImage = createMarkerImage(sprite_marker_url, markerSize),
overImage = createMarkerImage(sprite_marker_url, overMarkerSize),
clickImage = createMarkerImage(click_marker_url, markerSize);


function addMarker(position, title, contentid, contenttypeid) {
	console.log("addMarker");
   // 마커를 생성합니다
  	  var marker = new daum.maps.Marker({
	  contentId: contentid,
      map : map, // 마커를 표시할 지도
      position : position, // 마커를 표시할 위치
      title : title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image : normalImage
   // 마커 이미지 
   });
   console.log("arr");
   console.log(arr);
   //만약 arr에 존재하는 marker라면 빨간색 마커로 생성하겠다. 그리고 markerArr에 추가하겠다.
   if(arr.findIndex(function(item){return item.contentId === contentid})>-1){
	console.log("arr에 존재하는 marker이다.");	
   	createArrMarkers(marker);
   	
   	
   	
   	console.log(markersArr.findIndex(function(item){return item.contentid === contentid}));
   	console.log(markersArr.indexOf(this));
   	if(markersArr.findIndex(function(item){return item.contentId === contentid})>-1){
   		//markersArr에도 존재한다면?
   		console.log("markersArr에도 존재함");
   		return false;
   	}
   }
   
   console.log("markersArr");
   console.log(markersArr);
   
   // 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
   marker.normalImage = normalImage;
   
   markers.push(marker); //배열에 생성된 마커 추가
   //recPath.push(position); //추천 경로 배열에 좌표 추가


   //마커에 mouseover 이벤트 등록    
   daum.maps.event.addListener(marker, 'mouseover', function(){

   	//클릭된 마커가 없고, mouseover된 마커가 클릭된 마커가 아니면 마커의 이미지를 오버 이미지로 변경
   	if(!selectedMarker || selectedMarker != marker){
   		if(arr.findIndex(function(item){return item.contentId === contentid})>-1){return false;}
   		if($.inArray(marker, markersArr) != -1 ){return false;}
   		marker.setImage(overImage);
   	}
   });
   
	// 마커에 mouseout 이벤트를 등록합니다
   daum.maps.event.addListener(marker, 'mouseout', function() {

       // 클릭된 마커가 없고, mouseout된 마커가 클릭된 마커가 아니면 마커의 이미지를 기본 이미지로 변경합니다
       if (!selectedMarker || selectedMarker !== marker) {
   		if($.inArray(marker, markersArr) != -1 ){return false;}
   		if(arr.findIndex(function(item){return item.contentId === contentid})>-1){return false;}
           marker.setImage(normalImage);
       }
   });
   
   //선택한 마커를 생성하고 선택마커 배열에 추가하는 함수
   function createArrMarkers(marker){
	   	console.log('marker');
	   	console.log(marker);
   		marker.setImage(clickImage);
   		markersArr.push(marker);
   		marker.setMap(map);
   }

   
 //마커 클릭시! 
   daum.maps.event.addListener(marker, 'click', function() {
   	   console.log("클릭");
   	   console.log(marker);
   	   marker = this;
   	   //wrapWindowByMask();//팝업 레이어 검정 배경
   	   
       // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면 마커의 이미지를 클릭 이미지로 변경합니다
       if (!selectedMarker || selectedMarker !== marker) {

           // 클릭된 마커 객체가 null이 아니면 클릭된 마커의 이미지를 기본 이미지로 변경하고
           //!!selectedMarker && selectedMarker.setImage(selectedMarker.normalImage);

           // 현재 클릭된 마커의 이미지는 클릭 이미지로 변경합니다
           marker.setImage(clickImage);
           
           //선택한 목록에 이미 존재한다면 삭제.
       }
       var i = arr.findIndex(function(item){return item.contentId === contentid});
       if(i > -1){
    	   
       	//이미지 노말로 변경
    	   marker.setImage(normalImage);
    	   
    	   //arr에서 삭제.
    	   arr.splice(i, 1);
    	   markersArr.splice(i, 1);
    	   
    	   //if(afterpath.findIndex(function(item){return item.contentId === contentid})>-1){
    		   //console.log("이미지 삭제");
    		   //marker.setMap(null);
    		   //}
    	   
    	   //div 지우기
    	   var garbage = document.getElementById(contentid);
    	   document.getElementById('path').removeChild(garbage);
    	   
    	   return false;
       }

      // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
      selectedMarker = marker;
      console.log("22??");
      console.log(marker);
      var obj = new Object();
      obj.contentId = contentid;
      obj.contentTypeId = contenttypeid;
      obj.mapy = position.jb;
      obj.mapx = position.ib;
      obj.title = title;
      arr.push(obj);
      markersArr.push(this);
      
      var outputTitle = '<div class="pin" value="'+ contenttypeid + '" id="' + contentid + '" text-align:left>';
                  	outputTitle += '<h4 class="title"><div class="glyphicon glyphicon-remove" id="d' + contentid + '" onclick="deletePin(this)"></div>' 
                  				+ "<a href='javascript:panTo(" + position.jb + ',' + position.ib + ',' + contentid + ',' + contenttypeid + ")'>"
                  				+ title + '</a></h4></div>';
      $('#path').append(outputTitle);
   });
   
}



//지도 위 표시되고 있는 마커 제거
function deleteMarker() {
   for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
   }
   markers = [];
}

//지도 위 표시되고 있는 라인 제거
function deletePolyLine() {
   for (var i = 0; i < polylines.length; i++) {
      polylines[i].setMap(null);
   }
   polylines = [];
   //recPath = []; //라인 이어줄 좌표들 있는 배열 초기화
}

//지도 위 표시되고 있는 폴리곤 제거
function deletePolygon(polygons) {
   for (var i = 0; i < polygons.length; i++) {
      polygons[i].setMap(null);
   }
   polygons = [];
}

//팝업 레이어
function wrapWindowByMask() {

   // 뒤 검은 마스크를 클릭시에도 모두 제거하도록 처리합니다.
   $('#mask').click(function() {
      $(this).hide();
      $('#window').hide();
   });

   var maskHeight = $('#map').height();
   var maskWidth = $('#map').width(); //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.

   $('#mask').css({
      'width' : maskWidth,
      'height' : maskHeight
   }); //마스크의 투명도 처리 
   $('#mask').fadeTo("slow", 0.8);

   var left = ($('#map').scrollLeft() + ($('#map').width() - $('#window')
         .width()) / 2);
   var top = ($('#map').scrollTop() + ($('#map').height() - $('#window')
         .height()) / 2);

   $('#window').css({
      'left' : left,
      'top' : top,
      'position' : 'absolute'
   });

   $('#window').show();
}

var count = 0;
//경로 추천
function recommend() {
   
   $.ajax({
            url : 'getPath.do',
            type : 'get',
            dataType : 'json',
            data : {'sigungucode' : sigungucode},
            success : function(jsonData) {
            	console.log("recommend의 결과 ");
            	console.log(jsonData);
               deleteMarker();
               var path = jsonData.path;
               var sidePath = "";
               recPath = [];
               count++;
               if(count > 1){
            	   newpath();
               }
               for (var i = path.length - 1; i >= 0; i--) {
                  for (var j = 0; j < positions.length; j++) {
                     if (path[i] == (positions[j].contentid)) {
                         var obj = new Object();
                         obj.contentId = positions[j].contentid;
                         obj.contentTypeId = positions[j].contenttypeid;
                         obj.mapy = positions[j].latlng.jb;
                         obj.mapx = positions[j].latlng.ib;
                         obj.title = positions[j].title;
                         arr.push(obj);
                         //arr.push(positions[j]);
                         
                        addMarker(positions[j].latlng,
                              positions[j].title,
                              positions[j].contentid,
                              positions[j].contenttypeid);
                              
                        sidePath += '<div class="pinn ' + positions[j].contentid + '" id="' + positions[j].contentid + '" text-align:left)>';
 					    sidePath += '<h4 class="title"><div class="glyphicon glyphicon-remove" id="d' + positions[j].contentid + '"onclick="deletePin(this)"></div>'
			   						+ "<a href='javascript:panTo(" + positions[j].mapy + "," + positions[j].mapx + "," + positions[j].contentid + "," + positions[j].contenttypeid + ")'>"
			   						+ positions[j].title + "</a>" + '</h4>';
			  			sidePath += '</div>'; 
                        
                        console.log("333");
                        console.log("positons[j]");
                        console.log(positions[j]);
                        recPath.push(positions[j].latlng);
                     }
                  }
               }
               $('#pathlist').html(sidePath); //경로 목록 찍어줌
               
               drawLine(recPath);
            },
            error : function(XMLHttpRequest, textStatus, errorThrown) {
               //          alert("Status: " + textStatus); alert("Error: " + errorThrown);  
            }
         });

}

//추천경로 구하기
function getpath(){
		if(arr.length < 3){
			alert("3개 이상의 장소를 입력하시오.");
			return false;
		}
	   //마커 재배치
	   if(afterSearchArr!=null){
			setMarkers(null);
			setMarkersArr(map);
			}
	   $.ajaxSettings.traditional = true;
	   $.ajax({
		   url: 'getpath.do',
		   type: 'POST',
		   data: JSON.stringify(arr),
		   dataType: 'json',
		   contentType: 'application/json',
		   success: function(data){
			   console.log(data);
			   $('#path').empty();
			   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!afterpath
			   //var arra = new Array();
			   //arra = data;
			   markersArr = [];
			   deletePolyLine();
			   recPath = [];
			   afterpath = data;
			   var sidePath = '';
			   var bounds = new daum.maps.LatLngBounds();
				   $.each(afterpath, function(i, val){
					   console.log("444");
					   console.log(val);
					   console.log('val.mapy');
					   console.log(val.mapy);
					   var latlng = new daum.maps.LatLng(val.mapy,val.mapx);
					   console.log("latlng");
					   console.log(latlng);
					   recPath.push(latlng);
					   bounds.extend(latlng);
					   addMarker(latlng, val.title, val.contentId, val.contentTypeId);
					   
					   sidePath += '<div class="pinn ' + val.contentId+ '" id="' + val.contentId + '"text-align:left)">';
					   sidePath += '<h4 class="title"><div class="glyphicon glyphicon-remove" id="d' + val.contentId + '"onclick="deletePin(this)"></div>'
					   			+ "<a href='javascript:panTo(" + val.mapy + "," + val.mapx +"," +  val.contentId + "," + val.contnetTypeId + ")'>"
					   			+ val.title + "</a>" + '</h4>';
					   sidePath += '</div>';
				   });
				   
				   drawLine(recPath);
				   map.setBounds(bounds);
				   $('#path').empty();
				   $('#pathlist').html(sidePath);
				   }
	   });
}


//클릭하면 해당 위치로 이동 (인포윈도우)
function panTo(mapy, mapx, contentid, contenttypeid) {

   // 이동할 위도 경도 위치를 생성합니다 
   var moveLatLon = new daum.maps.LatLng(mapy, mapx);

   // 지도 중심을 부드럽게 이동시킵니다
   // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
   map.panTo(moveLatLon);
   
   getDetail(contentid, contenttypeid);
}

//지도 검색
function searchMap(){
	if(polygons!=null){
		deletePolygon(polygons); 
	}
	var keyword = $('#searchMap').val();
	if(keyword == null){
		alert("검색어를 입력하세요.");
		return false;
	}
	if(afterSearchArr!=null){
	setMarkers(null);
	setMarkersArr(map);
	console.log('markersArr');
	console.log(markersArr);
	}
	$.ajax({
		url:'search.do',
		type: 'POST',
		data: {keyword:keyword},
		success: function(data){
			console.log("555");
			console.log(data);
			afterSearchArr = data;
			if(afterSearchArr.length==0){
				alert("검색 결과가 없습니다.");
				return false;
			}
			var bounds = new daum.maps.LatLngBounds();
			
			$.each(afterSearchArr, function(i, val){
				var latlng = new daum.maps.LatLng(val.mapY,val.mapX);
				bounds.extend(latlng);
				addMarker(latlng, val.title, val.contentId, val.contentTypeId);
			})
			map.setBounds(bounds);
			
			//keyword값 ''로
			$('#searchMap').val('');
		}
	})
}

function setMarkers(map){
	 $.each(markers,function(i, val){
		 val.setMap(map);
	 })
}
	
function setMarkersArr(map){
	$.each(markersArr,function(i,val){
		val.setMap(map);
	})
}

//엔터로 검색
function enterkey(){
	if(window.event.keyCode == 13){
		searchMap();
	}
}

function drawLine(recPath){
	deletePolyLine();
	
	var polyline = new daum.maps.Polyline({
	path : recPath, // 선을 구성하는 좌표배열 입니다
	strokeWeight : 3, // 선의 두께 입니다
	strokeColor : '#db4040', // 선의 색깔입니다
	strokeOpacity : 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	strokeStyle : 'solid' // 선의 스타일입니다
	});
	
	polyline.setMap(map); //지도에 라인 추가
	polylines.push(polyline); //배열에 라인 담기 
}

//엑스표 누르면 arr와 div 삭제
function deletePin(event){
	console.log("event : " + event);
	console.log(event);
	var cid = (event.id).replace('d','');
	
	//arr에서 지우기
	var i = arr.findIndex(function(item){return item.contentId === cid});
	//이미지 노말로 바꾸기
	markersArr[i].setImage(normalImage);
	console.log("arr에서의 index");
	console.log(i);
	if(i > -1){//엑스표 누른게 arr배열에 있다면
		
		//arr에서 삭제
		arr.splice(i, 1);
		console.log("markersArr[i] : ");
		console.log(markersArr[i]);

		//markersArr에서 삭제
		markersArr.splice(i, 1);
		
		
		//console.log("getpath의 결과?");
		//console.log(afterpath.findIndex(function(item){return item.contentId === cid}));
		//if(afterpath.findIndex(function(item){return item.contentId === cid})>-1){//getpath의 결과 일 경우. 마커를 삭제한다 
			//markersArr[i].setMap(null);
		//}else{//아닐 경우, 마커의 이미지를 normalImage로 바꾼다.
			//markersArr[i].setImage(normalImage);
		//}

	}
	console.log("markersArr : ");
	console.log(markersArr);
	
	
	//div 지우기 경로 후
	var top1 = document.getElementById('path');
	var garbage1 = document.getElementById(cid);
	top1.removeChild(garbage1);
	
	
	//div 지우기 경로 전
	var top = document.getElementById('pathlist');
	var garbage = document.getElementById(cid);
	top.removeChild(garbage);
	deletePolyLine();
}

//경로 새로고침
function newpath(){
	//마커지우기
	deleteMarker();
		
	//배열 다 비우기
	arr = new Array();
	markersArr = [];
	markers = [];
	
	//라인 지우기
	deletePolyLine();
	
	//div 지우기
	$('#path').empty();
	$('#pathlist').empty();
}


function getDetail(contentid, contenttypeid){
	wrapWindowByMask();
	var contentid;
	var contenttypeid;
	var title ="aa";
    $.ajax({        
        url: 'callDetail.do',
        type: 'get',
        data : {"contentId" : contentid, "contentTypeId" : contenttypeid},
        dataType: 'json',
        success: function(data){
             var myItem = data.response.body.items.item;
                var output = '<div class="detailBox" text-align:left>';
                	output += '<h4 class="title">' + title + '</h4>';
                if(contenttypeid == 12){
 	                    output += '<p class="p" >'+'주차장 : ' + myItem.parking+'</p>';
 	                    output += '<p class="p" >' +'휴무일 : ' + myItem.restdate + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenter + '</p>';
                }else if(contenttypeid == 14){
 	                    output += '<p class="p" >'+'입장료 : ' + myItem.usefee+'</p>';
 	                    output += '<p class="p" >'+'운영시간 : ' + myItem.usetimeculture+'</p>';
 	                    output += '<p class="p" >' +'휴무일 : ' + myItem.restdateculture + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenterculture + '</p>';
                }else if(contenttypeid == 15){
 	                    output += '<p class="p" >'+'행사 장소 : ' + myItem.eventplace+'</p>';
 	                    output += '<p class="p" >'+'행사 일정 : ' + myItem.eventstartdate + '~' + myItem.eventenddate +'</p>';
 	                    output += '<p class="p" >' +'행사 시간 : ' + myItem.playtime + '</p>';
 	                    output += '<p class="p" >' +'주최처 : ' + myItem.sponsor1 + " tel) " + myItem.sponsor1tel + '</p>';
                }else if(contenttypeid == 28){
 	                    output += '<p class="p" >'+'운영시간 : ' + myItem.usetimeleports+'</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenterleports + '</p>';
                }else if(contenttypeid == 32){
 	                    output += '<p class="p" >'+'예약 : ' + myItem.reservationurl+'</p>';
 	                    output += '<p class="p" >' +'시설 : ' + myItem.subfacility + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenterlodging + '</p>';
                }else if(contenttypeid == 38){
 	                    output += '<p class="p" >'+'취급물품 : ' + myItem.saleitem+'</p>';
 	                    output += '<p class="p" >'+'운영시간 : ' + myItem.opentime+'</p>';
 	                    output += '<p class="p" >' +'휴무일 : ' + myItem.restdateshopping + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenter + '</p>';
                }else if(contenttypeid == 39){
 	                    output += '<p class="p" >'+'메뉴 : ' + myItem.treatmenu+'</p>';
 	                    output += '<p class="p" >'+'운영시간 : ' + myItem.opentimefood+'</p>';
 	                    output += '<p class="p" >' +'휴무일 : ' + myItem.restdatefood + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenterfood + '</p>';
                }
                output += '</div>';
                $('#window').html(output);
        },
      error: function(XMLHttpRequest, textStatus, errorThrown) { 
          alert("Status: " + textStatus); alert("Error: " + errorThrown); 
      } 
 	});
}



</script>      
</body>
</html>