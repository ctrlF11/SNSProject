<%@page import="com.project.sns.addr.vo.AddrVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
   href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
   href="resources/facebook/assets/css/facebook2.css">
<link rel="stylesheet"
   href="resources/css/map.css">
<script type="text/javascript" src="resources/facebook/assets/js/jquery.js"></script>
<script type="text/javascript" src="resources/facebook/assets/js/bootstrap.js"></script>
<script type="text/javascript">
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
</script>
<style>

.pin{
	background:white;
	overflow:hidden;
	height: auto;
	border: 1px solid black;
	}
	
.p{
	 text-align:left;
	}
	
#getpath{
	background-color: #4CAF50;
	color: white;
	padding: 14px 40px;
	font-size: 16px;
	border-radius: 12px;
	width: auto;
	}
	
#searchBox{
	position: fixed;
	float: right;
	background-color: #4CAF50;
	height : 50px;
	top: 70px;
	right: 35%;
	
	}
	

</style>
<title>TourSNS</title>
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
                     <li><a href="#" data-toggle="offcanvas" class="visible-xs text-center"><i class="glyphicon glyphicon-chevron-right"></i></a></li>
                  </ul>
                  
                  <ul class="nav hidden-xs" id="lg-menu">
                     <li class="active"><a href="#featured"><i class="glyphicon glyphicon-list-alt"></i> </a></li>
                     <li><a href="#stories"><i class="glyphicon glyphicon-list"></i> </a></li>
                     <li><a href="#"><i class="glyphicon glyphicon-paperclip"></i> </a></li>
                     <li><a href="#"><i class="glyphicon glyphicon-refresh"></i> </a></li>
                  </ul>
                  <ul class="list-unstyled hidden-xs" id="sidebar-footer">
                     <li>
                       <a href="http://usebootstrap.com/theme/facebook"><h3>Bootstrap</h3> <i class="glyphicon glyphicon-heart-empty"></i> Bootply</a>
                     </li>
                  </ul>
                 
                  <!-- tiny only nav -->
                  <ul class="nav visible-xs" id="xs-menu">
                     <li><a href="#featured" class="text-center"><i class="glyphicon glyphicon-list-alt"></i></a></li>
                     <li><a href="#stories" class="text-center"><i class="glyphicon glyphicon-list"></i></a></li>
                     <li><a href="#" class="text-center"><i class="glyphicon glyphicon-paperclip"></i></a></li>
                     <li><a href="#" class="text-center"><i class="glyphicon glyphicon-refresh"></i></a></li>
                  </ul>
                 
               </div> 
               <!--
                  col-sm-12, col-xs-12 둘 다 같은 width 설정 class.
                  col-xs-12는 disable된 상태
                  
                  맨 뒤의 숫자를 변경하면(col-sm-10) 회색 화면의 가로가 줄어들어 
                  백그라운드의 회색 화면이 나타남.                  
                -->
            <div id="main" class="column col-sm-10 col-xs-11">
               
               <!-- 
                  Topbar. 기존 부트스트랩보다 height를 늘림.
                -->
               <%@ include file="include/topbar.jsp"%>
   <div id="setDiv">
      <div id="mask"></div>
      <div id="window"></div>
      <div id="mapBox">
      	<div id="searchBox" style="z-index: 2;">
	      <input type="text" id="searchMap" /><input id = "searchMapBtn" type="button" value="검색"/>
		</div>
      	<div id="map" style="z-index: 1;" ></div> 
      </div>
      
      <!-- 오른쪽 사이드 -->  
      <div id="sidemenu">  
      	<button id="getpath" onclick="getpath()">경로 찾기</button> 
      	<div id="path"></div>        
    <!-- 
         <ul class="accodian">  
         <li class="accodian--box">
               <h3>경로</h3>
               <h4><button onclick="recommend()">추천</button></h4>
               <h4>장소</h4>
               <h4>장소</h4>
            </li>
            <li class="accodian--box">
               <h3>경로</h3>
               <h4>장소</h4>
               <h4>장소</h4>
               <h4>장소</h4>
            </li>
            <li class="accodian--box">
               <h3>경로</h3>
               <h4>장소</h4>
               <h4>장소</h4>
               <h4>장소</h4>
            </li>
         </ul>
    -->    
         
      </div>      
   </div>
            </div>         
         </div>
      </div>
   </div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
<!-- 지도 서비스용 (검색)-->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0&libraries=services"></script>
<script>

var arr = new Array(); 

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
        level: 3 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커를 표시할 위치와 title 객체 배열입니다 
var positions =  [
   <%
      List<AddrVO> list = (List<AddrVO>) request.getAttribute("list");
      for (int i = 0; i < 1000; i++) {
   %>
   {title : "<%=list.get(i).getTitle()%>",
    contenttypeid : "<%=list.get(i).getContentTypeId()%>",
    contentid : "<%=list.get(i).getContentId()%>",
    latlng : new daum.maps.LatLng(<%=list.get(i).getMapy()%>,<%=list.get(i).getMapx()%>),
    mapy : "<%=list.get(i).getMapy()%>",
    mapx : "<%=list.get(i).getMapx()%>"
   }

   <%
      if (list.size() - 1 > i) {
            out.append(",");
         }
      }
   %>
   ];

   // 마커 이미지의 이미지 주소입니다
   var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
   
   //for (var i = 0; i < positions.length; i ++) {

   //    addMarker(positions[i].latlng, positions[i].title, positions[i].contentid, positions[i].contenttypeid, positions[i].mapy, positions[i].mapx);
       
   //} 

    // 뒤 검은 마스크를 클릭시에도 모두 제거하도록 처리합니다.
    $('#mask').click(function () {
        $(this).hide();
        $('#window').hide();
    });   
    
    
 function addMarker(position, title, contentid, contenttypeid, mapy, mapx) {   

    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new daum.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new daum.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: position, // 마커를 표시할 위치
        title : title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지

    });
    
    
   
    //마커 클릭시! 
   daum.maps.event.addListener(marker, 'click', function() {
	   
      //wrapWindowByMask();
      var obj = new Object();
      obj.contentId = contentid;
      obj.mapy = mapy;
      obj.mapx = mapx;
      obj.title = title;
      arr.push(obj);
      
      //plusPath(marker);
      $.ajax({        
          url: 'callDetail.do',
          type: 'get',
          data : {"contentId" : contentid, "contentTypeId" : contenttypeid},
          dataType: 'json',
          success: function(data){
               var myItem = data.response.body.items.item;
                  var output = '<div class="pin ' + contentid + '" id="' + contentid + '" text-align:left>';
                  	output += '<h4 id="title">' + title + '</h4>';
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
                  
                  $('#path').append(output);
          },
        error: function(XMLHttpRequest, textStatus, errorThrown) { 
            alert("Status: " + textStatus); alert("Error: " + errorThrown); 
        } 
 	});
   });
   } 
  
 function plusPath(a){
 	contentid = a.contentId;
 	contenttypeid = a.contentTypeId;
	 $.ajax({        
         url: 'callDetail.do',
         type: 'get',
         data : {"contentId" : contentid, "contentTypeId" : contenttypeid},
         dataType: 'json',
         success: function(data){
              var myItem = data.response.body.items.item;
                 var output = '<div class="pin ' + contentid + '" id="' + contentid + '" text-align:left>';
                 output += '<h4 id="title">' + a.title + '</h4>';
                 output += '</div>';
                 
                 $('#path').append(output);
         },
       error: function(XMLHttpRequest, textStatus, errorThrown) { 
           alert("Status: " + textStatus); alert("Error: " + errorThrown); 
       } 
	});
}
 
 
function wrapWindowByMask(){ //화면의 높이와 너비를 구한다.
    
   var maskHeight = $(document).height();
   var maskWidth = $('#map').width(); //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
   
   $('#mask').css({'width':maskWidth,'height':maskHeight});   //마스크의 투명도 처리 
   $('#mask').fadeTo("slow",0.8);

    var left = ( $('#map').scrollLeft() + ( $('#map').width() - $('#window').width()) / 2 );
    var top = ( $('#map').scrollTop() + ( $('#map').height() - $('#window').height()) / 2 ); 
    
    $('#window').css({'left':left,'top':top, 'position':'absolute'});
    
    $('#window').show();
}

	function relocate(id1, id2){
		$('div[id="' + id1 + '"]').insertBefore('div[id="' + id2 + '"]');
	}
   
   
   function getpath(){
	   
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
			   var arra = new Array();
			   arra = data;
			   var linePath = [];
				   $.each(arra, function(i, val){
					   linePath.push(new daum.maps.LatLng(val.mapy, val.mapx));
					   console.log(val);
					   plusPath(val);
				   });
				   console.log(linePath);
			   
			   var polyline = new daum.maps.Polyline({
				    path: linePath, // 선을 구성하는 좌표배열 입니다
				    strokeWeight: 5, // 선의 두께 입니다
				    strokeColor: '#FFAE00', // 선의 색깔입니다
				    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				    strokeStyle: 'solid' // 선의 스타일입니다
				});
			   
			   polyline.setMap(map);
		   }
	   });
   }
   
   function plusAll(array){
   	$('#path').empty();
   	$.each(array, function(i, val){
   		if(i == array.length){return true;}
   		plusPath(val);
   	})
   }
   
 function recommend(mapx, mapy){
   
   $.ajax({        
         url: 'line.do',
         type: 'get',
         dataType: 'json',
         success: function(data){
            alert("성공?");
             
         },
     error: function(XMLHttpRequest, textStatus, errorThrown) { 
         /* alert("Status: " + textStatus); alert("Error: " + errorThrown);  */
     } 
});
} 

 
 $(function(){

		$('#searchMapBtn').click(function(){
			var keyword = $('#searchMap').val();
			$.ajax({
				url:'search.do',
				type: 'POST',
				data: {keyword:keyword},
				success: function(data){
					console.log(data);
					var array = new Array();
					array = data;
					
					
					$.each(array, function(i, val){
						console.log(val);
						var latlng = new daum.maps.LatLng(val.mapY,val.mapX);
						addMarker(latlng, val.title, val.contentId, val.contentTypeId, val.mapY, val.mapX);
						
					})
					  
					  
					  
				}
			})
		})
		
		
		
		
	})

 



// 지도에 선을 표시합니다 
//polyline.setMap(map);    


</script>      
</body>
</html>